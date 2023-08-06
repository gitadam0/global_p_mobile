
import 'package:flutter/material.dart';

import 'data.dart';
import 'main.dart';



class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          centerTitle: true,
          title: Image.asset("images/gp.png",height: 40,),
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(
            //     Icons.settings,
            //     color: Color(0xff798DB1),
            //   ),
            //   onPressed: () {
            //     // do something
            //   },
            // ),
            DropdownButtonExample()

          ],
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff798DB1),
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Add User'),
              onTap: () {
                //Navigator.pushNamed(context, "/add_user");
              },
            ),
            ListTile(
              title: const Text('Log out'),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/login");
              },
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
            child: SizedBox(
              height: 45,
              child: TextField(
                cursorHeight: 20,
                decoration: InputDecoration(

                    prefixIcon: Icon(Icons.search),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),

                    hintText: 'Search Here...'),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(10),
              primary: false,
              crossAxisCount: 3,
                children: [
                  ...(Categorys.map((e){
                    return Container(
                      child: Column(
                        children: [
                          Container(child: Image.asset(e.img,fit: BoxFit.fitHeight,),height: 80,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e.name),
                          ),
                        ],
                      ),
                    );
                  }
                  ))

                ],
            ),
          ),
        ],
      ),
      // Container(
      //   decoration: BoxDecoration(color: Colors.red),
      //   width: size.width/2,
      //   height: 150,
      //   child: Card(
      //
      //     child: Padding(
      //       padding: const EdgeInsets.all(10),
      //       child: Column(children: [
      //        Container(
      //
      //            width:100,
      //            child: Image.asset("images/gp.png")),
      //
      //
      //       ],),
      //     ),
      //   ),
      // ),

    );
  }
}




class DropdownButtonExample extends StatefulWidget {
  //const DropdownButtonExample({super.key});


  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}


class _DropdownButtonExampleState extends State<DropdownButtonExample> {


  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: DropdownButton<String>(
        value: dropdownValue,

        //elevation: 16,
        style:
        const TextStyle(color: Colors.black),

        onChanged: (String? value) {
          // This is called when the user selects an item.
          print("dropdownValue.toString()");
          setState(() {
            dropdownValue = value!;

          });
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

