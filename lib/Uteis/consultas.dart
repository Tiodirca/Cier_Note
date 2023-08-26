import 'package:ciernote/Modelo/anotacao.dart';
import 'package:ciernote/Uteis/BancoDados/banco_dados.dart';
import 'package:intl/intl.dart';

class Consultas {
  //   //Future para realizar consulta ao banco de dados
  // e retornar uma lista com estes dados
  static Future<List<AnotacaoModelo>> realizarConsultaBancoDados() async {
    List<AnotacaoModelo> anotacoes = [];
    BancoDados bancoDados = BancoDados();
    await bancoDados.recuperarDadosBanco().then(
      (value) {
        anotacoes = value;
        // ordenando a lista pela data
        // mais recente primeiro
        anotacoes.sort((a, b) => DateFormat("dd/MM/yyyy", "pt_BR")
            .parse(b.data)
            .compareTo(DateFormat("dd/MM/yyyy", "pt_BR").parse(a.data)));
      },
    );
    return anotacoes;
  }
}
