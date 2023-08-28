import 'package:ciernote/Telas/tela_anotacoes_concluidas.dart';
import 'package:ciernote/Telas/tela_cadastro_anotacao.dart';
import 'package:ciernote/Telas/tela_detalhes_anotacao.dart';
import 'package:ciernote/Telas/tela_editar_anotacao.dart';
import 'package:ciernote/Telas/tela_favoritoNotificacao.dart';
import 'package:ciernote/Telas/tela_inicial.dart';
import 'package:ciernote/Uteis/constantes.dart';
import 'package:flutter/material.dart';

class Rotas {
  static Route<dynamic> gerarRotas(RouteSettings settings) {
    final argumentos = settings.arguments;

    switch (settings.name) {
      case Constantes.rotaTelaInicial:
        return MaterialPageRoute(builder: (_) => const TelaInicial());
      case Constantes.rotaTelaCadastroAnotacao:
        return MaterialPageRoute(builder: (_) => const TelaCadastroAnotacao());
      case Constantes.rotaTelaFavorito:
        return MaterialPageRoute(
            builder: (_) => const TelaFavoritoNotificacao());
      case Constantes.rotaTelaAnotacoesConcluidas:
        return MaterialPageRoute(
            builder: (_) => const TelaAnotacoesConcluidas());
      case Constantes.rotaTelaDetalhesAnotacao:
        if (argumentos is Map) {
          return MaterialPageRoute(
              builder: (_) => TelaDetalhesAnotacao(
                  tipoTela: argumentos[Constantes.parametroTipoTela],
                  anotacaoModelo:
                      argumentos[Constantes.parametroTelaDetalhesAnotacao]));
        } else {
          return erroRota(settings);
        }
      case Constantes.rotaTelaEditarAnotacao:
        if (argumentos is Map) {
          return MaterialPageRoute(
              builder: (_) => TelaEditarAnotacao(
                  tipoTela: argumentos[Constantes.parametroTipoTela],
                  anotacaoModelo:
                      argumentos[Constantes.parametroTelaDetalhesAnotacao]));
        } else {
          return erroRota(settings);
        }
    }

    return erroRota(settings);
  }

  //metodo para exibir mensagem de erro
  static Route<dynamic> erroRota(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text("Tela não encontrada!"),
        ),
        body: Container(
          color: Colors.red,
          child: const Center(
            child: Text("Tela não encontrada."),
          ),
        ),
      );
    });
  }
}
