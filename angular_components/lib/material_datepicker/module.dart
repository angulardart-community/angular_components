// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

import 'package:angular/angular.dart';
import 'package:quiver/time.dart';
import 'package:angular_components/laminate/popup/module.dart';
import 'package:angular_components/model/date/time_zone_aware_clock.dart';

const clockValue = Clock();

const datepickerClock = OpaqueToken<Clock>(
    'third_party.dart_src.acx.material_datepicker.datepickerClock');

/// Standard bindings needed by material datepicker components.
///
/// The provided [Clock], and the datepicker itself, will both use the system
/// time zone. Use [timeZoneAwareDatepickerModule] if you need to set a
/// custom time zone.
const datepickerBindings = [
  popupBindings,
  _legacyClockBinding,
  ExistingProvider.forToken(datepickerClock, Clock),
];

const timeZoneAwareDatepickerModule =
    Module(include: [timeZoneAwareClockModule], provide: _sharedClockBindings);

const _sharedClockBindings = [
  _legacyClockBinding,
  ExistingProvider.forToken(datepickerClock, TimeZoneAwareClock),
];

/// Binding for [Clock] without annotations. The datepicker no longer needs
/// this, but some clients may depend on having this here still.
// TODO(google): Remove this and fix clients.
const _legacyClockBinding = Provider(Clock, useValue: clockValue);
