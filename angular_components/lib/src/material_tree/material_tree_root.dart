// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/model/selection/select.dart';
import 'package:angular_components/model/selection/selection_container.dart';
import 'package:angular_components/model/selection/selection_model.dart';
import 'package:angular_components/model/ui/has_factory.dart';
import 'package:angular_components/utils/disposer/disposer.dart';

// A base class for root tree selectors with output event already configured.
abstract class MaterialTreeRootSelector<T>
    with MaterialTreeRoot<T>, SelectionContainer<T>
    implements OnDestroy {
  final _selectionChanges =
      StreamController<List<SelectionChangeRecord<T>>>.broadcast(sync: true);
  final Disposer _disposer = Disposer.oneShot();

  /// Fired when the selection changes.
  @Output()
  Stream<List<SelectionChangeRecord<T>>> get selectionChanges =>
      _selectionChanges.stream;

  /// The selection model this container represents.
  @Input()
  @override
  set selection(SelectionModel<T> value) {
    if (value != selection) {
      super.selection = value;

      if (value != null) {
        _disposer.addStreamSubscription(
            selection.selectionChanges.listen(_selectionChanges.add));
      }
    }
  }

  @override
  void ngOnDestroy() => _disposer.dispose();
}

/// An limited interface for child groups to use to access the tree.
abstract class MaterialTreeRoot<T>
    implements SelectionContainer<T>, HasFactoryRenderer<RendersValue, T> {
  /// Whether a filter is currently applied.
  bool isFiltered = false;

  /// Whether to hide check-marks in a single select dropdown
  bool get optimizeForDropdown => false;

  /// Fired when the selection changes.
  Stream<List<SelectionChangeRecord<T>>> get selectionChanges;

  /// Whether the widget supports searching the data set.
  ///
  /// When `false`, no search box is shown.
  bool get supportsFiltering => options is Filterable;

  /// Whether the widgets supports expansion and child data sets.
  ///
  /// When `false`, the widget falls back to a simple flat list. This is not a
  /// recommended use case and is provided for graceful failure. If you intend
  /// to use a flat data set consider [MaterialSelect].
  bool get supportsHierarchy => options is Parent;

  /// Whether the widgets supports the selection of non-leaf nodes
  ///
  /// When `false`, and the widget is using a single selection model clicking
  /// the widget should toggle expansion when a non-leaf node is clicked. When
  /// `true` the widget should select non-leaf nodes when clicked and only
  /// toggle expansion when the expansion icon is clicked.
  bool get allowParentSingleSelection => false;

  /// Whether the widgets supports the selection of non-leaf nodes.
  ///
  /// When `false`, and the widget should toggle expansion when a non-leaf
  /// node is clicked. When `true` the widget should select non-leaf nodes
  /// when clicked and only toggle expansion when the expansion icon is clicked.
  bool get allowParentMultiSelection => true;

  /// The previously toggled node.
  T previouslyToggledNode;
}
