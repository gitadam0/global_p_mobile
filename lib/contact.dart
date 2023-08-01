

import 'package:flutter/material.dart';

class contact extends StatefulWidget {
  const contact({Key? key}) : super(key: key);

  @override
  State<contact> createState() => _contactState();
}

class _contactState extends State<contact> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      body: Hero(
        tag: "btn2",
        child: Column(
          children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                    child: Text(
                      'Contact',
                      style: TextStyle(color: Colors.black,fontSize: 15),
                    ),
                  ),

          ],
        ),
      ),
    );
  }
}
