import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_grid/providers/games_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gamesProvider = Provider.of<GamesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('The Grid - Core System'),
      ),
      body: gamesProvider.onDisplayGames.isEmpty 
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: gamesProvider.onDisplayGames.length,
            itemBuilder: (context, index) {
              final game = gamesProvider.onDisplayGames[index];
              return ListTile(
                leading: Image.network(game.fullBackgroundImage, width: 50, fit: BoxFit.cover),
                title: Text(game.name),
                subtitle: Text('Rating: ${game.rating}'),
              );
            },
          ),
    );
  }
}