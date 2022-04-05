// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_account_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CreateAccountStore on _CreateAccountStoreBase, Store {
  final _$stateAtom = Atom(name: '_CreateAccountStoreBase.state');

  @override
  CreateAccountState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(CreateAccountState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$_CreateAccountStoreBaseActionController =
      ActionController(name: '_CreateAccountStoreBase');

  @override
  void update(CreateAccountState newState) {
    final _$actionInfo = _$_CreateAccountStoreBaseActionController.startAction(
        name: '_CreateAccountStoreBase.update');
    try {
      return super.update(newState);
    } finally {
      _$_CreateAccountStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
