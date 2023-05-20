import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Inicializador extends StatelessWidget {
  const Inicializador({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Aplicativo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      primarySwatch: Colors.blue,
      ),
    );

  }
}