import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer/api/models/rhymes.dart';
import 'package:rhymer/features/favorites/bloc/bloc/favorite_rhymes_bloc.dart';
import 'package:rhymer/features/history/bloc/history_rhymes_bloc.dart';
import 'package:rhymer/features/search/bloc/rhymes_list_bloc.dart';
import 'package:rhymer/features/search/widgets/widgets.dart';
import 'package:rhymer/ui/ui.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<HistoryRhymesBloc>(context).add(LoadHistoryRhymes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          snap: true,
          floating: true,
          centerTitle: true,
          title: const Text('Rhymer'),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: SearchButtion(
              controller: _searchController,
              onTap: () => _showSearchBottomSheet(context),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: BlocBuilder<HistoryRhymesBloc, HistoryRhymesState>(
            builder: (context, state) {
              if (state is! HistoryRhymesLoaded) return const SizedBox();
              return SizedBox(
                height: 100,
                child: ListView.separated(
                  padding: const EdgeInsets.only(left: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.rhymes.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final rhymes = state.rhymes[index];
                    return RhymeHistoryCard(
                      rhymes: rhymes.words,
                      word: rhymes.word,
                    );
                  },
                ),
              );
            },
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        BlocConsumer<RhymesListBloc, RhymesListState>(
          listener: _handleRhymesListState,
          builder: (context, state) {
            if (state is RhymesListLoaded) {
              final rhymesModel = state.rhymes;
              final rhymes = rhymesModel.words;
              return SliverList.builder(
                itemCount: rhymes.length,
                itemBuilder: (context, index) {
                  final rhyme = rhymes[index];
                  return RhymeListCard(
                    rhyme: rhyme,
                    isFavorite: state.isFavorite(rhyme),
                    onTap: () =>
                        _toggleFavorite(context, rhymesModel, state, rhyme),
                  );
                },
              );
            }
            if (state is RhymesListInitial) {
              return const SliverFillRemaining(
                child: RhymesListInitialBanner(),
              );
            }
            return const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        )
      ],
    );
  }

  Future<void> _toggleFavorite(
    BuildContext context,
    Rhymes rhymesModel,
    RhymesListLoaded state,
    String currentRhyme,
  ) async {
    final rhymesListBloc = BlocProvider.of<RhymesListBloc>(context);
    final favoriteRhymesBloc = BlocProvider.of<FavoriteRhymesBloc>(context);

    final completer = Completer();
    rhymesListBloc.add(
      ToggleFavoriteRhymes(
        rhymes: rhymesModel,
        query: state.query,
        favoriteWord: currentRhyme,
        completer: completer,
      ),
    );
    await completer.future;
    favoriteRhymesBloc.add(LoadFavoriteRhymes());
  }

  void _handleRhymesListState(
    BuildContext context,
    RhymesListState state,
  ) {
    if (state is RhymesListLoaded) {
      BlocProvider.of<HistoryRhymesBloc>(context).add(LoadHistoryRhymes());
    }
  }

  Future<void> _showSearchBottomSheet(BuildContext context) async {
    final bloc = BlocProvider.of<RhymesListBloc>(context);
    final query = await showModalBottomSheet<String>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.only(top: 60),
        child: SearchRhymesBottomSheet(
          controller: _searchController,
        ),
      ),
    );
    if (query?.isNotEmpty ?? false) {
      bloc.add(SearchRhymes(query: query!));
    }
  }
}
