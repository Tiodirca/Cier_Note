import 'package:ciernote/Modelo/anotacao.dart';
import 'package:ciernote/Uteis/BancoDados/banco_dados.dart';
import 'package:ciernote/Uteis/metodos_auxiliares.dart';
import 'package:ciernote/Uteis/constantes.dart';
import 'package:ciernote/Uteis/paleta_cores.dart';
import 'package:ciernote/Uteis/textos.dart';
import 'package:flutter/material.dart';

class BarraNavegacao extends StatelessWidget {
  const BarraNavegacao({
    super.key,
    required this.tipoAcao,
  });

  final String tipoAcao;

  //variavel usada para validar o formulario

  static AnotacaoModelo anotacaoModelo = AnotacaoModelo.vazia();

  Widget botao(IconData iconData, String tipoAcao, BuildContext context) =>
      SizedBox(
        height: 50,
        width: 50,
        child: FloatingActionButton(
            heroTag: iconData.toString(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: PaletaCores.corVerdeClaro,
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (tipoAcao == Constantes.tipoAcaoFiltrarFavoritoNotificacao) {
                  return Center(
                      child: Row(
                    children: [
                      Icon(Icons.favorite_outlined,
                          size: 25, color: PaletaCores.corAzul),
                      Icon(Icons.notifications,
                          size: 25, color: PaletaCores.corAzul),
                    ],
                  ));
                } else {
                  return Center(
                    child: Icon(iconData, size: 30, color: PaletaCores.corAzul),
                  );
                }
              },
            ),
            onPressed: () {
              if (tipoAcao == Constantes.rotaTelaInicial) {
                Navigator.popAndPushNamed(context, Constantes.rotaTelaInicial);
              } else if (tipoAcao ==
                  Constantes.tipoAcaoFiltrarFavoritoNotificacao) {
                Navigator.popAndPushNamed(context, Constantes.rotaTelaFavorito);
              } else if (tipoAcao == Constantes.rotaTelaAnotacoesConcluidas) {
                Navigator.popAndPushNamed(
                    context, Constantes.rotaTelaAnotacoesConcluidas);
              }
            }),
      );

  Widget botaoAcao(IconData iconData, BuildContext context) => SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
            heroTag: "btnAcao$iconData",
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: PaletaCores.corVerdeClaro,
            child: Icon(iconData, size: 40, color: PaletaCores.corAzul),
            onPressed: () async {
              if (tipoAcao == Constantes.tipoAcaoSalvarAnotacao) {
                pegarValores(context);
              } else if (tipoAcao == Constantes.tipoAcaoAdicao) {
                Navigator.pushReplacementNamed(
                    context, Constantes.rotaTelaCadastroAnotacao);
              } else {
                Map dados = {};
                dados[Constantes.parametroTelaDetalhesAnotacao] =
                    anotacaoModelo;
                Navigator.pushReplacementNamed(
                    context, Constantes.rotaTelaEditarAnotacao,
                    arguments: dados);
              }
            }),
      );

  pegarValores(BuildContext context) {
    if (anotacaoModelo.corAnotacao == null) {
      MetodosAuxiliares.exibirMensagem(Textos.msgErroSelecaoCor, context);
    } else if (anotacaoModelo.nomeAnotacao.isEmpty ||
        anotacaoModelo.conteudoAnotacao.isEmpty) {
      MetodosAuxiliares.exibirMensagem(Textos.msgErroCamposVazios, context);
    } else {
      if (anotacaoModelo.id == 0) {
        chamarAdicionarDados(context);
      } else {
        chamarAtualizarDados(context);
      }
    }
  }

//metodo para atualizar dados ao banco de dados
  chamarAtualizarDados(BuildContext context) async {
    BancoDados bancoDados = BancoDados();
    bool retorno = await bancoDados.atualizarDados(anotacaoModelo);
    if (retorno) {
      MetodosAuxiliares.exibirMensagem(Textos.msgSucessoAtualizar, context);
      Navigator.pushReplacementNamed(context, Constantes.rotaTelaInicial);
    } else {
      MetodosAuxiliares.exibirMensagem(Textos.msgErroAtualizar, context);
    }
  }

  //metodo para adicionar dados ao banco de dados
  chamarAdicionarDados(BuildContext context) async {
    BancoDados bancoDados = BancoDados();
    bool retorno = await bancoDados.inserirDados(anotacaoModelo);
    if (retorno) {
      MetodosAuxiliares.exibirMensagem(Textos.msgSucessoAdicionar, context);
      Navigator.pushReplacementNamed(context, Constantes.rotaTelaInicial);
    } else {
      MetodosAuxiliares.exibirMensagem(Textos.msgErroAdicionar, context);
    }
  }

  //metodo para mudar icone do botao central de acao
  mudarIconeBtnAcao(String tipoAcao) {
    if (tipoAcao == Constantes.tipoAcaoAdicao) {
      return Icons.add;
    } else if (tipoAcao == Constantes.tipoAcaoSalvarAnotacao) {
      return Icons.save_outlined;
    } else {
      return Icons.edit_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    double larguraTela = MediaQuery.of(context).size.width;
    double alturaTela = MediaQuery.of(context).size.height;
    return SizedBox(
      width: larguraTela,
      height: alturaTela * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          botao(Icons.home_filled, Constantes.rotaTelaInicial, context),
          botao(
              Icons.done_all, Constantes.rotaTelaAnotacoesConcluidas, context),
          botaoAcao(mudarIconeBtnAcao(tipoAcao), context),
          botao(Icons.favorite_outlined,
              Constantes.tipoAcaoFiltrarFavoritoNotificacao, context),
          botao(Icons.person_outline, "", context)
        ],
      ),
    );
  }
}
