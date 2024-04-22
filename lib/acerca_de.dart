import 'package:flutter/material.dart';

class AcercaDe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de Echoing Emotions'),
      ),
      body: Center(
        child: Text(
          'Información sobre Echoing Emotions',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
