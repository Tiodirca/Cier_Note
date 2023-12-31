import 'package:ciernote/Uteis/constantes.dart';
import 'package:ciernote/Uteis/servico_notificacoes.dart';
import 'package:ciernote/Uteis/rotas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


void main() {
  runApp(MultiProvider(
    providers: [
        Provider<NotificacaoServico>(
          create: (context) => NotificacaoServico(),
        )
    ],child: const MyApp(),
  ));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //definicoes usadas no date picker
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      //setando o suporte da
      // lingua usada no data picker
      supportedLocales: const [Locale('pt', 'BR')],
      debugShowCheckedModeBanner: false,
      initialRoute: Constantes.rotaTelaInicial,
      onGenerateRoute: Rotas.gerarRotas,
    );
  }
}
