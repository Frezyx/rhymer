import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer/features/favorites/bloc/bloc/favorite_rhymes_bloc.dart';
import 'package:rhymer/features/history/bloc/history_rhymes_bloc.dart';
import 'package:rhymer/features/search/bloc/rhymes_list_bloc.dart';
import 'package:rhymer/features/search/widgets/widgets.dart';
import 'package:rhymer/repositories/favorites/favorites.dart';
import 'package:rhymer/repositories/notifications/notifications.dart';
import 'package:rhymer/repositories/rhymes/models/models.dart';
import 'package:rhymer/ui/ui.dart';
import 'package:rhymer/utils/analytics/analytics_service.dart';
import 'package:talker_flutter/talker_flutter.dart';

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
    final talker = context.read<Talker>();
    final repository = context.read<NotificationsRepositoryI>();
    final result = await repository.requestPermisison();
    if (result) {
      repository.getToken().then((token) => talker.info(token ?? '...'));
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
            centerTitle: true,
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
                        child: SearchTextField(
                          controller: _searchController,
                          onSubmitted: (value) => _onTapSearch(context),
                          onEditingComplete: _onEditingCompleted,
                          onClearTap: _onClearTap,
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
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: BlocBuilder<HistoryRhymesBloc, HistoryRhymesState>(
              builder: (context, state) {
                if (state is! HistoryRhymesLoaded || state.rhymes.isEmpty) {
                  return const SizedBox();
                }
                final history = state.rhymes;
                return SizedBox(
                  height: 58,
                  child: RhymesHistoryCarousel(
                    history: history,
                    onItemTap: (rhyme) => _showHistoryRhymes(
                      context,
                      rhyme.queryWord,
                    ),
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
                final rhymes = rhymesModel.rhymes;
                return SliverList.builder(
                  itemCount: rhymes.length,
                  itemBuilder: (context, index) {
                    final rhyme = rhymes[index];
                    final favorite = state.favorite(rhyme);
                    return RhymeListCard(
                      rhyme: rhyme,
                      isFavorite: favorite != null,
                      onCopied: _onRhymeCopied,
                      onLikeTap: () => _toggleFavorite(
                        context,
                        rhymesModel,
                        rhyme,
                        favorite,
                      ),
                    );
                  },
                );
              }
              if (state is RhymesListInitial) {
                return const SliverFillRemaining(
                  child: RhymesListInitialBanner(),
                );
              }
              if (state is RhymesStressedCharsSelection) {
                return SliverToBoxAdapter(
                  child: StressedCharSelector(
                    query: state.query,
                    stressedChars: state.stressedChars,
                    onCharSelected: (query) => _fetchQuery(context, query),
                  ),
                );
              }
              return const SliverFillRemaining(
                child: Center(child: PlatformProgressIndicator()),
              );
            },
          )
        ],
      ),
    );
  }

  void _onRhymeCopied() {
    Analytics.i.log(Analytics.search.copyRhyme);
  }

  void _onClearTap() {
    Analytics.i.log(Analytics.search.clearTap);
  }

  void _onEditingCompleted() {
    Analytics.i.log(Analytics.search.completeEditing);
  }

  void _showHistoryRhymes(BuildContext context, String query) {
    AutoTabsRouter.of(context).setActiveIndex(0);
    context.read<RhymesListBloc>().add(
          SearchRhymes(query: query, addToHistory: false),
        );
    Analytics.i.log(Analytics.history.tapRhyme);
  }

  void _onTapSearch(BuildContext context) {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _fetchQuery(context, query);
    }
  }

  void _fetchQuery(BuildContext context, String query) {
    context.read<RhymesListBloc>().add(SearchRhymes(query: query));
    Analytics.i.log(Analytics.search.rhyme);
  }

  Future<void> _toggleFavorite(
    BuildContext context,
    Rhymes rhymes,
    String currentRhyme,
    FavoriteRhyme? favorite,
  ) async {
    final rhymesListBloc = BlocProvider.of<RhymesListBloc>(context);
    final favoriteRhymesBloc = BlocProvider.of<FavoriteRhymesBloc>(context);

    final completer = Completer();
    rhymesListBloc.add(
      ToggleFavoriteRhymes(
        favorite: favorite,
        rhymes: rhymes,
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
      context.read<HistoryRhymesBloc>().add(LoadHistoryRhymes());
    }
  }
}
