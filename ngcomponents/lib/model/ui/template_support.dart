// Copyright (c) 2016-2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

import 'package:ngdart/angular.dart';

/// Function for use by NgFor for optionGroup to avoid recreating the
/// DOM for the optionGroup.
final TrackByFn indexIdentityFn = (num index, dynamic _) => index;
