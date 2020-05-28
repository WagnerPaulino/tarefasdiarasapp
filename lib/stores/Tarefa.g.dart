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
    _$tarefasAtom.reportRead();
    return super.tarefas;
  }

  @override
  set tarefas(List<Tarefa> value) {
    _$tarefasAtom.reportWrite(value, super.tarefas, () {
      super.tarefas = value;
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
tarefas: ${tarefas}
    ''';
  }
}
