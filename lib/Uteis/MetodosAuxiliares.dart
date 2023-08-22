import 'package:ciernote/Modelo/anotacao.dart';
import 'package:ciernote/Uteis/textos.dart';
import 'package:flutter/material.dart';

class MetodosAuxiliares{

  static exibirMensagem(String msg,BuildContext context){
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
  static recuperarCorSelecionada(String corRecuperar){
    dynamic cor = corRecuperar;
    String corString = cor.toString(); // Color(0x12345678)
    String valorString = corString.split('(0x')[1].split(')')[0];
    int valor = int.parse(valorString, radix: 16);
    Color instanciaCor = Color(valor);
    return instanciaCor;
  }
}