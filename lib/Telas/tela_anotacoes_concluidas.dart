import 'package:ciernote/Uteis/consultas.dart';
import 'package:ciernote/Modelo/anotacao.dart';
import 'package:ciernote/Uteis/BancoDados/banco_dados.dart';
import 'package:ciernote/Uteis/constantes.dart';
import 'package:ciernote/Uteis/estilo.dart';
import 'package:ciernote/Uteis/paleta_cores.dart';
import 'package:ciernote/Uteis/textos.dart';
import 'package:ciernote/Widgets/barra_navegacao.dart';
import 'package:ciernote/Widgets/listagem_anotacoes.dart';
import 'package:ciernote/Widgets/tela_carregamento.dart';
import 'package:flutter/material.dart';

class TelaAnotacoesConcluidas extends StatefulWidget {
  const TelaAnotacoesConcluidas({super.key});

  @override
  State<TelaAnotacoesConcluidas> createState() =>
      _TelaAnotacoesConcluidasState();
}

class _TelaAnotacoesConcluidasState extends State<TelaAnotacoesConcluidas> {
  List<AnotacaoModelo> anotacoes = [];
  static List<AnotacaoModelo> anotacoesFiltragemBusca = [];
  TextEditingController controllerFiltrarBuscaAnotacoes =
      TextEditingController(text: "");
  Estilo estilo = Estilo();
  bool telaCarregamento = true;
  String tipoTela = Constantes.rotaTelaAnotacoesConcluidas;

  @override
  void initState() {
    super.initState();
    chamarRealizarConsultaBancoDados();
  }

  // metodo para criar tabela caso
  // ela não tenha sido criada ainda
  chamarCriarTabela() async {
    BancoDados bancoDados = BancoDados();
    await bancoDados.criarTabela();
  }

  // metodo para realizar a busca das anotacoes
  // no banco de dados
  chamarRealizarConsultaBancoDados() async {
    anotacoes = await Consultas.realizarConsultaBancoDados();
    if (anotacoes.isNotEmpty) {
      setState(() {
        // removendo objeto da lista quando ele nao atender ao parametro passado
        anotacoes.removeWhere((element) => element.statusAnotacao != true);
        telaCarregamento = false;
      });
    } else {
      setState(() {
        telaCarregamento = false;
      });
    }
  }

  // metodo para realizar a busca de anotacoes
  // na listagem principal
  realizarFiltragemBuscaAnotacoes() {
    //limpando a lista antes
    // de fazer uma nova busca
    anotacoesFiltragemBusca.clear();
    setState(() {
      // percorrendo a lista
      for (var element in anotacoes) {
        //verificando se existe algum elemento que contenha a
        // string digitada pelo usuario e passando tudo para minusculo
        if (element.nomeAnotacao
            .toLowerCase()
            .contains(controllerFiltrarBuscaAnotacoes.text.toLowerCase())) {
          anotacoesFiltragemBusca.add(element);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double larguraTela = MediaQuery.of(context).size.width;
    double alturaTela = MediaQuery.of(context).size.height;

    return Theme(
        data: estilo.estiloGeral,
        child: WillPopScope(
          onWillPop: () async {
            Navigator.popAndPushNamed(context, Constantes.rotaTelaInicial);
            return false;
          },
          child: Scaffold(
              appBar: AppBar(
                  title: Text(
                    Textos.telaAnotacoesConcluidas,
                  ),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(
                          context, Constantes.rotaTelaInicial);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  )),
              body: GestureDetector(
                child: Container(
                    color: PaletaCores.corAzul,
                    width: larguraTela,
                    height: alturaTela,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (telaCarregamento) {
                          return const TelaCarregamento();
                        } else {
                          return Column(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      width: larguraTela,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Column(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: SizedBox(
                                                  width: larguraTela,
                                                  height: alturaTela * 0.1,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  larguraTela *
                                                                      0.8,
                                                              height: 50,
                                                              child:
                                                                  TextFormField(
                                                                onChanged:
                                                                    (value) {
                                                                  realizarFiltragemBuscaAnotacoes();
                                                                  if (controllerFiltrarBuscaAnotacoes
                                                                      .text
                                                                      .isEmpty) {
                                                                    setState(
                                                                        () {
                                                                      anotacoesFiltragemBusca
                                                                          .clear();
                                                                    });
                                                                  }
                                                                },
                                                                controller:
                                                                    controllerFiltrarBuscaAnotacoes,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 50,
                                                              width: 50,
                                                              child:
                                                                  FloatingActionButton(
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                      ),
                                                                      backgroundColor: anotacoesFiltragemBusca.isNotEmpty
                                                                          ? Colors
                                                                              .redAccent
                                                                          : PaletaCores
                                                                              .corVerdeClaro,
                                                                      onPressed:
                                                                          () {
                                                                        if (anotacoesFiltragemBusca
                                                                            .isNotEmpty) {
                                                                          setState(
                                                                              () {
                                                                            anotacoesFiltragemBusca.clear();
                                                                            controllerFiltrarBuscaAnotacoes.clear();
                                                                          });
                                                                        } else {
                                                                          realizarFiltragemBuscaAnotacoes();
                                                                        }
                                                                      },
                                                                      child:
                                                                          LayoutBuilder(
                                                                        builder:
                                                                            (context,
                                                                                constraints) {
                                                                          if (anotacoesFiltragemBusca
                                                                              .isNotEmpty) {
                                                                            return Icon(Icons.close,
                                                                                color: PaletaCores.corAzul,
                                                                                size: 30);
                                                                          } else {
                                                                            return Icon(Icons.search,
                                                                                color: PaletaCores.corAzul,
                                                                                size: 30);
                                                                          }
                                                                        },
                                                                      )),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )))
                                        ],
                                      ))),
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    width: larguraTela,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: larguraTela,
                                          height: 3,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white),
                                        ),
                                        Text(
                                            Textos
                                                .descricaoTelaAnotacoesConcluidas,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                        Expanded(
                                            flex: 1,
                                            child: LayoutBuilder(
                                              builder: (context, constraints) {
                                                if (anotacoes.isEmpty) {
                                                  return Center(
                                                    child: Text(
                                                      Textos.semAnotacoes,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ),
                                                  );
                                                } else if (anotacoesFiltragemBusca
                                                    .isNotEmpty) {
                                                  return ListagemAnotacoes(
                                                      anotacoes:
                                                          anotacoesFiltragemBusca,
                                                      tipoTela: tipoTela);
                                                } else {
                                                  return ListagemAnotacoes(
                                                      anotacoes: anotacoes,
                                                      tipoTela: tipoTela);
                                                }
                                              },
                                            ))
                                      ],
                                    ),
                                  )),
                            ],
                          );
                        }
                      },
                    )),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
              bottomNavigationBar: LayoutBuilder(
                builder: (context, constraints) {
                  if (telaCarregamento) {
                    return Container(
                      height: alturaTela * 0.1,
                      color: PaletaCores.corAzul,
                    );
                  } else {
                    return Container(
                        height: alturaTela * 0.11,
                        color: PaletaCores.corAzul,
                        child: Column(
                          children: [
                            Container(
                              width: larguraTela,
                              height: 2,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                            ),
                            const BarraNavegacao(
                              tipoAcao: Constantes.tipoAcaoAdicao,
                              tipoTela: "",
                            ),
                          ],
                        ));
                  }
                },
              )),
        ));
  }
}
