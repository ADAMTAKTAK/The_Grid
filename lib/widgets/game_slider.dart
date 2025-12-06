import 'package:flutter/material.dart';
import 'package:the_grid/models/models.dart';
import 'package:the_grid/themes/app_theme.dart';

class GameSlider extends StatefulWidget {
  final List<Game> games;
  final String? title;
  final Function onNextPage;

  const GameSlider({
    super.key,
    required this.games,
    this.title,
    required this.onNextPage,
  });

  @override
  State<GameSlider> createState() => _GameSliderState();
}

class _GameSliderState extends State<GameSlider> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.title!,
                style: const TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                  fontFamily: 'Blanka', 
                  color: AppTheme.secondary 
                ),
              ),
            ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.games.length,
              itemBuilder: (context, index) => _GamePoster(
                game: widget.games[index],
                heroId: '${widget.title}-$index-${widget.games[index].id}',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GamePoster extends StatelessWidget {
  final Game game;
  final String heroId;

  const _GamePoster({required this.game, required this.heroId});

  @override
  Widget build(BuildContext context) {
    game.heroId = heroId;

    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Hero(
              tag: game.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  game.fullBackgroundImage,
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const SizedBox(
                      width: 130, height: 190,
                      child: Center(child: CircularProgressIndicator(color: AppTheme.primary)),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            game.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: 'Orbit', fontSize: 12),
          )
        ],
      ),
    );
  }
}