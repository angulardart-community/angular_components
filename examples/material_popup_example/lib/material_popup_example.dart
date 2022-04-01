// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

import 'package:angular/angular.dart';
import 'package:angular_components/content.dart';
import 'package:angular_components/laminate/enums/alignment.dart';
import 'package:angular_components/laminate/overlay/module.dart';
import 'package:angular_components/laminate/overlay/zindexer.dart';
import 'package:angular_components/laminate/popup/module.dart';
import 'package:angular_components/laminate/popup/popup.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:angular_components/material_popup/material_popup.dart';
import 'package:angular_components/material_select/material_dropdown_select.dart';
import 'package:angular_components/material_tooltip/material_tooltip.dart';
import 'package:angular_components/model/selection/selection_model.dart';
import 'package:angular_components/model/selection/selection_options.dart';
import 'package:angular_gallery_section/annotation/gallery_section_config.dart';

@GallerySectionConfig(
  displayName: 'Material Popup',
  docs: [MaterialPopupComponent],
  demos: [MaterialPopupExample],
)
class MaterialPopupDemoComponent {}

@Component(
  selector: 'material-popup-example',
  providers: [popupBindings, ClassProvider(ZIndexer)],
  directives: [
    DefaultPopupSizeProvider,
    DeferredContentDirective,
    DontUseRepositionLoopProvider,
    MaterialButtonComponent,
    MaterialDropdownSelectComponent,
    MaterialPopupComponent,
    MaterialTooltipDirective,
    PopupSourceDirective,
  ],
  directiveTypes: [
    Typed<MaterialDropdownSelectComponent<RelativePosition>>(),
  ],
  templateUrl: 'material_popup_example.html',
  styleUrls: ['material_popup_example.scss.css'],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class MaterialPopupExample {
  static final _initialPosition = RelativePosition.OffsetBottomRight;

  // Keep track of each popup's visibility separately.
  final visible = List.filled(11, false);

  final position = RadioGroupSingleSelectionModel(_initialPosition);

  List<RelativePosition> _popupPositions = [_initialPosition];

  List<RelativePosition> get popupPositions {
    final previous = _popupPositions.first;
    final current = position.selectedValues.first;
    if (current != previous) {
      _popupPositions = [current];
    }
    return _popupPositions;
  }

  final positions = SelectionOptions.fromList(positionMap.keys.toList());

  static String positionLabel(RelativePosition position) {
    return positionMap[position];
  }

  String get ddLabel => positionLabel(_popupPositions.first);
}

final positionMap = <RelativePosition, String>{
  RelativePosition.OffsetBottomRight: 'OffsetBottomRight',
  RelativePosition.OffsetBottomLeft: 'OffsetBottomLeft',
  RelativePosition.OffsetTopRight: 'OffsetTopRight',
  RelativePosition.OffsetTopLeft: 'OffsetTopLeft',
  RelativePosition.InlineBottom: 'InlineBottom',
  RelativePosition.InlineBottomLeft: 'InlineBottomLeft',
  RelativePosition.InlineTop: 'InlineTop',
  RelativePosition.InlineTopLeft: 'InlineTopLeft',

  // cardinal directions
  RelativePosition.AdjacentTop: 'AdjacentTop',
  RelativePosition.AdjacentRight: 'AdjacentRight',
  RelativePosition.AdjacentLeft: 'AdjacentLeft',
  RelativePosition.AdjacentBottom: 'AdjacentBottom',
  // non-corners
  RelativePosition.AdjacentTopLeft: 'AdjacentTopLeft',
  RelativePosition.AdjacentTopRight: 'AdjacentTopRight',
  RelativePosition.AdjacentRightTop: 'AdjacentRightTop',
  RelativePosition.AdjacentRightBottom: 'AdjacentRightBottom',
  RelativePosition.AdjacentBottomRight: 'AdjacentBottomRight',
  RelativePosition.AdjacentBottomLeft: 'AdjacentBottomLeft',
  RelativePosition.AdjacentLeftBottom: 'AdjacentLeftBottom',
  RelativePosition.AdjacentLeftTop: 'AdjacentLeftTop',
};

@Injectable()
PopupSizeProvider createPopupSizeProvider() {
  return PercentagePopupSizeProvider();
}

@Directive(
  selector: '[defaultPopupSizeProvider]',
  providers: [FactoryProvider(PopupSizeProvider, createPopupSizeProvider)],
)
class DefaultPopupSizeProvider {}

@Directive(
  selector: '[dontUseRepositionLoop]',
  providers: [
    popupBindings,
    ValueProvider.forToken(overlayRepositionLoop, false),
  ],
)
class DontUseRepositionLoopProvider {}
