import 'package:ciernote/Modelo/seletor_cor.dart';
import 'package:ciernote/Uteis/paleta_cores.dart';
import 'package:flutter/material.dart';

class Constantes {
  // cor do plano de fundo das telas
  static Color corFundoTela = PaletaCores.corAzul;

  // rota
  static const rotaTelaInicial = "telaInicial";
  static const rotaTelaCadastroAnotacao = "telaCadastroAnotacao";
  static const rotaTelaDetalhesAnotacao = "telaDetalhesAnotacao";
  static const rotaTelaEditarAnotacao = "telaEditarAnotacao";
  static const rotaTelaFavorito = "telaFavorito";
  static const rotaTelaAnotacoesConcluidas = "telaAnotacoesConcluidas";
  static const rotaTelaUsuario = "telaUsuario";

  // parametro para passar map de dados para tela de detalhes
  static const parametroTelaDetalhesAnotacao = "parametroDetalhesAnotacao";
  static const parametroTipoTela = "tipoTela";
  static const parametroBuildContext = "context";

  // acoes dos botoes
  static const tipoAcaoAdicao = "adicionarAnotacao";
  static const tipoAcaoSalvarAnotacao = "salvarAnotacao";
  static const tipoAcaoEditarAnotacao = "editarAnotacao";
  static const tipoAcaoFiltrarFavoritoNotificacao =
      "filtrarFavoritoNotificacao";

  //icones dos botoes
  static const iconFavoritoAtivo = Icons.favorite;
  static const iconFavoritoDesativado = Icons.favorite_outline;
  static const iconNotificacaoAtiva = Icons.notifications;
  static const iconNotificacaoDesativada = Icons.notifications_off_outlined;
  static const iconExcluirDado = Icons.close_rounded;
  static const iconConcluidoAnotacao = Icons.done_all;
  static const iconNaoConcluidoAnotacao = Icons.remove_done_outlined;

  // status da anotacao
  static const statusAnotacaoConcluido = "concluido";

  // campos do banco de dados
  static const bancoNomeTabela = "anotacoes";
  static const bancoID = "id";
  static const bancoNomeAnotacao = "nomeAnotacao";
  static const bancoConteudoAnotacao = "conteudoAnotacao";
  static const bancoStatusAnotacao = "statusAnotacao";
  static const bancoCorAnotacao = "corAnotacao";
  static const bancoData = "data";
  static const bancoHorario = "horario";
  static const bancoFavorito = "favorito";
  static const bancoNotificacaoAtiva = "notificacaoAtiva";

  static const canalNotificacaoPadrao = "Padrão";

}
