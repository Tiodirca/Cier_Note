import 'package:ciernote/Modelo/notificacao.dart';
import 'package:ciernote/Uteis/constantes.dart';
import 'package:ciernote/Uteis/textos.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificacaoServico {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  TimeOfDay? hora = const TimeOfDay(hour: 19, minute: 00);
  DateTime data = DateTime(2022, 07, 02);
  late BuildContext context;
  late String tipoTela;
  late NotificacaoModelo notificacaoGeral;

  Future<bool> iniciarServicoNotificacao() async {
    try {
      //instanciando classe
      localNotificationsPlugin = FlutterLocalNotificationsPlugin();
      //definindo configuracao inicial
      // definindo icone
      const androidIcone = AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      );
      // instanciando a configuracao
      const initializationSettings =
          InitializationSettings(android: androidIcone);
      // iniciando o plugin
      await localNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: clickNotificacao);

      return true;
    } catch (error) {
      return false;
    }
  }

  // metodo para definir configuracao
  // de canais de notificacao
  definicoesCanaisTipoPlataforma() {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      "lembrete_notificacao",
      Constantes.canalNotificacaoPadrao,
      priority: Priority.max,
      importance: Importance.high,
      autoCancel: false,
      ongoing: true,
      onlyAlertOnce: true,
      enableVibration: true,
      enableLights: true,
    );

    NotificationDetails plataforma =
        const NotificationDetails(android: androidPlatformChannelSpecifics);
    return plataforma;
  }

  // metodo responsavel por definir acao
  // no click na notificacao
  clickNotificacao(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print("Entrou Payload");
    } else {
      print("Vazio ou Nulo");
    }
  }

  exibirNotificacao(
      NotificacaoModelo notificacao, String tipoNotificacao) async {
    iniciarServicoNotificacao();
    notificacaoGeral = notificacao;
    if (tipoNotificacao == Textos.semHorarioDefinido) {
      await localNotificationsPlugin.show(
        notificacao.id,
        notificacao.nomeAnotacao,
        notificacao.conteudoNotificacao,
        definicoesCanaisTipoPlataforma(),
        payload: "acao",
      );
    } else {
      formatarDataHora();
      configTimeZone();
      await localNotificationsPlugin.zonedSchedule(
          notificacao.id,
          notificacao.nomeAnotacao,
          notificacao.conteudoNotificacao,
          tz.TZDateTime.now(tz.local)
              .add(Duration(seconds: calcularDirencaHorario())),
          definicoesCanaisTipoPlataforma(),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: "acao");
    }
  }

  // metodo para calcular a diferenca
  // entre o horario programadoe o horario atual do dispositivo
  calcularDirencaHorario() {
    //pegando a diferenca entra o horario agendado
    // e o horario do dispositivo
    Duration diferencaHora = tz.TZDateTime.now(tz.local).difference(
        DateTime(data.year, data.month, data.day, hora!.hour, hora!.minute));
    // verificando se a variavel contem
    // valor com sinal de negativo

    if (diferencaHora.inSeconds.toString().contains("-")) {
      diferencaHora = -(diferencaHora);
    }
    print(diferencaHora.inSeconds);
    print(diferencaHora);
    return diferencaHora.inSeconds;
  }

  // future responsavel por
  // cancelar a notificacao
  Future<void> cancelarNotificacao(int id) async {
    iniciarServicoNotificacao();
    await localNotificationsPlugin.cancel(id);
  }

  Future<void> cancelarTudo() async {
    iniciarServicoNotificacao();
    await localNotificationsPlugin.cancelAll();
  }

  // metodo responsavel por chamar a exibicao da notificacao
  chamarExibirNotificacao(NotificacaoModelo notificacao, String tipoNotificacao,
      BuildContext context) {
    // instaniando o provider passando a classe modelo com os parametros necessarios
    Provider.of<NotificacaoServico>(context, listen: false)
        .exibirNotificacao(notificacao, tipoNotificacao);
  }

  verificarNotificacoesAtivas() async {
    iniciarServicoNotificacao();
    final detalhes =
        await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (detalhes != null && detalhes.didNotificationLaunchApp) {
      clickNotificacao(detalhes.payload);
      print("Entrou detalhers");
    } else {
      print("Erros");
    }
  }

  // -------- Necessario para agendar a notificacao
  formatarDataHora() {
    DateTime? converterHora;
    //variavel vai receber o valor da string e
    // converter para o formato de hora
    converterHora = DateFormat("hh:mm").parse(notificacaoGeral.horario);
    TimeOfDay horaFormatar =
        TimeOfDay(hour: converterHora.hour, minute: converterHora.minute);
    hora = horaFormatar;
    data = DateFormat("dd/MM/yyyy", "pt_BR").parse(notificacaoGeral.data);
  }

  // future para configurar o time zone para pegar o
  // horario local do dispositivo
  Future<void> configTimeZone() async {
    tz.initializeTimeZones();
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Detroit'));
  }
}
