import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_grid/models/models.dart';
import 'package:the_grid/providers/games_provider.dart';
import 'package:the_grid/themes/app_theme.dart';

class GameSearchDelegate extends SearchDelegate {

  @override
  String get searchFieldLabel => 'Search on The Grid...';

  @override
  TextStyle? get searchFieldStyle => const TextStyle(
    color: AppTheme.primary, 
    fontFamily: 'Orbit',
    fontSize: 18
  );

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppTheme.background,
        elevation: 0,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey),
        border: InputBorder.none,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppTheme.primary,
        selectionColor: AppTheme.primary,
      )
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: AppTheme.primary),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: AppTheme.primary),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final gamesProvider = Provider.of<GamesProvider>(context, listen: false);

    return FutureBuilder(
      future: gamesProvider.searchGames(query),
      builder: ( _ , AsyncSnapshot<List<Game>> snapshot) {
        
        if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppTheme.primary));
        }

        if (snapshot.hasError) {
            return const Center(child: Text('Connection error', style: TextStyle(color: AppTheme.error)));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return _emptyContainer();
        }

        final games = snapshot.data!;

        return ListView.builder(
          itemCount: games.length,
          itemBuilder: ( _ , int index) => _MovieItem(game: games[index]),
        );
      },
    );
  }

  Widget _emptyContainer() {
    return Container(
      color: AppTheme.background,
      child: const Center(
        child: Icon(Icons.videogame_asset, color: Colors.black38, size: 130),
      ),
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Game game;

  const _MovieItem({required this.game});

  @override
  Widget build(BuildContext context) {
    game.heroId = 'search-${game.id}';

    return Container(
      color: AppTheme.background,
      child: ListTile(
        leading: Hero(
          tag: game.heroId!,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              game.fullBackgroundImage,
              width: 50,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, color: AppTheme.error),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const SizedBox(
                   width: 50,
                   height: 70,
                   child: Center(child: CircularProgressIndicator(color: AppTheme.primary, strokeWidth: 2))
                );
              },
            ),
          ),
        ),
        title: Text(
          game.name, 
          style: const TextStyle(color: Colors.white, fontFamily: 'Blanka', fontSize: 14)
        ),
        subtitle: Row(
          children: [
            const Icon(Icons.star, color: AppTheme.secondary, size: 14),
            const SizedBox(width: 5),
            Text(
              '${game.rating}', 
              style: const TextStyle(color: AppTheme.secondary, fontFamily: 'Orbit')
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, 'details', arguments: game);
        },
      ),
    );
  }
}