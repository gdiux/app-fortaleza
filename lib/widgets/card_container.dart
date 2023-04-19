// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unnecessary_this

import 'package:flutter/material.dart';

// ignore: unused_element
class CardContainer extends StatelessWidget{

  final Widget child;

  const CardContainer({
    Key? key,
    required this.child
  }) : super(key: key);

  @override
  Widget build( BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 30 ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: _cardShape(),
        child: this.child,
      ),
    );
  }

  // ESTILO DE LA TARJETA
  BoxDecoration _cardShape() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 15,
          offset: Offset(0,5)    
        )
      ]

    );
  }
}