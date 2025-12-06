import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:the_grid/models/models.dart';
import 'package:the_grid/themes/app_theme.dart';

class CardSwiper extends StatelessWidget {
  final List<Game> games;

  const CardSwiper({super.key, required this.games});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    if (games.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(child: CircularProgressIndicator(color: AppTheme.primary)),
      );
    }

    final swiperHeight = isLandscape ? size.height * 0.6 : size.height * 0.5;
    final cardWidth = swiperHeight * 0.7; 

    return Container(
      width: double.infinity,
      height: swiperHeight,
      padding: const EdgeInsets.only(top: 10),
      child: Swiper(
        itemCount: games.length,
        layout: SwiperLayout.STACK,
        itemWidth: cardWidth,
        itemHeight: swiperHeight * 0.9,
        itemBuilder: (context, index) {
          final game = games[index];
          game.heroId = 'swiper-${game.id}'; 

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: game),
            child: Hero(
              tag: game.heroId!,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppTheme.primary.withValues(alpha: 0.5), 
                    width: 2
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withValues(alpha: 0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    game.fullBackgroundImage,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(color: AppTheme.primary),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}