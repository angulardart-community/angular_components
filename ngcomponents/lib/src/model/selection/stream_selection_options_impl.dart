// Copyright (c) 2016-2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

part of ngcomponents.model.selection.selection_options;

class _StreamSelectionOptions<T> extends SelectionOptions<T> {
  StreamSubscription _streamSub;
  _StreamSelectionOptions(Stream<List<OptionGroup<T>>> optionGroupListStream)
      : super([]) {
    _streamSub = optionGroupListStream.listen(_setOptions);
  }

  @override
  void dispose() {
    _streamSub?.cancel();
    super.dispose();
  }
}
