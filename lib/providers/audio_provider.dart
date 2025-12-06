import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioProvider extends ChangeNotifier {
  
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;

  AudioProvider() {
    _initAudio();
  }

  Future<void> _initAudio() async {
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.play(AssetSource('audio/thegrid.mp3'));
    
    _isPlaying = true;
    notifyListeners();
  }

  Future<void> toggleAudio() async {
    if (_isPlaying) {
      await _player.pause();
      _isPlaying = false;
    } else {
      await _player.resume();
      _isPlaying = true;
    }
    notifyListeners();
  }


  void handleAppPause() {
    if (_isPlaying) {
      _player.pause();
    }
  }

  void handleAppResume() {
    if (_isPlaying) {
      _player.resume();
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}