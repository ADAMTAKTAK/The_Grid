import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_grid/models/models.dart';
import 'package:the_grid/providers/games_provider.dart';
import 'package:the_grid/themes/app_theme.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Game game = ModalRoute.of(context)!.settings.arguments as Game;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(game: game),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(game: game),
              _Overview(gameId: game.id),
              const SizedBox(height: 50),
            ]),
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Game game;

  const _CustomAppBar({required this.game});

  @override
  Widget build(BuildContext context) {
    final String heroTag = game.heroId ?? 'no-hero-${game.id}';

    return SliverAppBar(
      backgroundColor: AppTheme.background,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.black54,
          child: Text(
            game.name,
            style: const TextStyle(
              fontSize: 16, 
              fontFamily: 'Blanka', 
              color: AppTheme.primary
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        background: Hero(
          tag: heroTag,
          child: Image.network(
            game.fullBackgroundImage,
            fit: BoxFit.cover,
            color: AppTheme.primary.withValues(alpha: 0.3),
            colorBlendMode: BlendMode.modulate,
          ),
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Game game;

  const _PosterAndTitle({required this.game});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String heroTag = game.heroId ?? 'no-hero-poster-${game.id}';

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: '$heroTag-poster',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.primary)
                ),
                child: Image.network(
                  game.fullBackgroundImage,
                  height: 150,
                  width: 110,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  game.name, 
                  style: const TextStyle(fontSize: 20, fontFamily: 'Blanka'),
                  overflow: TextOverflow.ellipsis, 
                  maxLines: 2
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.star_border, size: 20, color: AppTheme.secondary),
                    const SizedBox(width: 5),
                    Text('${game.rating}', style: textTheme.titleMedium)
                  ],
                ),
                Text('ID: ${game.id}', style: textTheme.bodySmall)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final int gameId;

  const _Overview({required this.gameId});

  @override
  Widget build(BuildContext context) {
    final gamesProvider = Provider.of<GamesProvider>(context, listen: false);

    return FutureBuilder(
      future: gamesProvider.getGameDetails(gameId),
      builder: ( _ , AsyncSnapshot<Game> snapshot) {
        
        if (!snapshot.hasData) {
          return Container(
            height: 150,
            alignment: Alignment.center,
            child: CircularProgressIndicator(color: AppTheme.primary),
          );
        }

        final Game fullGame = snapshot.data!;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('SYNOPSIS', style: TextStyle(
                fontFamily: 'Blanka', 
                fontSize: 18, 
                color: AppTheme.secondary
              )),
              const SizedBox(height: 10),
              Text(
                fullGame.descriptionRaw != null && fullGame.descriptionRaw!.isNotEmpty 
                  ? fullGame.descriptionRaw! 
                  : 'No description available on The Grid.',
                textAlign: TextAlign.justify,
                style: const TextStyle(fontFamily: 'Orbit', fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 20),
              
              if (fullGame.developers != null && fullGame.developers!.isNotEmpty) ...[
                Text('DEVELOPERS', style: TextStyle(
                  fontFamily: 'Blanka', 
                  fontSize: 18, 
                  color: AppTheme.secondary
                )),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: fullGame.developers!.map((dev) => Chip(
                    backgroundColor: Colors.black,
                    side: const BorderSide(color: AppTheme.primary),
                    label: Text(dev, style: const TextStyle(color: Colors.white, fontFamily: 'Orbit')),
                  )).toList(),
                )
              ]
            ],
          ),
        );
      },
    );
  }
}