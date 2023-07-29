import 'dart:async';

import 'package:animation_musical_notes/musical_animation.dart';
import 'package:animation_musical_notes/musical_icons.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final StreamController<bool> _controller = StreamController.broadcast();
  static const double animeHeight = 120.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: [
                MusicalAnimation(
                  controller: _controller,
                  delay: 0,
                  icon: MusicalIcons.musical1,
                  height: animeHeight,
                ),
                MusicalAnimation(
                  controller: _controller,
                  delay: 1200,
                  icon: MusicalIcons.musical1,
                  group: MusicalAnimationGroup.group2,
                  height: animeHeight,
                ),
                MusicalAnimation(
                  controller: _controller,
                  delay: 850,
                  icon: MusicalIcons.musical2,
                  group: MusicalAnimationGroup.group1,
                  height: animeHeight,
                ),
                MusicalAnimation(
                  controller: _controller,
                  delay: 1660,
                  icon: MusicalIcons.musical2,
                  group: MusicalAnimationGroup.group2,
                  height: animeHeight,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => _animate(),
              child: const Text('Animate'),
            ),
          ],
        ),
      ),
    );
  }

  void _animate() {
    _controller.add(true);
  }
}
