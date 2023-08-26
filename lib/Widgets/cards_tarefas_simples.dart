import 'package:ciernote/Modelo/anotacao.dart';
import 'package:ciernote/Uteis/constantes.dart';
import 'package:ciernote/Uteis/paleta_cores.dart';
import 'package:flutter/material.dart';

class CardsTarefas extends StatelessWidget {
  const CardsTarefas(
      {super.key, required this.anotacaoModelo, required this.tipoTela});

  final AnotacaoModelo anotacaoModelo;
  final tipoTela;

  Widget informarcoesRodape(IconData icons, String legenda) => Row(
        children: [
          Icon(
            icons,
            size: 20,
            color: anotacaoModelo.corAnotacao,
          ),
          Text(
            legenda.toString(),
            style: const TextStyle(fontSize: 16, color: Colors.black),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    double larguraTela = MediaQuery.of(context).size.width;
    double alturaTela = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      width: larguraTela,
      height: alturaTela * 0.13,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 10,
            backgroundColor: Colors.white,
            shadowColor: anotacaoModelo.corAnotacao,
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: anotacaoModelo.corAnotacao),
                borderRadius: BorderRadius.circular(20))),
        onPressed: () {
          Map dados = {};
          dados[Constantes.parametroTipoTela] = tipoTela;
          dados[Constantes.parametroTelaDetalhesAnotacao] = anotacaoModelo;
          Navigator.pushReplacementNamed(
              context, Constantes.rotaTelaDetalhesAnotacao,
              arguments: dados);
        },
        child: SizedBox(
          width: larguraTela,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: larguraTela,
                  child: Text(anotacaoModelo.nomeAnotacao.toString(),
                      style:
                          const TextStyle(color: Colors.black, fontSize: 20)),
                ),
              ),
              Container(
                width: larguraTela,
                height: 1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: PaletaCores.corAzul),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: larguraTela,
                  child: Text(anotacaoModelo.conteudoAnotacao,
                      maxLines: 1,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 16)),
                ),
              ),
              Container(
                width: larguraTela,
                height: 1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: PaletaCores.corAzul),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                    width: larguraTela,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          child: informarcoesRodape(Icons.access_time_outlined,
                              anotacaoModelo.horario.toString()),
                        ),
                        SizedBox(
                          width: 100,
                          child: informarcoesRodape(Icons.date_range_outlined,
                              anotacaoModelo.data.toString()),
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            if (anotacaoModelo.favorito) {
                              return informarcoesRodape(
                                  Constantes.iconFavoritoAtivo, "");
                            } else {
                              return Container(width: 20);
                            }
                          },
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            if (anotacaoModelo.notificacaoAtiva) {
                              return informarcoesRodape(
                                  Constantes.iconNotificacaoAtiva, "");
                            } else {
                              return Container(width: 20);
                            }
                          },
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
