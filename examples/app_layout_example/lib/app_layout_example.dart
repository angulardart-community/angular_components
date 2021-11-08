// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:ngcomponents/app_layout/material_persistent_drawer.dart';
import 'package:ngcomponents/content/deferred_content.dart';
import 'package:ngcomponents/material_button/material_button.dart';
import 'package:ngcomponents/material_icon/material_icon.dart';
import 'package:ngcomponents/material_list/material_list.dart';
import 'package:ngcomponents/material_list/material_list_item.dart';
import 'package:ngcomponents/material_toggle/material_toggle.dart';

@Component(
  selector: 'mat-drawer-demo',
  directives: [
    DeferredContentDirective,
    MaterialButtonComponent,
    MaterialIconComponent,
    MaterialPersistentDrawerDirective,
    MaterialToggleComponent,
    MaterialListComponent,
    MaterialListItemComponent,
  ],
  templateUrl: 'app_layout_example.html',
  styleUrls: [
    'app_layout_example.scss.css',
    'package:ngcomponents/app_layout/layout.scss.css',
  ],
)
class MaterialDrawerExample {
  bool customWidth = false;
  bool end = false;
}
