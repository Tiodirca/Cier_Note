import 'package:ciernote/Modelo/anotacao.dart';
import 'package:ciernote/Uteis/BancoDados/BancoDados.dart';
import 'package:ciernote/Uteis/constantes.dart';
import 'package:ciernote/Uteis/estilo.dart';
import 'package:ciernote/Uteis/paleta_cores.dart';
import 'package:ciernote/Uteis/textos.dart';
import 'package:ciernote/Widgets/barra_navegacao.dart';
import 'package:ciernote/Widgets/cards_tarefas_simples.dart';
import 'package:flutter/material.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  List<AnotacaoModelo> anotacoes = [];
  Estilo estilo = Estilo();
  bool telaCarregamento = true;

  @override
  void initState() {
    super.initState();
    chamarCriarTabela();
    chamarRealizarConsulta();
  }

  chamarCriarTabela() async {
    BancoDados bancoDados = BancoDados();
    bool retorno = await bancoDados.criarTabela();
  }

  chamarRealizarConsulta() async {
    BancoDados bancoDados = BancoDados();
    await bancoDados.recuperarDadosBanco().then(
      (value) {
        setState(() {
          telaCarregamento = false;
        });
        anotacoes = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double larguraTela = MediaQuery.of(context).size.width;
    double alturaTela = MediaQuery.of(context).size.height;

    return Theme(
        data: estilo.estiloGeral,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                Textos.nomeApp,
              ),
            ),
            body: GestureDetector(
              child: Container(
                  color: PaletaCores.corAzul,
                  width: larguraTela,
                  height: alturaTela,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (telaCarregamento) {
                        return Container(
                          width: larguraTela,
                          height: alturaTela,
                          color: Colors.green,
                          child: const Center(
                            child: Text("sdfsfsdfs"),
                          ),
                        );
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
                                                            width: larguraTela *
                                                                0.8,
                                                            height: 50,
                                                            child:
                                                                TextFormField(
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
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              backgroundColor:
                                                                  PaletaCores
                                                                      .corVerdeClaro,
                                                              onPressed: () {},
                                                              child: Icon(
                                                                  Icons.search,
                                                                  color: PaletaCores
                                                                      .corAzul,
                                                                  size: 30),
                                                            ),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                      Text(Textos.legendaTarefasAndamento,
                                          style: const TextStyle(
                                              fontSize: 25,
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
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                );
                                              } else {
                                                return ListView.builder(
                                                  itemCount: anotacoes.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    print(anotacoes
                                                        .elementAt(index).notificacaoAtiva
                                                        .toString());
                                                    print("fdsfsd");
                                                    print(anotacoes.elementAt(index).id);
                                                    print(anotacoes
                                                        .elementAt(index).favorito
                                                        .toString());
                                                    return CardsTarefas(
                                                        anotacaoModelo:
                                                            anotacoes.elementAt(
                                                                index));
                                                  },
                                                );
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
            bottomNavigationBar: Container(
                height: alturaTela * 0.11,
                color: PaletaCores.corAzul,
                child: Column(
                  children: [
                    Container(
                      width: larguraTela,
                      height: 2,
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                    const BarraNavegacao(
                      tipoAcao: Constantes.tipoAcaoAdicao,
                    ),
                  ],
                ))));
  }
}