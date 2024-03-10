

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'mainLogin.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gohome();
  }

  gohome()async{
    await Future.delayed(
        Duration(milliseconds: 1500),
        (){
          //Navigator.pushReplacementNamed(context, "/home");
          
           // Navigator.pushReplacement(
           //     context,
           //     PageRouteBuilder(
           //         transitionDuration: Duration(seconds: 1),
           //         pageBuilder: (_, __, ___) => MyHomePage(title: "Global")));

          context.go('/login');
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:GestureDetector(

          child: Hero(
            tag: "logo",
            child: Container(
              //margin:EdgeInsets.fromLTRB(100, 10, 100, 100)
                margin: EdgeInsets.only(top: 10),
                width: 250,
                child: Image.asset("images/gp.png")),
          ),
        ),
      ),
    );
  }
}
