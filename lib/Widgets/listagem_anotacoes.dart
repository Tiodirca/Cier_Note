import 'package:ciernote/Modelo/anotacao.dart';
import 'package:ciernote/Widgets/cards_tarefas_simples.dart';
import 'package:flutter/material.dart';

class ListagemAnotacoes extends StatelessWidget {
  const ListagemAnotacoes(
      {super.key, required this.anotacoes, required this.tipoTela});

  final List<AnotacaoModelo> anotacoes;
  final String tipoTela;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: anotacoes.length,
      itemBuilder: (context, index) {
        return CardsTarefas(
            tipoTela: tipoTela, anotacaoModelo: anotacoes.elementAt(index));
      },
    );
  }
}
