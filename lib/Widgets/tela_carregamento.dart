import 'package:ciernote/Uteis/constantes.dart';
import 'package:ciernote/Uteis/textos.dart';
import 'package:flutter/material.dart';

class TelaCarregamento extends StatelessWidget {
  const TelaCarregamento({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double larguraTela = MediaQuery.of(context).size.width;
    double alturaTela = MediaQuery.of(context).size.height;
    return Container(
        padding: const EdgeInsets.all(10),
        width: larguraTela,
        height: alturaTela,
        color: Constantes.corFundoTela,
        child: Center(
          child: SizedBox(
            width: larguraTela * 0.95,
            height: 150,
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Textos.txtTelaCarregamento,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation(Constantes.corFundoTela),
                      strokeWidth: 1.5,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
