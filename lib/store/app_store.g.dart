// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on _AppStore, Store {
  final _$listDataBacAtom = Atom(name: '_AppStore.listDataBac');

  @override
  ObservableList<Data> get listDataBac {
    _$listDataBacAtom.reportRead();
    return super.listDataBac;
  }

  @override
  set listDataBac(ObservableList<Data> value) {
    _$listDataBacAtom.reportWrite(value, super.listDataBac, () {
      super.listDataBac = value;
    });
  }

  final _$listDataNamAtom = Atom(name: '_AppStore.listDataNam');

  @override
  ObservableList<Data> get listDataNam {
    _$listDataNamAtom.reportRead();
    return super.listDataNam;
  }

  @override
  set listDataNam(ObservableList<Data> value) {
    _$listDataNamAtom.reportWrite(value, super.listDataNam, () {
      super.listDataNam = value;
    });
  }

  final _$isBacAtom = Atom(name: '_AppStore.isBac');

  @override
  bool get isBac {
    _$isBacAtom.reportRead();
    return super.isBac;
  }

  @override
  set isBac(bool value) {
    _$isBacAtom.reportWrite(value, super.isBac, () {
      super.isBac = value;
    });
  }

  final _$loadLocalAsyncAction = AsyncAction('_AppStore.loadLocal');

  @override
  Future loadLocal() {
    return _$loadLocalAsyncAction.run(() => super.loadLocal());
  }

  final _$_AppStoreActionController = ActionController(name: '_AppStore');

  @override
  dynamic setIsBac(bool value) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setIsBac');
    try {
      return super.setIsBac(value);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateDataBac(List<Data> data) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.updateDataBac');
    try {
      return super.updateDataBac(data);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateDataNam(List<Data> data) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.updateDataNam');
    try {
      return super.updateDataNam(data);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listDataBac: ${listDataBac},
listDataNam: ${listDataNam},
isBac: ${isBac}
    ''';
  }
}
