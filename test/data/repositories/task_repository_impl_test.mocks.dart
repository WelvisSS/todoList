// Mocks generated by Mockito 5.4.5 from annotations
// in todolist/test/data/repositories/task_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:todolist/data/models/task_model.dart' as _i4;
import 'package:todolist/data/sources/local/task_dao.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [TaskDao].
///
/// See the documentation for Mockito's code generation for more information.
class MockTaskDao extends _i1.Mock implements _i2.TaskDao {
  @override
  _i3.Future<List<_i4.TaskModel>> getAllTasks() =>
      (super.noSuchMethod(
            Invocation.method(#getAllTasks, []),
            returnValue: _i3.Future<List<_i4.TaskModel>>.value(
              <_i4.TaskModel>[],
            ),
            returnValueForMissingStub: _i3.Future<List<_i4.TaskModel>>.value(
              <_i4.TaskModel>[],
            ),
          )
          as _i3.Future<List<_i4.TaskModel>>);

  @override
  _i3.Future<int> addTask(_i4.TaskModel? task) =>
      (super.noSuchMethod(
            Invocation.method(#addTask, [task]),
            returnValue: _i3.Future<int>.value(0),
            returnValueForMissingStub: _i3.Future<int>.value(0),
          )
          as _i3.Future<int>);

  @override
  _i3.Future<int> updateTask(_i4.TaskModel? task) =>
      (super.noSuchMethod(
            Invocation.method(#updateTask, [task]),
            returnValue: _i3.Future<int>.value(0),
            returnValueForMissingStub: _i3.Future<int>.value(0),
          )
          as _i3.Future<int>);

  @override
  _i3.Future<int> deleteTask(int? id) =>
      (super.noSuchMethod(
            Invocation.method(#deleteTask, [id]),
            returnValue: _i3.Future<int>.value(0),
            returnValueForMissingStub: _i3.Future<int>.value(0),
          )
          as _i3.Future<int>);

  @override
  _i3.Future<int> deleteAllTasks() =>
      (super.noSuchMethod(
            Invocation.method(#deleteAllTasks, []),
            returnValue: _i3.Future<int>.value(0),
            returnValueForMissingStub: _i3.Future<int>.value(0),
          )
          as _i3.Future<int>);
}
