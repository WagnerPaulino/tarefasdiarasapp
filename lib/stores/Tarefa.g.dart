// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Tarefa.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TarefaStore on TarefaBase, Store {
  final _$tarefasAtom = Atom(name: 'TarefaBase.tarefas');

  @override
  List<Tarefa> get tarefas {
    _$tarefasAtom.context.enforceReadPolicy(_$tarefasAtom);
    _$tarefasAtom.reportObserved();
    return super.tarefas;
  }

  @override
  set tarefas(List<Tarefa> value) {
    _$tarefasAtom.context.conditionallyRunInAction(() {
      super.tarefas = value;
      _$tarefasAtom.reportChanged();
    }, _$tarefasAtom, name: '${_$tarefasAtom.name}_set');
  }

  final _$TarefaBaseActionController = ActionController(name: 'TarefaBase');

  @override
  Future<void> save(Tarefa tarefa) {
    final _$actionInfo = _$TarefaBaseActionController.startAction();
    try {
      return super.save(tarefa);
    } finally {
      _$TarefaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'tarefas: ${tarefas.toString()}';
    return '{$string}';
  }
}
