// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Tarefa.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TarefaStore on TarefaBase, Store {
  final _$tarefasAtom = Atom(name: 'TarefaBase.tarefas');

  @override
  List<Tarefa> get tarefas {
    _$tarefasAtom.reportRead();
    return super.tarefas;
  }

  @override
  set tarefas(List<Tarefa> value) {
    _$tarefasAtom.reportWrite(value, super.tarefas, () {
      super.tarefas = value;
    });
  }

  final _$isLoadingListAtom = Atom(name: 'TarefaBase.isLoadingList');

  @override
  bool get isLoadingList {
    _$isLoadingListAtom.reportRead();
    return super.isLoadingList;
  }

  @override
  set isLoadingList(bool value) {
    _$isLoadingListAtom.reportWrite(value, super.isLoadingList, () {
      super.isLoadingList = value;
    });
  }

  final _$isSavingAtom = Atom(name: 'TarefaBase.isSaving');

  @override
  bool get isSaving {
    _$isSavingAtom.reportRead();
    return super.isSaving;
  }

  @override
  set isSaving(bool value) {
    _$isSavingAtom.reportWrite(value, super.isSaving, () {
      super.isSaving = value;
    });
  }

  final _$TarefaBaseActionController = ActionController(name: 'TarefaBase');

  @override
  Future<dynamic> save(Tarefa tarefa) {
    final _$actionInfo =
        _$TarefaBaseActionController.startAction(name: 'TarefaBase.save');
    try {
      return super.save(tarefa);
    } finally {
      _$TarefaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tarefas: ${tarefas},
isLoadingList: ${isLoadingList},
isSaving: ${isSaving}
    ''';
  }
}
