import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

enum MusicalAnimationGroup { group1, group2 }

class MusicalAnimation extends StatefulWidget {
  final StreamController<bool> controller;
  final IconData icon;
  final int delay;
  final MusicalAnimationGroup group;
  final double height;

  const MusicalAnimation({
    required this.controller,
    required this.icon,
    this.delay = 0,
    this.height = 100,
    this.group = MusicalAnimationGroup.group1,
    super.key,
  });

  @override
  _MusicalAnimationState createState() => _MusicalAnimationState();
}

class _MusicalAnimationState extends State<MusicalAnimation> with SingleTickerProviderStateMixin {
  static const Duration animeDuration = Duration(milliseconds: 2000);
  static const Duration opacityDuration = Duration(milliseconds: 350);
  static const double iconSize = 30.0;
  static const double _maxWidth = 40.0;
  static Curve curve = Curves.linear;

  late AnimationController _animationController;
  late Animation<double> _percentAnimation;

  @override
  initState() {
    super.initState();
    _animationController = AnimationController(duration: animeDuration, vsync: this);
    _percentAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.reset();
    _observe();
  }

  void _observe() {
    widget.controller.stream.listen((event) async {
      if (event) {
        await Future.delayed(Duration(milliseconds: widget.delay));
        await _animationController.animateTo(1.0, duration: animeDuration, curve: curve);
        _animationController.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, _) {
          return SizedBox(
            height: widget.height,
            width: _maxWidth + iconSize,
            child: Stack(
              children: [
                Positioned(
                  bottom: _getBottom,
                  left: _getLeft,
                  child: AnimatedOpacity(
                    opacity: _getOpacity,
                    duration: opacityDuration,
                    child: Icon(
                      widget.icon,
                      color: Colors.teal,
                      size: iconSize,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  get _getOpacity {
    if (_percentAnimation.value == 0.0) {
      return 0.0;
    }

    return _percentAnimation.value > 0.50 ? 1.0 - _percentAnimation.value : 1.0;
  }

  double get _getLeft {
    if (widget.group == MusicalAnimationGroup.group2) {
      return _getSecondElementLeft;
    }

    final seno = sin(_percentAnimation.value * 2 * pi);
    final pos = 10 + (seno * (_maxWidth - iconSize));
    return pos;
  }

  double get _getSecondElementLeft {
    final seno = sin(-1.0 * (_percentAnimation.value * 2 * pi)) * 0.5;
    final pos = 30 + (seno * (_maxWidth - iconSize));
    return pos;
  }

  double get _getBottom => _percentAnimation.value * (widget.height - iconSize);
}
