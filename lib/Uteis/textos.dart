class Textos {
  static String nomeApp = "Cier Note";

  static String btnFavoritos = "Favoritos";
  static String btnNotificacoes = "Notificações";
  static String txtTelaCarregamento = "Carregando Aguarde";

  // titulos Telas
  static String telaCadastroAnotacao = "Cadastro de tarefa";
  static String telaDetalhesAnotacao = "Detalhes da sua anotação";
  static String telaEditarAnotacao = "Editar anotação";
  static String telaFavoritos = "Favoritos e Notificações";
  static String telaAnotacoesConcluidas = "Concluidas";

  static String descricaoTelaAnotacoesConcluidas =
      "Abaixo você pode ver todas as anotações que você já concluiu";
  static String descricaoTelaFavoritoNotificacao =
      "Selecione uma das opções para filtrar a listagem das anotações";

  // Labels textfield
  static String labelNomeAnotacao = "Título Anotação";
  static String labelConteudoAnotacao = "Descrição";
  static String labelData = "Data";
  static String labelHorario = "Horário";
  static String labelSelecaoCor = "Selecione a cor da anotação";
  static String labelOpcoesTelaDetalhesAnotacao = "Opções de ações";

  // strings alert
  static String tituloAlertaExclusao = "Confirmação de exclusão";
  static String descricaoAlertaExclusao =
      "Deseja realmente excluir está anotação ?";

  // strings gerais
  static String legendaTarefasAndamento = "Tarefas em andamento";

  //mensagem de retorno caso nao defina um horario
  static String semHorarioDefinido = "Sem Horário definido";

  // mensagem se nao for encontrado anotacoes no banco de dados
  static String semAnotacoes =
      "Sem anotações cadastradas ou a serem realizadas.";

  // mensagens de retorno de acao para o usuario
  // tela de detalhes
  static String notificacaoAtivada = "Notificação ativada";
  static String notificacaoDesativada = "Notificação desativada";
  static String favoritoAtivada = "Anotação adicionada aos favoritos";
  static String favoritoDesativada = "Anotação removida dos favoritos";
  static String anotacaoConcluida = "Anotação marcada como concluida";
  static String anotacaoNaoConcluida = "Anotação marcada como não concluida";

  // mensagens de sucesso ao realizar acao no banco de dados
  static String msgSucessoAdicionar = "Sucesso ao criar anotação";
  static String msgSucessoAtualizar = "Sucesso ao atualizar anotação";
  static String msgSucessoExcluir = "Sucesso ao excluir anotação";

  // mensagens de erro ao realizar acao no banco de dados
  static String msgErroAdicionar = "Erro ao criar anotação";
  static String msgErroAtualizar = "Erro ao atualizar anotação";
  static String msgErroExcluir = "Erro ao excluir anotação";

  // mensagem de aviso de falta de acao do usuario
  static String msgErroSelecaoCor = "Selecione uma cor para a anotação";
  static String msgErroCamposVazios = "Preencha os seguintes campos";
}
