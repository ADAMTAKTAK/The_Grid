import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_grid/providers/audio_provider.dart';
import 'package:the_grid/themes/app_theme.dart';

class MusicButton extends StatelessWidget {
  const MusicButton({super.key});

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);

    return IconButton(
      icon: Icon(
        audioProvider.isPlaying ? Icons.graphic_eq : Icons.volume_off,
        color: audioProvider.isPlaying ? AppTheme.primary : Colors.grey,
      ),
      onPressed: () {
        audioProvider.toggleAudio();
      },
      tooltip: 'Audio Control',
    );
  }
}