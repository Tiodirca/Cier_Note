import 'package:ciernote/Modelo/anotacao.dart';
import 'package:ciernote/Uteis/MetodosAuxiliares.dart';
import 'package:ciernote/Uteis/constantes.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'dart:io' as io;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class BancoDados {
  var bancoDados;

  abirConexaoBancoDadosDesktop() async {
    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;
    final io.Directory appDocumentsDir =
        await getApplicationDocumentsDirectory();
    String dbPath =
        p.join(appDocumentsDir.path, "databases", "bancoAnotacoes.db");
    bancoDados = await databaseFactory.openDatabase(
      dbPath,
    );
  }

  // metodo para criar tabela no banco de dados
  Future<bool> criarTabela() async {
    await abirConexaoBancoDadosDesktop();
    try {
      await bancoDados
          .execute('''CREATE TABLE IF NOT EXISTS ${Constantes.bancoNomeTabela} 
      (id INTEGER PRIMARY KEY,${Constantes.bancoNomeAnotacao} TEXT,
      ${Constantes.bancoConteudoAnotacao} TEXT,
      ${Constantes.bancoStatusAnotacao} TEXT,
      ${Constantes.bancoCorAnotacao} TEXT,
      ${Constantes.bancoData} TEXT,
      ${Constantes.bancoHorario} TEXT,
      ${Constantes.bancoFavorito} TEXT,
      ${Constantes.bancoNotificacaoAtiva} TEXT)''');
      return true;
    } catch (e) {
      return false;
    }
  }

  // metodo para inserir dados no banco de dados
  Future<bool> inserirDados(AnotacaoModelo anotacaoModelo) async {
    await abirConexaoBancoDadosDesktop();
    try {
      await bancoDados.insert(Constantes.bancoNomeTabela, <String, Object?>{
        Constantes.bancoNomeAnotacao: anotacaoModelo.nomeAnotacao,
        Constantes.bancoConteudoAnotacao: anotacaoModelo.conteudoAnotacao,
        Constantes.bancoStatusAnotacao:
            anotacaoModelo.statusAnotacao.toString(),
        Constantes.bancoCorAnotacao: anotacaoModelo.corAnotacao.toString(),
        Constantes.bancoData: anotacaoModelo.data,
        Constantes.bancoHorario: anotacaoModelo.horario,
        Constantes.bancoFavorito: anotacaoModelo.favorito.toString(),
        Constantes.bancoNotificacaoAtiva:
            anotacaoModelo.notificacaoAtiva.toString(),
      });
      print("fdsfsdf");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // metodo para recuperar dados no banco de dados
  Future<List<AnotacaoModelo>> recuperarDadosBanco() async {
    await abirConexaoBancoDadosDesktop();
    List<Map> lista = await bancoDados
        .rawQuery('SELECT * FROM ${Constantes.bancoNomeTabela}');
    List<AnotacaoModelo> listaFinal = [];
    bool favorito = false;
    bool notificacaoAtiva = false;
    bool statusAnotacao = false;
    for (var element in lista) {
      if (element.values.elementAt(3) == "true") {
        statusAnotacao = true;
      } else {
        statusAnotacao = false;
      }
      if (element.values.elementAt(7) == "true") {
        favorito = true;
      } else {
        favorito = false;
      }
      if (element.values.elementAt(8) == "true") {
        notificacaoAtiva = true;
      } else {
        notificacaoAtiva = false;
      }

      listaFinal.add(AnotacaoModelo(
          id: element.values.elementAt(0),
          nomeAnotacao: element.values.elementAt(1),
          conteudoAnotacao: element.values.elementAt(2),
          statusAnotacao: statusAnotacao,
          corAnotacao: MetodosAuxiliares.recuperarCorSelecionada(
              element.values.elementAt(4)),
          data: element.values.elementAt(5),
          horario: element.values.elementAt(6),
          favorito: favorito,
          notificacaoAtiva: notificacaoAtiva));
    }
    return listaFinal;
  }

  // metodo para atualizar valores da tarefa
  Future<bool> atualizarDados(AnotacaoModelo anotacaoModelo) async {
    await abirConexaoBancoDadosDesktop();
    try {
      print("Fav Metodo");
      print(anotacaoModelo.favorito.toString());
      print("Not Metodo");
      print(anotacaoModelo.notificacaoAtiva.toString());
      await bancoDados.execute('''UPDATE ${Constantes.bancoNomeTabela} SET
      ${Constantes.bancoNomeAnotacao} = '${anotacaoModelo.nomeAnotacao}',
      ${Constantes.bancoConteudoAnotacao} = '${anotacaoModelo.conteudoAnotacao}',
      ${Constantes.bancoStatusAnotacao} = '${anotacaoModelo.statusAnotacao}',
      ${Constantes.bancoCorAnotacao} = '${anotacaoModelo.corAnotacao}',
      ${Constantes.bancoData} = '${anotacaoModelo.data}',
      ${Constantes.bancoHorario} = '${anotacaoModelo.horario}',
      ${Constantes.bancoFavorito} = '${anotacaoModelo.favorito}',
      ${Constantes.bancoNotificacaoAtiva} = '${anotacaoModelo.notificacaoAtiva}'WHERE id = ${anotacaoModelo.id}''');
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // metodo para excluir dado
  Future<bool> excluirDado(int id) async {
    await abirConexaoBancoDadosDesktop();
    try {
      await bancoDados.execute(
          '''DELETE FROM ${Constantes.bancoNomeTabela} WHERE id = $id''');
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
