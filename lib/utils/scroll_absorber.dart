import 'package:demo/keys/keys.dart';
import 'package:flutter/material.dart';

class ScrollAbsorber {
  static void absorbScrollNotification(Notification notification) {
    NestedScrollView nestedScrollView =
        Keys.nestedScrollViewKey.currentWidget as NestedScrollView;
    double scrolled = 0;

    //We just need absorb the vertical scroll
    if (notification is OverscrollNotification) {
      if (notification.metrics.axis == Axis.vertical)
        scrolled = notification.overscroll;
    }
    if (notification is ScrollUpdateNotification) {
      if (notification.metrics.axis == Axis.vertical)
        scrolled = notification.scrollDelta ?? 0;
    }

    ScrollController primaryScrollController = nestedScrollView.controller!;
    primaryScrollController.jumpTo(primaryScrollController.offset + scrolled);
  }
}
