import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer/app/app.dart';
import 'package:rhymer/bloc/theme/theme_cubit.dart';
import 'package:rhymer/router/router.dart';
import 'package:rhymer/ui/ui.dart';

class RhymerApp extends StatefulWidget {
  const RhymerApp({
    super.key,
    required this.config,
  });

  final AppConfig config;

  @override
  State<RhymerApp> createState() => _RhymerAppState();
}

class _RhymerAppState extends State<RhymerApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return AppInitializer(
      config: widget.config,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Rhymer',
            theme: state.isDark ? darkTheme : lightTheme,
            routerConfig: _router.config(),
          );
        },
      ),
    );
  }
}
