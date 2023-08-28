import 'package:ciernote/Modelo/anotacao.dart';
import 'package:ciernote/Modelo/seletor_cor.dart';
import 'package:ciernote/Uteis/constantes.dart';
import 'package:ciernote/Uteis/estilo.dart';
import 'package:ciernote/Uteis/paleta_cores.dart';
import 'package:intl/intl.dart';
import 'package:ciernote/Uteis/textos.dart';
import 'package:ciernote/Widgets/barra_navegacao.dart';
import 'package:flutter/material.dart';

class TelaCadastroAnotacao extends StatefulWidget {
  const TelaCadastroAnotacao({super.key});

  @override
  State<TelaCadastroAnotacao> createState() => _TelaCadastroAnotacaoState();
}

class _TelaCadastroAnotacaoState extends State<TelaCadastroAnotacao> {
  Estilo estilo = Estilo();
  DateTime data = DateTime.now();
  late dynamic horario = TimeOfDay.now();
  dynamic horarioFormatado;
  dynamic corSelecionada = Colors.black;
  TextEditingController controllerNomeAnotacao =
      TextEditingController(text: "");
  TextEditingController controllerConteudoAnotacao =
      TextEditingController(text: "");
  TextEditingController controllerData = TextEditingController(text: "");
  TextEditingController controllerHora =
      TextEditingController(text: Textos.semHorarioDefinido);

