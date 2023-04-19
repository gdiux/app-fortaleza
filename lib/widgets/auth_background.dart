// ignore: unused_import
// ignore_for_file: sort_child_properties_last, sized_box_for_whitespace, camel_case_types, unnecessary_this

import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class AuthBackground extends StatelessWidget{

  final Widget child;

  const AuthBackground({
    Key? key,
    required this.child
  }): super (key: key);
  
  @override
  Widget build( BuildContext context) {

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),

          _iconHeader(),

          this.child
          
        ],
      ),
    );

  }

}

class _iconHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 50),
        child: const Icon( Icons.person_pin, color: Colors.white, size: 100),
      ),
    );
  }
}

// ignore: unused_element
class _PurpleBox extends StatelessWidget{


  @override
  Widget build( BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _purpleBack(),
      child: Stack(
        children: [
          
          Positioned(child: _Bubble(), top: 90, left: 30,),
          Positioned(child: _Bubble(), top: 30, left: 80,),
          Positioned(child: _Bubble(), top: -40, left: -50,),
          Positioned(child: _Bubble(), bottom: 90, right: 30,),
          Positioned(child: _Bubble(), bottom: 90, right: 30,)
        ],
      ),
    );
  }

  // Degradado Fondo
  BoxDecoration _purpleBack() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(52,74,150, 1),
          Color.fromRGBO(54, 64, 128, 1),
        ]
      )
    );
  }
}

// BUBBLE O CIRCULOS
// ignore: unused_element
class _Bubble extends StatelessWidget{
  
  @override
  Widget build( BuildContext context) {
    return  Container(
      
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.05)
      ),

    );
  }
}