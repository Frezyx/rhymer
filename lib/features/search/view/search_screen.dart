import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer/api/models/rhymes.dart';
import 'package:rhymer/features/favorites/bloc/bloc/favorite_rhymes_bloc.dart';
import 'package:rhymer/features/history/bloc/history_rhymes_bloc.dart';
import 'package:rhymer/features/search/bloc/rhymes_list_bloc.dart';
import 'package:rhymer/features/search/widgets/widgets.dart';
import 'package:rhymer/repositories/notifications/notifications.dart';
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
    _initNotifications();
    super.initState();
  }

  Future<void> _initNotifications() async {
    final repository = context.read<NotificationsRepositoryI>();
    final result = await repository.requestPermisison();
    if (result) {
      repository.getToken().then((token) => log(token ?? '...'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: theme.cardColor,
            pinned: true,
            snap: true,
            floating: true,
            title: const Text('Rhymer'),
            elevation: 0,
            toolbarHeight: 30,
            surfaceTintColor: Colors.transparent,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(88),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.hintColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: _searchController,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) => _onTapSearch(context),
                          decoration: InputDecoration(
                            hintText: 'Начни вводить слово...',
                            hintStyle: TextStyle(
                              color: theme.hintColor.withOpacity(0.5),
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _onTapSearch(context),
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // SearchButtion(
              //   controller: _searchController,
              //   onTap: () => _showSearchBottomSheet(context),
              // ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: BlocBuilder<HistoryRhymesBloc, HistoryRhymesState>(
              builder: (context, state) {
                if (state is! HistoryRhymesLoaded || state.rhymes.isEmpty) {
                  return const SizedBox();
                }
                final history = state.rhymes.reversed.toList();
                return SizedBox(
                  height: 58,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(left: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: history.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 8,
                    ),
                    itemBuilder: (context, index) {
                      final rhymes = history[index];
                      return RhymeHistoryCarouselCard(
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
      ),
    );
  }

  void _onTapSearch(BuildContext context) {
    final bloc = BlocProvider.of<RhymesListBloc>(context);
    final query = _searchController.text;
    if (query.isNotEmpty) {
      bloc.add(SearchRhymes(query: query));
    }
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

  // Future<void> _showSearchBottomSheet(BuildContext context) async {
  //   final bloc = BlocProvider.of<RhymesListBloc>(context);

  //   final query = await showModalBottomSheet<String>(
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     elevation: 0,
  //     context: context,
  //     builder: (context) => Padding(
  //       padding: const EdgeInsets.only(top: 60),
  //       child: SearchRhymesBottomSheet(
  //         controller: _searchController,
  //       ),
  //     ),
  //   );
  //   if (query?.isNotEmpty ?? false) {
  //     bloc.add(SearchRhymes(query: query!));
  //   }
  // }
}
