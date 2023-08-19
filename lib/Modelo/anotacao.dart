import 'package:flutter/material.dart';

class AnotacaoModelo {
  int id;
  String nomeAnotacao;
  String conteudoAnotacao;
  String statusAnotacao;
  dynamic corAnotacao;
  dynamic data;
  dynamic horario;
  bool favorito;
  bool notificacaoAtiva;

  AnotacaoModelo(
      {this.id = 0,
      required this.nomeAnotacao,
      required this.conteudoAnotacao,
      required this.corAnotacao,
      required this.horario,
      required this.data,
      this.statusAnotacao = "",
      this.notificacaoAtiva = false,
      this.favorito = false});

  AnotacaoModelo.vazia(
      {this.id = 0,
      this.nomeAnotacao = "",
      this.conteudoAnotacao = "",
      this.corAnotacao,
      this.statusAnotacao = "",
      this.horario = const TimeOfDay(hour: 10, minute: 00),
      this.data = "",
      this.notificacaoAtiva = false,
      this.favorito = false});
}
