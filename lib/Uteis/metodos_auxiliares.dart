import 'package:ciernote/Uteis/textos.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';

class MetodosAuxiliares {
  static exibirMensagens(String msg, String tipoAlerta, BuildContext context) {
    if (tipoAlerta == Textos.tipoAlertaSucesso) {
      ElegantNotification.success(
        width: 360,
        notificationPosition: NotificationPosition.topCenter,
        animation: AnimationType.fromTop,
        title: Text(tipoAlerta),
        animationDuration: const Duration(seconds: 1),
        toastDuration: const Duration(seconds: 2),
        description: Text(msg),
      ).show(context);
    } else {
      return ElegantNotification.error(
        width: 360,
        notificationPosition: NotificationPosition.topLeft,
        animation: AnimationType.fromTop,
        title: Text(tipoAlerta),
        animationDuration: const Duration(seconds: 1),
        toastDuration: const Duration(seconds: 2),
        description: Text(msg),
      ).show(context);
    }
  }

  static recuperarCorSelecionada(String corRecuperar) {
    dynamic cor = corRecuperar;
    String corString = cor.toString(); // Color(0x12345678)
    String valorString = corString.split('(0x')[1].split(')')[0];
    int valor = int.parse(valorString, radix: 16);
    Color instanciaCor = Color(valor);
    return instanciaCor;
  }
}
