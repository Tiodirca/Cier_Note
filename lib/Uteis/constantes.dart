import 'package:ciernote/Modelo/seletor_cor.dart';
import 'package:ciernote/Uteis/paleta_cores.dart';
import 'package:flutter/material.dart';

class Constantes {
  static const rotaTelaInicial = "telaInicial";
  static const rotaTelaCadastroAnotacao = "telaCadastroAnotacao";
  static const rotaTelaDetalhesAnotacao = "telaDetalhesAnotacao";
  static const rotaTelaEditarAnotacao = "telaEditarAnotacao";

  static const parametroTelaDetalhesAnotacao = "parametroDetalhesAnotacao";

  static const tipoAcaoAdicao = "adicionarAnotacao";
  static const tipoAcaoSalvarAnotacao = "salvarAnotacao";
  static const tipoAcaoEditarAnotacao = "editarAnotacao";

  static Color corFundoTela = PaletaCores.corAzul;

  static const iconFavoritoAtivo = Icons.favorite;
  static const iconFavoritoDesativado = Icons.favorite_outline;
  static const iconNotificacaoAtiva = Icons.notifications;
  static const iconNotificacaoDesativada = Icons.notifications_off_outlined;
  static const iconExcluirDado = Icons.close_rounded;
  static const iconConcluidoAnotacao = Icons.done_all;
  static const iconNaoConcluidoAnotacao = Icons.remove_done_outlined;

  static const statusAnotacaoConcluido = "concluido";


  static const bancoNomeTabela ="anotacoes";
  static const bancoID = "id";
  static const bancoNomeAnotacao = "nomeAnotacao";
  static const bancoConteudoAnotacao = "conteudoAnotacao";
  static const bancoStatusAnotacao = "statusAnotacao";
  static const bancoCorAnotacao = "corAnotacao";
  static const bancoData = "data";
  static const bancoHorario = "horario";
  static const bancoFavorito = "favorito";
  static const bancoNotificacaoAtiva = "notificacaoAtiva";

  // lista com as cores para o usuario selecionar
  static final List<SeletorCorModelo> itensCores = [
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

}
