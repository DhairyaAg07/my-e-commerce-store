import 'package:flutter/material.dart';


class MySplashScreen extends StatefulWidget 
{
  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> 
{
  @override
  Widget build(BuildContext context) 
  {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pinkAccent,
              Colors.purpleAccent,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset('images/welcome.png'),
          ),
        ),
      ),
    );
  }
}
