import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_grid/providers/audio_provider.dart';

class LifecycleManager extends StatefulWidget {
  final Widget child;
  
  const LifecycleManager({super.key, required this.child});

  @override
  State<LifecycleManager> createState() => _LifecycleManagerState();
}

class _LifecycleManagerState extends State<LifecycleManager> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final audioProvider = Provider.of<AudioProvider>(context, listen: false);

    switch (state) {
      case AppLifecycleState.paused: 
        audioProvider.handleAppPause();
        break;
      case AppLifecycleState.resumed: 
        audioProvider.handleAppResume();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}