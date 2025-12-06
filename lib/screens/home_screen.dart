import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_grid/providers/games_provider.dart';
import 'package:the_grid/widgets/widgets.dart';
import 'package:the_grid/themes/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gamesProvider = Provider.of<GamesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('THE GRID'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, color: AppTheme.primary),
            onPressed: () {}, 
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: AppTheme.primary),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(games: gamesProvider.onDisplayGames),

            GameSlider(
              games: gamesProvider.popularGames,
              title: 'POPULAR',
              onNextPage: () => gamesProvider.getPopularGames(),
            ),
          
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}