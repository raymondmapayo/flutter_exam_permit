import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Wraps [child] and animates it in with a fade + slide-up
/// the first time it becomes visible on screen while scrolling.
///
/// Usage:
///
/// RevealOnScroll(
///   child: const HeroSection(),
/// )
///
class RevealOnScroll extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double slideDistance;

  /// Fraction of the widget that must be visible before it triggers.
  /// 0.2 means "animate in once 20% of this widget is on screen".
  final double visibleThreshold;

  const RevealOnScroll({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.slideDistance = 40,
    this.visibleThreshold = 0.2,
  });

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  // Ensures the animation only ever plays once per section,
  // even if the user scrolls past it again later.
  bool _hasPlayed = false;

  // A unique key is required by VisibilityDetector to track this
  // specific widget instance independently from all the others.
  late final Key _visibilityKey;

  @override
  void initState() {
    super.initState();
    _visibilityKey = UniqueKey();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_hasPlayed) return;
    if (info.visibleFraction >= widget.visibleThreshold) {
      _hasPlayed = true;
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          return Opacity(
            opacity: _animation.value,
            child: Transform.translate(
              offset: Offset(0, (1 - _animation.value) * widget.slideDistance),
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}
