// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:angular/angular.dart';
import 'package:ngcomponents/content/deferred_content.dart';
import 'package:ngcomponents/focus/focus.dart';
import 'package:ngcomponents/focus/focus_trap.dart';
import 'package:ngcomponents/laminate/popup/popup.dart';
import 'package:ngcomponents/material_list/material_list.dart';
import 'package:ngcomponents/material_menu/menu_item_groups.dart';
import 'package:ngcomponents/material_menu/menu_popup_wrapper.dart';
import 'package:ngcomponents/material_menu/menu_root.dart';
import 'package:ngcomponents/material_popup/material_popup.dart';
import 'package:ngcomponents/mixins/focusable_mixin.dart';
import 'package:ngcomponents/model/menu/menu.dart';
import 'package:ngcomponents/utils/angular/css/css.dart';

/// A popup that renders a [MenuModel] using a [MenuItemGroupsComponent].
@Component(
    selector: 'menu-popup',
    directives: [
      AutoFocusDirective,
      DeferredContentDirective,
      FocusTrapComponent,
      MaterialListComponent,
      MaterialPopupComponent,
      MenuItemGroupsComponent,
      MenuRootDirective,
      NgIf,
    ],
    templateUrl: 'menu_popup.html',
    styleUrls: ['menu_popup.scss.css'],
    changeDetection: ChangeDetectionStrategy.OnPush)
class MenuPopupComponent extends Object with FocusableMixin, MenuPopupWrapper {
  HtmlElement element;

  @Input()
  PopupSource popupSource;

  /// CSS classes to append onto the menu popup.
  ///
  /// These CSS classes will be copied into the popup overlay. The classes can
  /// be used to select DOM elements within the overlay when the popup is open.
  @Input()
  set popupClass(String value) {
    _popupClass = constructEncapsulatedCss(value, element.classes);
  }

  String get popupClass => _popupClass;
  String _popupClass;

  MenuPopupComponent(this.element);

  @ViewChild(MenuItemGroupsComponent)
  set menuItemGroups(MenuItemGroupsComponent groups) {
    focusable = groups;
  }
}
