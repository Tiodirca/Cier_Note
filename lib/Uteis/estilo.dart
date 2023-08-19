import 'package:ciernote/Uteis/paleta_cores.dart';
import 'package:flutter/material.dart';

class Estilo {
  ThemeData get estiloGeral => ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: PaletaCores.corAzul,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          errorStyle: TextStyle(
              fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(width: 2, color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(width: 2, color: Colors.white)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(width: 2, color: Colors.white)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(width: 2, color: Colors.red)),
        ),
      );
}
