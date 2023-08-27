import 'package:ciernote/Modelo/anotacao.dart';
import 'package:ciernote/Uteis/constantes.dart';
import 'package:ciernote/Uteis/textos.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Notificacoes {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  TimeOfDay? hora = const TimeOfDay(hour: 19, minute: 00);
  DateTime data = DateTime(2022, 07, 02);

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
      print("Vazio sadassads Nulo");
    } else {
      print("Vazio ou Nulo");
    }
  }

  Future<void> exibirNotificao(
      AnotacaoModelo anotacaoModelo, String tipoNotificacao) {
    iniciarServicoNotificacao();
    if (tipoNotificacao == Textos.semHorarioDefinido) {
      return localNotificationsPlugin.show(
        anotacaoModelo.id,
        anotacaoModelo.nomeAnotacao,
        anotacaoModelo.conteudoAnotacao,
        definicoesCanaisTipoPlataforma(),
        payload: "",
      );
    } else {
      formatarDataHora(anotacaoModelo);
      configTimeZone();
      //pegando a diferenca entra o horario agendado
      // e o horario do dispositivo
      Duration diferencaHora = tz.TZDateTime.now(tz.local).difference(
          DateTime(data.year, data.month, data.day, hora!.hour, hora!.minute));
      // verificando se a variavel contem
      // valor com sinal de negativo
      if (diferencaHora.inSeconds.toString().contains("-")) {
        diferencaHora = -(diferencaHora);
      }
      return localNotificationsPlugin.zonedSchedule(
          anotacaoModelo.id,
          anotacaoModelo.nomeAnotacao,
          anotacaoModelo.conteudoAnotacao,
          tz.TZDateTime.now(tz.local)
              .add(Duration(seconds: diferencaHora.inSeconds)),
          definicoesCanaisTipoPlataforma(),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,payload: "s");
    }
  }

  // future responsavel por
  // cancelar a notificacao
  Future<void> cancelarNotificacao(int id) async {
    iniciarServicoNotificacao();
    await localNotificationsPlugin.cancel(id);
  }

  // -------- Necessario para agendar a notificacao
  formatarDataHora(AnotacaoModelo anotacaoModelo) {
    DateTime? converterHora;
    //variavel vai receber o valor da string e
    // converter para o formato de hora
    converterHora = DateFormat("hh:mm").parse(anotacaoModelo.horario);
    TimeOfDay horaFormatar =
        TimeOfDay(hour: converterHora.hour, minute: converterHora.minute);
    hora = horaFormatar;
    data = DateFormat("dd/MM/yyyy", "pt_BR").parse(anotacaoModelo.data);
  }

  // future para configurar
  // o time zone para pegar o
  // horario local do dispositivo
  Future<void> configTimeZone() async {
    tz.initializeTimeZones();
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Detroit'));
  }
}
