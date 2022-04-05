// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initial_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InitialStore on _InitialStoreBase, Store {
  final _$stateAtom = Atom(name: '_InitialStoreBase.state');

  @override
  InitialState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(InitialState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$checkUserTokenIdAsyncAction =
      AsyncAction('_InitialStoreBase.checkUserTokenId');

  @override
  Future<void> checkUserTokenId() {
    return _$checkUserTokenIdAsyncAction.run(() => super.checkUserTokenId());
  }

  final _$_InitialStoreBaseActionController =
      ActionController(name: '_InitialStoreBase');

  @override
  void update(InitialState newState) {
    final _$actionInfo = _$_InitialStoreBaseActionController.startAction(
        name: '_InitialStoreBase.update');
    try {
      return super.update(newState);
    } finally {
      _$_InitialStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
