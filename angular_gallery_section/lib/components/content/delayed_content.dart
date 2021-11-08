// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:ngcomponents/material_progress/material_progress.dart';

/// `delayed-content` is a simple pass-thru content container which, when
/// initialized, delays the revealing of its content.
///
/// During the delay, the component displays a progress bar.The component does
/// this only once on init, so it illustrates the fact that it is created
/// just-in-time by using [DeferredContentDirective].
///
/// Only use this component in demos.
///
/// __Inputs:__
///
/// - `delay: num` -- Delay in seconds to wait before showing content.
@Component(
  selector: 'delayed-content',
  templateUrl: 'delayed_content.html',
  styleUrls: ['delayed_content.scss.css'],
  directives: [MaterialProgressComponent, NgIf],
  changeDetection: ChangeDetectionStrategy.OnPush,
  // TODO(google): Change preserveWhitespace to false to improve codesize.
  preserveWhitespace: true,
)
class DelayedContentComponent implements OnInit {
  final ChangeDetectorRef _cd;
  bool resolved = true;

  @Input()
  int delay;

  DelayedContentComponent(this._cd);

  @override
  void ngOnInit() {
    if (delay != null) {
      resolved = false;
      Timer(Duration(seconds: delay), _resolve);
    } else {
      resolved = true;
    }
  }

  void _resolve() {
    resolved = true;
    _cd.markForCheck();
  }
}
