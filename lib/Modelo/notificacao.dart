import 'package:ciernote/Modelo/anotacao.dart';

class Notificacao {
  final int id;
  final String titulo;
  final String corpoNotificacao;
  final dynamic data;
  final dynamic hora;
  final AnotacaoModelo payload;

  Notificacao(
      {required this.id,
      required this.titulo,
      required this.corpoNotificacao,
      required this.data,
      required this.hora,
      required this.payload});
}
