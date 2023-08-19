import 'package:ciernote/Modelo/anotacao.dart';
import 'package:ciernote/Uteis/BancoDados/BancoDados.dart';
import 'package:ciernote/Uteis/MetodosAuxiliares.dart';
import 'package:ciernote/Uteis/constantes.dart';
import 'package:ciernote/Uteis/estilo.dart';
import 'package:ciernote/Uteis/paleta_cores.dart';
import 'package:ciernote/Uteis/textos.dart';
import 'package:ciernote/Widgets/barra_navegacao.dart';
import 'package:flutter/material.dart';

class TelaDetalhesAnotacao extends StatefulWidget {
  const TelaDetalhesAnotacao({super.key, required this.anotacaoModelo});

  final AnotacaoModelo anotacaoModelo;

  @override
  State<TelaDetalhesAnotacao> createState() => _TelaDetalhesAnotacaoState();
}

class _TelaDetalhesAnotacaoState extends State<TelaDetalhesAnotacao> {
  Estilo estilo = Estilo();
  late bool statusAnotacaoFavorito = widget.anotacaoModelo.favorito;
  late bool statusAnotacaoNotificacao = widget.anotacaoModelo.notificacaoAtiva;

  @override
  void initState() {
    super.initState();
    BarraNavegacao.anotacaoModelo = widget.anotacaoModelo;
  }

  Widget botoesAcoes(IconData iconData) => SizedBox(
        height: 50,
        width: 50,
        child: FloatingActionButton(
            heroTag: "btnAcao$iconData",
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: widget.anotacaoModelo.corAnotacao,
            child: Icon(iconData, size: 30, color: PaletaCores.corAzul),
            onPressed: () {
              if (iconData == Constantes.iconNotificacaoAtiva ||
                  iconData == Constantes.iconNotificacaoDesativada) {
                setState(() {
                  statusAnotacaoNotificacao = !statusAnotacaoNotificacao;
                });
              } else if (iconData == Constantes.iconFavoritoAtivo ||
                  iconData == Constantes.iconFavoritoDesativado) {
                setState(() {
                  statusAnotacaoFavorito = !statusAnotacaoFavorito;
                });
              } else if (iconData == Constantes.iconExcluirDado) {
                chamarExcluirDado();
              }
            }),
      );

  chamarExcluirDado() async {
    BancoDados bancoDados = BancoDados();
    bool retorno = await bancoDados.excluirDado(widget.anotacaoModelo.id);
    if (retorno) {
      MetodosAuxiliares.exibirMensagem(Textos.msgSucessoExcluir, context);
      Navigator.pushReplacementNamed(context, Constantes.rotaTelaInicial);
    } else {
      MetodosAuxiliares.exibirMensagem(Textos.msgErroExcluir, context);
    }
  }

  Widget camposInformacoes(double larguraTela, String conteudo, String label) =>
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          width: larguraTela,
          height: label == Textos.labelConteudoAnotacao ? 350 : 100,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 3.0),
                child: Text(label,
                    style: const TextStyle(color: Colors.white, fontSize: 18)),
              ),
              Card(
                color: PaletaCores.corAzul,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 2, color: widget.anotacaoModelo.corAnotacao),
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  readOnly: true,
                  initialValue: conteudo,
                  onTap: () async {
                    if (label == Textos.labelData) {
                    } else if (label == Textos.labelHorario) {}
                  },
                  maxLines: label == Textos.labelConteudoAnotacao ? 13 : 1,
                  style: const TextStyle(color: Colors.white),
                ),
              )
            ],
          ));

  @override
  Widget build(BuildContext context) {
    double larguraTela = MediaQuery.of(context).size.width;
    double alturaTela = MediaQuery.of(context).size.height;
    return Theme(
        data: estilo.estiloGeral,
        child: WillPopScope(
          child: Scaffold(
              backgroundColor: Constantes.corFundoTela,
              appBar: AppBar(
                  title: Text(
                    Textos.telaDetalhesAnotacao,
                  ),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Constantes.rotaTelaInicial);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  )),
              body: SizedBox(
                  width: larguraTela,
                  height: alturaTela,
                  child: SingleChildScrollView(
                    child: Form(
                      child: Wrap(children: [
                        camposInformacoes(
                            larguraTela,
                            widget.anotacaoModelo.nomeAnotacao,
                            Textos.labelNomeAnotacao),
                        camposInformacoes(larguraTela * 0.5,
                            widget.anotacaoModelo.data, Textos.labelData),
                        camposInformacoes(larguraTela * 0.5,
                            widget.anotacaoModelo.horario, Textos.labelHorario),
                        camposInformacoes(
                            larguraTela,
                            widget.anotacaoModelo.conteudoAnotacao,
                            Textos.labelConteudoAnotacao),
                        SizedBox(
                          width: larguraTela,
                          child: Column(
                            children: [
                              Text(Textos.labelOpcoesTelaDetalhesAnotacao,
                                  style: const TextStyle(
                                      fontSize: 17, color: Colors.white)),
                              SizedBox(
                                  width: larguraTela,
                                  height: 80,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      botoesAcoes(statusAnotacaoFavorito == true
                                          ? Constantes.iconFavoritoAtivo
                                          : Constantes.iconFavoritoDesativado),
                                      botoesAcoes(
                                          statusAnotacaoNotificacao == true
                                              ? Constantes.iconNotificacaoAtiva
                                              : Constantes
                                                  .iconNotificacaoDesativada),
                                      botoesAcoes(Constantes.iconExcluirDado)
                                    ],
                                  ))
                            ],
                          ),
                        )
                      ]),
                    ),
                  )),
              bottomNavigationBar: Container(
                  height: alturaTela * 0.11,
                  color: Constantes.corFundoTela,
                  child: Column(
                    children: [
                      Container(
                        width: larguraTela,
                        height: 2,
                        decoration: const BoxDecoration(color: Colors.white),
                      ),
                      const BarraNavegacao(
                        tipoAcao: Constantes.tipoAcaoEditarAnotacao,
                      ),
                    ],
                  ))),
          onWillPop: () async {
            Navigator.pushReplacementNamed(context, Constantes.rotaTelaInicial);
            return false;
          },
        ));
  }
}