  //variavel usada para validar o formulario
  static final _chaveFormulario = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controllerData.text = '${data.day}/${data.month}/${data.year}';
    BarraNavegacao.anotacaoModelo = AnotacaoModelo.vazia();
    BarraNavegacao.anotacaoModelo.id = 0;
    BarraNavegacao.anotacaoModelo.corAnotacao = null;
    BarraNavegacao.anotacaoModelo.favorito = false;
    BarraNavegacao.anotacaoModelo.notificacaoAtiva = false;
    BarraNavegacao.anotacaoModelo.statusAnotacao = false;
    print("fsdfxxxxxxxxxxxxxs");
  }

  List<SeletorCorModelo> itensCores = [
    SeletorCorModelo(cor: PaletaCores.corCastanho),
    SeletorCorModelo(cor: PaletaCores.corVerdeClaro),
    SeletorCorModelo(cor: PaletaCores.corAzulCianoClaro),
    SeletorCorModelo(cor: PaletaCores.corRosa),
    SeletorCorModelo(cor: PaletaCores.corVerdeCiano),
    SeletorCorModelo(cor: PaletaCores.corMarsala),
    SeletorCorModelo(cor: PaletaCores.corAmareloDesaturado),
    SeletorCorModelo(cor: PaletaCores.corLaranja),
    SeletorCorModelo(cor: PaletaCores.corVerdeEscuro),
    SeletorCorModelo(cor: PaletaCores.corVerdeLima),
  ];

  Widget camposCadastro(
          double larguraTela, TextEditingController controller, String label) =>
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          width: larguraTela,
          height: label == Textos.labelConteudoAnotacao ? 350 : 110,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 3.0),
                child: Text(label,
                    style: const TextStyle(color: Colors.white, fontSize: 18)),
              ),
              TextFormField(
                readOnly: label == Textos.labelData
                    ? true
                    : false || label == Textos.labelHorario
                        ? true
                        : false,
                controller: controller,
                onTapOutside: (event) {
                  pegarValores(controller, label);
                },
                onTap: () async {
                  if (label == Textos.labelData) {
                    definirData();
                  } else if (label == Textos.labelHorario) {
                    definirHorario();
                  }
                },
                maxLines: label == Textos.labelConteudoAnotacao ? 11 : 1,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ));

  pegarValores(TextEditingController controller, String label) {
    if (label == Textos.labelNomeAnotacao) {
      BarraNavegacao.anotacaoModelo.nomeAnotacao = controller.text;
    } else if (label == Textos.labelData) {
      BarraNavegacao.anotacaoModelo.data = controller.text;
    } else if (label == Textos.labelHorario) {
      BarraNavegacao.anotacaoModelo.horario = controller.text;
    } else if (label == Textos.labelConteudoAnotacao) {
      BarraNavegacao.anotacaoModelo.conteudoAnotacao = controller.text;
    }
  }

  definirData() async {
    DateTime? novaData = await showDatePicker(
        builder: (context, child) {
          return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.light(
                  primary: PaletaCores.corAzulCianoClaro,
                  onPrimary: Colors.white,
                  onSurface: Colors.black,
                ),
                dialogBackgroundColor: Colors.white,
              ),
              child: child!);
        },
        context: context,
        initialDate: data,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (novaData == null) return;
    setState(() {
      data = novaData;
      controllerData.text = '${data.day}/${data.month}/${data.year}';
    });
  }

  definirHorario() async {
    TimeOfDay? novoHorario = await showTimePicker(
      context: context,
      initialTime: horario!,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.light(
              primary: PaletaCores.corAzul,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (novoHorario != null) {
      setState(() {
        horario = novoHorario;
        formatarHora();
        controllerHora.text = horarioFormatado.toString();
      });
    } else {
      controllerHora.text = Textos.semHorarioDefinido;
    }
  }

  // metodo para formatar a hora
  // para o formato 12 horas
  formatarHora() {
    // pegando o formato desejado
    var formatoHora = DateFormat('HH:mm');
    // atribuindo a variavel de hora o formato e
    // adicionando 30 minutos ao horario
    var horaParse = formatoHora.parse('${horario!.hour}:${horario!.minute}');
    // criando o formato de saida
    var saidaHoraFormatada = DateFormat('HH:mm');
    //definindo que a variavel vai receber o formato de saida
    horarioFormatado = saidaHoraFormatada.format(horaParse);
  }

  // widget para selecao de cor da tarefa
  Widget seletorCor(SeletorCorModelo corModelo) => Column(
        children: [
          Visibility(
            visible: corModelo.corMarcada,
            child: const SizedBox(
              width: 60,
              height: 20,
              child: Icon(
                Icons.arrow_drop_down,
                size: 35,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 50,
            width: 60,
            child: IconButton(
              icon: const Icon(Icons.circle_rounded, size: 50),
              color: corModelo.cor,
              onPressed: () {
                setState(() {
                  setState(() {
                    // utilizando um for para pegar todos os elementos da lista e
                    // setando novo valor para tal
                    // parametro permitindo assim
                    // evidenciar somente uma cor selecionada
                    for (var itemLista in itensCores) {
                      itemLista.corMarcada = false;
                    }
                  });
                  //deixando a cor selecionada marcada
                  corModelo.corMarcada = true;
                  corSelecionada = corModelo.cor;
                  BarraNavegacao.anotacaoModelo.corAnotacao = corSelecionada;
                });
              },
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    double larguraTela = MediaQuery.of(context).size.width;
    double alturaTela = MediaQuery.of(context).size.height;
    return Theme(
        data: estilo.estiloGeral,
        child: WillPopScope(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              // if(_chaveFormulario.currentState!.validate()){
              //   print("dfsfdf");
              // }
            },
            child: Scaffold(
                backgroundColor: Constantes.corFundoTela,
                appBar: AppBar(
                    title: Text(
                      Textos.telaCadastroAnotacao,
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
                        key: _chaveFormulario,
                        child: Wrap(children: [
                          camposCadastro(larguraTela, controllerNomeAnotacao,
                              Textos.labelNomeAnotacao),
                          camposCadastro(larguraTela * 0.5, controllerData,
                              Textos.labelData),
                          camposCadastro(larguraTela * 0.5, controllerHora,
                              Textos.labelHorario),
                          camposCadastro(
                              larguraTela,
                              controllerConteudoAnotacao,
                              Textos.labelConteudoAnotacao),
                          Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            width: larguraTela,
                            child: Column(
                              children: [
                                Text(Textos.labelSelecaoCor,
                                    style: const TextStyle(
                                        fontSize: 17, color: Colors.white)),
                                SizedBox(
                                  width: larguraTela,
                                  height: 80,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      ...itensCores.map(
                                        (e) {
                                          print(e.corMarcada);
                                          return seletorCor(e);
                                        },
                                      ).toList()
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
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
                          tipoAcao: Constantes.tipoAcaoSalvarAnotacao,
                          tipoTela: "",
                        ),
                      ],
                    ))),
          ),
          onWillPop: () async {
            Navigator.pushReplacementNamed(context, Constantes.rotaTelaInicial);
            return false;
          },
        ));
  }
}
