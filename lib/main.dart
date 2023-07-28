import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var visible = true;
  var myform=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
                //margin:EdgeInsets.fromLTRB(100, 10, 100, 100)
                margin: EdgeInsets.only(top: 10),
                width: 200,
                child: Image.asset("images/gp.png")),
            SizedBox(
              height: 120,
            ),

            //login form
            Form(
              key: myform,
              child: Column(children: [
                Stack(
                  children: [
                    Txtfield(

                        child: TextFormField(

                          //autovalidateMode:AutovalidateMode.onUserInteraction,
                          validator: (val){
                            if(!(val=="admin")){
                              return "wrong username";
                            }
                          },

                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 35, right: 5, top: 5, bottom: 5),
                            errorStyle: TextStyle(fontSize: 12, height: 0),
                            errorMaxLines: 1,
                            border: InputBorder.none,
                            //errorStyle: TextStyle(color: Colors.black),
                            // icon: Icon(
                            //   Icons.person,
                            //   color: Color(0xff798DB1),
                            // ),
                            hintText: "Username",
                            //labelText: "enter you name",
                            //labelStyle: TextStyle(color: Color(0xff798DB1))
                          ),
                          cursorColor: Color(0xff798DB1),
                        )),
                    Positioned(child: Icon(Icons.person,color: Color(0xff798DB1)),bottom: 5,top: 5,left: 10,),
                  ],
                ),


                SizedBox(
                  height: 20,
                ),
                Txtfield(
                    child: TextField(
                      obscureText: visible,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.lock,
                            color: Color(0xff798DB1),
                          ),
                          suffixIcon: GestureDetector(
                            child: Icon(Icons.remove_red_eye, color: Color(0xff798DB1)),
                            onTap: () {
                              setState(() {
                                visible = !visible;
                              });
                            },
                          ),
                          hintText: "enter you name"),
                      cursorColor: Color(0xff798DB1),
                    )),
              ],),
            ),

            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 50,
              width: s.width * 0.8,
              //width: 150,
              child: ElevatedButton(
                onPressed: () {
                  if(myform.currentState!.validate()){

                  }
                },
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(), primary: Color(0xff798DB1)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "forgot password?",
                  style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xff143a80)),
                ),
              ],
            ),
            Expanded(
                child: SizedBox(
              height: 10,
            )),
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: s.width * 0.4,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('About Us'),
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(), primary: Color(0xff798DB1)),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: s.width * 0.35,
                    //width: 150,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Contact'),
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(), primary: Color(0xff798DB1)),
                    ),
                  ),
                ],
              ),
            ),
            // Positioned(
            //   child: Align(
            //     alignment: Alignment.bottomCenter,
            //     child: Text("ddd"),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class Txtfield extends StatelessWidget {
  final Widget child;

  const Txtfield({required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: child,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      width: size.width * 0.8,
      height: 60,
      decoration: BoxDecoration(
          color: Color(0xffe5e5e5),
          borderRadius: BorderRadius.circular(29)),
    );
  }
}
