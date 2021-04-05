
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:measured_size/measured_size.dart';

class FullscreenShrinkingSliver extends StatefulWidget {
  final Widget child;
  FullscreenShrinkingSliver({required this.child});

  @override
  FullscreenShrinkingSliverState createState() => FullscreenShrinkingSliverState();
}

class FullscreenShrinkingSliverState extends State<FullscreenShrinkingSliver> {
  double minExtent = 0.0;

  @override
  Widget build(BuildContext ctx) =>
      SliverPersistentHeader(
        delegate: _SliverFullscreenDelegate(
          minHeight: minExtent,
          maxHeight: MediaQuery.of(ctx).size.height,
          child: Center(child:
          MeasuredSize(onChange: (Size size) {
            setState(() {
              minExtent = size.height;
            });
          }, child: widget.child),),
        ),
      );
}


class _SliverFullscreenDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverFullscreenDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(BuildContext ctx, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverFullscreenDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}