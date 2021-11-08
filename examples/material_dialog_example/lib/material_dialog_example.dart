// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:ngcomponents/auto_dismiss/auto_dismiss.dart';
import 'package:ngcomponents/focus/focus.dart';
import 'package:ngcomponents/laminate/components/modal/modal.dart';
import 'package:ngcomponents/laminate/overlay/module.dart';
import 'package:ngcomponents/material_button/material_button.dart';
import 'package:ngcomponents/material_dialog/material_dialog.dart';
import 'package:ngcomponents/material_icon/material_icon.dart';
import 'package:ngcomponents/material_tooltip/material_tooltip.dart';
import 'package:angular_gallery_section/annotation/gallery_section_config.dart';

@GallerySectionConfig(
  displayName: 'Material Dialog',
  docs: [MaterialDialogComponent],
  demos: [MaterialDialogExample],
)
class MaterialDialogGalleryConfig {}

@Component(
  selector: 'material-dialog-example',
  providers: [overlayBindings],
  directives: [
    AutoDismissDirective,
    AutoFocusDirective,
    MaterialIconComponent,
    MaterialButtonComponent,
    MaterialTooltipDirective,
    MaterialDialogComponent,
    ModalComponent,
    NgFor,
    NgIf
  ],
  templateUrl: 'material_dialog_example.html',
  styleUrls: ['material_dialog_example.scss.css'],
)
class MaterialDialogExample {
  bool showBasicDialog = false;
  bool showBasicScrollingDialog = false;
  bool showMaxHeightDialog = false;
  bool showHeaderedDialog = false;
  bool showInfoDialog = false;
  bool showDialogWithError = false;
  bool showDialogWithTooltip = false;
  bool showCustomColorsDialog = false;
  bool showAutoDismissDialog = false;
  bool showNoHeaderFooterDialog = false;
  bool showFullscreenDialog = false;

  bool isInFullscreenMode = false;

  final maxHeightDialogLines = <String>[];
  String dialogWithErrorErrorMessage;

  void addMaxHeightDialogLine() {
    maxHeightDialogLines.add('This is some text!');
  }

  void removeMaxHeightDialogLine() {
    maxHeightDialogLines.removeLast();
  }

  void toggleErrorMessage() {
    if (dialogWithErrorErrorMessage == null) {
      dialogWithErrorErrorMessage = 'Error message.';
    } else {
      dialogWithErrorErrorMessage = null;
    }
  }
}
