import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer/features/favorites/bloc/bloc/favorite_rhymes_bloc.dart';
import 'package:rhymer/features/favorites/widgets/widgets.dart';
import 'package:rhymer/repositories/favorites/favorites.dart';
import 'package:rhymer/ui/ui.dart';
import 'package:rhymer/utils/analytics/analytics.dart';

@RoutePage()
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    BlocProvider.of<FavoriteRhymesBloc>(context).add(LoadFavoriteRhymes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            snap: true,
            floating: true,
            centerTitle: true,
            title: Text('Избранное'),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          BlocBuilder<FavoriteRhymesBloc, FavoriteRhymesState>(
            builder: (context, state) {
              if (state is FavoriteRhymesLoaded) {
                final rhymes = state.rhymes;
                if (rhymes.isEmpty) {
                  return SliverFillRemaining(child: EmptyFavoritesBanner());
                }
                return SliverList.builder(
                  itemCount: rhymes.length,
                  itemBuilder: (context, index) {
                    final rhyme = rhymes[index];
                    return RhymeListCard(
                      isFavorite: true,
                      id: rhyme.id,
                      rhyme: rhyme.favoriteWord,
                      sourceWord: rhyme.queryWord,
                      onTap: () => _toggleFavoriteRhyme(context, rhyme),
                    );
                  },
                );
              }
              return const SliverFillRemaining(
                child: PlatformProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }

  void _toggleFavoriteRhyme(BuildContext context, FavoriteRhyme rhyme) {
    BlocProvider.of<FavoriteRhymesBloc>(context).add(
      DeleteFavoriteRhyme(rhyme),
    );
    Analytics.favorites.toggleFavorite(false);
  }
}
