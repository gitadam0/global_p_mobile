import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: s.height,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        Padding(
        padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
        child: Row(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.arrow_back, size: 30),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  width: 180,
                  child: Image.asset("images/gp.png"),
                ),

              ),

          ],
        ),
        ),
    ],
      ),
    ),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Text(
    'Contact Us',
    style: TextStyle(
    color: Color(0xff798DB1),
    fontSize: 25,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    "Nos conseillers sont à votre disposition pour toute information ou réclamation du lundi au vendredi de 8h30 à 20h30 et le samedi de 10h à 18h.",
    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    ),
    SizedBox(height: 20),
    Row(
    children: [
    Padding(
    padding: const EdgeInsets.all(7.0),
    child: GestureDetector(
    onTap: () {
    launch("tel:" + Uri.encodeComponent('*123#'));
    },
    child: Container(
    child: Icon(Icons.phone),
    padding: EdgeInsets.symmetric(horizontal: 42, vertical: 5),
    height: 60,
    width: s.width * 0.4,
    decoration: BoxDecoration(
    color: Color(0xffe5e5e5),
    borderRadius: BorderRadius.circular(29),
    ),
    ),
    ),
    ),
    Padding(
    padding: const EdgeInsets.all(7.0),
    child: GestureDetector(
    onTap: () {
    launch('mailto:adm.mdd@gmail.com');
    },
    child: Container(
    child: Icon(Icons.mail),
    padding: EdgeInsets.symmetric(horizontal: 42, vertical: 5),
    height: 60,
    width: s.width * 0.4,
    decoration: BoxDecoration(
    color: Color(0xffe5e5e5),
    borderRadius: BorderRadius.circular(29),
    ),
    ),
    ),
    ),
    ],
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    );
  }
}
