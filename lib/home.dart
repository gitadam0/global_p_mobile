
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          centerTitle: true,
          title: Image.asset("images/gp.png",height: 40,),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Color(0xff798DB1),
              ),
              onPressed: () {
                // do something
              },
            )
          ],
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),

    );
  }
}
