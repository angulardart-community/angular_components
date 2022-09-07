// Copyright (c) 2016-2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

import 'package:ngdart/angular.dart';
import 'package:ngcomponents/src/interfaces/has_disabled.dart';
import 'package:ngcomponents/model/menu/menu_item_affix.dart';
import 'package:ngcomponents/model/ui/has_renderer.dart';

/// Base interface for any components that renders a [MenuItemAffix].
abstract class BaseAffixComponent<ModelType extends MenuItemAffix>
    implements RendersValue<ModelType>, HasDisabled {
  ModelType get value;
}

/// Properly typed interface of [MenuItemAffix].
///
/// Please extend this class instead of [MenuItemAffix] directly.
abstract class BaseMenuItemAffixModel
    extends MenuItemAffix<ComponentFactory<BaseAffixComponent>> {
  const BaseMenuItemAffixModel();

  @override
  ComponentFactory<BaseAffixComponent> get componentFactory;
}
