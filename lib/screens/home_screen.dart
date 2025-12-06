import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_grid/providers/games_provider.dart';
import 'package:the_grid/widgets/widgets.dart';
import 'package:the_grid/themes/app_theme.dart';
import 'package:the_grid/search/game_search_delegate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gamesProvider = Provider.of<GamesProvider>(context);
    
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('THE GRID'),
        leading: const MusicButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, color: AppTheme.primary),
            onPressed: () => showSearch(context: context, delegate: GameSearchDelegate()),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: AppTheme.primary),
            onPressed: () => Navigator.pushNamed(context, 'info'),
          )
        ],
      ),
      body: isLandscape 
        ? _LandscapeLayout(gamesProvider: gamesProvider)
        : _PortraitLayout(gamesProvider: gamesProvider),
    );
  }
}

class _PortraitLayout extends StatelessWidget {
  final GamesProvider gamesProvider;
  const _PortraitLayout({required this.gamesProvider});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}

class _LandscapeLayout extends StatelessWidget {
  final GamesProvider gamesProvider;
  const _LandscapeLayout({required this.gamesProvider});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Center(child: CardSwiper(games: gamesProvider.onDisplayGames)),
        ),
        Expanded(
          flex: 4,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: GameSlider(
                  games: gamesProvider.popularGames,
                  title: 'POPULAR',
                  onNextPage: () => gamesProvider.getPopularGames(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}