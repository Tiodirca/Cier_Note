class NotificacaoModelo {
  final int id;
  final String nomeAnotacao;
  final String conteudoNotificacao;
  final dynamic data;
  final dynamic horario;
  final Map payload;

  NotificacaoModelo(
      {required this.id,
      required this.nomeAnotacao,
      required this.conteudoNotificacao,
      required this.data,
      required this.horario,
      required this.payload});
}
