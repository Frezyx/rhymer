import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rhymer/bloc/theme/theme_cubit.dart';
import 'package:rhymer/features/history/bloc/history_rhymes_bloc.dart';
import 'package:rhymer/features/settings/widgets/widgets.dart';
import 'package:rhymer/ui/ui.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? _appInfoString;

  @override
  void initState() {
    _loadAppVersion();
    super.initState();
  }

  Future<void> _loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    _appInfoString =
        '${packageInfo.appName} v${packageInfo.version} (${packageInfo.buildNumber})';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = context.watch<ThemeCubit>().state.isDark;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            snap: true,
            floating: true,
            centerTitle: true,
            title: Text('Настройки'),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: SettingsToggleCard(
              title: 'Темная тема',
              value: isDarkTheme,
              onChanged: (value) => _setThemeBrightness(context, value),
            ),
          ),
          // SliverToBoxAdapter(
          //   child: SettingsToggleCard(
          //     title: 'Уведомления',
          //     value: false,
          //     onChanged: (value) {},
          //   ),
          // ),
          // SliverToBoxAdapter(
          //   child: SettingsToggleCard(
          //     title: 'Разрешить аналитику',
          //     value: true,
          //     onChanged: (value) {},
          //   ),
          // ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: SettingsActionCard(
              title: 'Очистить историю',
              iconData: Icons.delete_sweep_outlined,
              iconColor: Theme.of(context).primaryColor,
              onTap: () => _confirmClearHistory(context),
            ),
          ),
          SliverToBoxAdapter(
            child: SettingsActionCard(
              title: 'Поддержка',
              iconData: Icons.message_outlined,
              onTap: () => _openSupport(context),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _appInfoString != null
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _appInfoString!,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : null,
    );
  }

  void _openSupport(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.isAndroid) {
      showModalBottomSheet(
        context: context,
        builder: (context) => const SupportBottomSheet(),
      );
      return;
    }
    showCupertinoModalPopup(
      context: context,
      builder: (context) => const SupportBottomSheet(),
    );
  }

  void _setThemeBrightness(BuildContext context, bool value) {
    context.read<ThemeCubit>().setThemeBrightness(
          value ? Brightness.dark : Brightness.light,
        );
  }

  void _confirmClearHistory(BuildContext context) {
    final theme = Theme.of(context);
    final dialog = ConfirmationDialog(
      title: 'Вы уверены?',
      description: 'Ваши данные будут безвозвратно удалены',
      onConfirm: () => _clearHistory(context),
    );
    if (theme.isAndroid) {
      showDialog(context: context, builder: (context) => dialog);
      return;
    }
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => dialog,
    );
  }

  void _clearHistory(BuildContext context) {
    BlocProvider.of<HistoryRhymesBloc>(context).add(ClearRhymesHistory());
  }
}
