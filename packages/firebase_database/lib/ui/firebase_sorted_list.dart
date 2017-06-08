// Copyright 2017, the Flutter project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:collection';

import 'package:meta/meta.dart';

import '../firebase_database.dart' show DataSnapshot, Event, Query;
import 'firebase_list.dart' show ChildCallback, ValueCallback;
import 'utils/stream_subscriber_mixin.dart';

/// Sorts the results of `query` on the client side using to the `comparator`.
///
// TODO(jackson) We don't support children moving around.
// TODO(jackson) Right now this naively sorting the list after an insert.
// We can be smarter about how we handle insertion and keep the list always
// sorted. See example here:
// https://github.com/firebase/FirebaseUI-iOS/blob/master/FirebaseDatabaseUI/FUISortedArray.m
class FirebaseSortedList extends ListBase<DataSnapshot>
    with StreamSubscriberMixin<Event> {
  FirebaseSortedList({
    @required this.query,
    @required this.comparator,
    this.onChildAdded,
    this.onChildRemoved,
    this.onChildChanged,
    this.onValue,
  }) {
    assert(query != null);
    assert(comparator != null);
    listen(query.onChildAdded, _onChildAdded);
    listen(query.onChildRemoved, _onChildRemoved);
    listen(query.onChildChanged, _onChildChanged);
    listen(query.onValue, _onValue);
  }

  /// Database query used to populate the list
  final Query query;

  /// The comparator used to sort the list on the client side
  final Comparator<DataSnapshot> comparator;

  /// Called when the child has been added
  final ChildCallback onChildAdded;

  /// Called when the child has been removed
  final ChildCallback onChildRemoved;

  /// Called when the child has changed
  final ChildCallback onChildChanged;

  /// Called when the data of the list has finished loading
  final ValueCallback onValue;

  // ListBase implementation
  final List<DataSnapshot> _snapshots = <DataSnapshot>[];

  @override
  int get length => _snapshots.length;

  @override
  set length(int value) {
    throw new UnsupportedError("List cannot be modified.");
  }

  @override
  DataSnapshot operator [](int index) => _snapshots[index];

  @override
  void operator []=(int index, DataSnapshot value) {
    throw new UnsupportedError("List cannot be modified.");
  }

  void _onChildAdded(Event event) {
    _snapshots.add(event.snapshot);
    _snapshots.sort(comparator);
    onChildAdded(_snapshots.indexOf(event.snapshot), event.snapshot);
  }

  void _onChildRemoved(Event event) {
    final DataSnapshot snapshot =
        _snapshots.firstWhere((DataSnapshot snapshot) {
      return snapshot.key == event.snapshot.key;
    });
    final int index = _snapshots.indexOf(snapshot);
    _snapshots.removeAt(index);
    onChildRemoved(index, snapshot);
  }

  void _onChildChanged(Event event) {
    final DataSnapshot snapshot =
        _snapshots.firstWhere((DataSnapshot snapshot) {
      return snapshot.key == event.snapshot.key;
    });
    final int index = _snapshots.indexOf(snapshot);
    this[index] = event.snapshot;
    onChildChanged(index, event.snapshot);
  }

  void _onValue(Event event) {
    onValue(event.snapshot);
  }
}
