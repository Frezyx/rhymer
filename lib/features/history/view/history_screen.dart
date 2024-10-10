import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer/features/history/bloc/history_rhymes_bloc.dart';
import 'package:rhymer/features/history/widgets/widgets.dart';
import 'package:rhymer/features/search/bloc/rhymes_list_bloc.dart';

@RoutePage()
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    BlocProvider.of<HistoryRhymesBloc>(context).add(LoadHistoryRhymes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HistoryRhymesBloc, HistoryRhymesState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              const SliverAppBar(
                snap: true,
                floating: true,
                centerTitle: true,
                title: Text('История'),
                elevation: 0,
                surfaceTintColor: Colors.transparent,
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              if (state is HistoryRhymesLoaded)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 2,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final rhyme = state.rhymes[index];
                        return RhymeHistoryCard(
                          word: rhyme.queryWord,
                          rhymes: rhyme.words,
                          onTap: () => _openSearchScreen(
                            context,
                            rhyme.queryWord,
                          ),
                        );
                      },
                      childCount: state.rhymes.length,
                    ),
                  ),
                )
            ],
          );
        },
      ),
    );
  }

  void _openSearchScreen(BuildContext context, String query) {
    AutoTabsRouter.of(context).setActiveIndex(0);
    context.read<RhymesListBloc>().add(
          SearchRhymes(
            query: query,
            addToHistory: false,
          ),
        );
  }
}
