

import 'package:flutter/material.dart';

class about extends StatefulWidget {
  const about({Key? key}) : super(key: key);

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Green"),
      ),
      body: Hero(
        tag:"btn1",
        child: Container(
          width: s.width,

          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/about");
            },
            child: Text('About Us',style: TextStyle(color: Colors.black)),
            style: ElevatedButton.styleFrom( primary: Color(0xffffffff)),

          ),
        ),
      ),
    );
  }
}
