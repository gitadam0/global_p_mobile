import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_p/about.dart';
import 'package:global_p/contact.dart';
import 'package:global_p/routes/go_routers.dart';
import 'package:global_p/splash.dart';

import 'home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


final myProvider = StateProvider.autoDispose((ref) {
  return "en";
});

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  //String language="en";



  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final String lang = ref.watch(myProvider);
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,

      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale(lang),
      supportedLocales: [
        Locale('en'), // English
        Locale('fr'), // Spanish
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      //initialRoute: "/splash",
      // routes: {
      //   "/login": (context) => MyHomePage(title: "u",lang:"language"),
      //   "/about": (context) => about(),
      //   "/contact": (context) => contact(),
      //   "/splash": (context) => splash(),
      //   "/home": (context) => home(),
      //
      // },
      //home:splash() ,
    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({super.key, required this.title});

  final String title;



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var visible = true;
  var auth = true;
  var myform=GlobalKey<FormState>();
  //String text = 'welcome-text'.i18n();
   String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        centerTitle: true,
        title: Image.asset("images/gp.png",height: 40,),
          actions: <Widget>[
            DropdownButtonExample(),


          ]
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            // Hero(
            //   tag: "logo",
            //   child: Container(
            //     //margin:EdgeInsets.fromLTRB(100, 10, 100, 100)
            //       margin: EdgeInsets.only(top: 10),
            //       width: 250,
            //       child: Image.asset("images/gp.png")),
            // ),
            SizedBox(
              height: 120,
            ),

            //login form
            Form(
              key: myform,
              child: Column(children: [

                    Txtfield(

                        child: TextFormField(

                          //autovalidateMode:AutovalidateMode.onUserInteraction,
                          validator: (val){
                            if(!(val=="admin")){
                             // return "wrong username";
                            }
                          },

                          decoration: InputDecoration(
                            //contentPadding: EdgeInsets.only(left: 35, right: 5, top: 5, bottom: 5),
                            //errorStyle: TextStyle(fontSize: 12, height: 0),
                            //errorMaxLines: 1,
                            //errorStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.person,
                              color: Color(0xff798DB1),
                            ),
                            //hintText: "Username",
                            hintText: AppLocalizations.of(context)!.helloWorld.toString(),

                          ),
                          cursorColor: Color(0xff798DB1),
                        )),



                SizedBox(
                  height: 20,
                ),
                Txtfield(
                    child: TextFormField(
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
                  // if(myform.currentState!.validate()){
                  // }
                  //Navigator.pushNamed(context, "/home");
                  Navigator.pushReplacementNamed(context, "/home");
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
                      color: Color(0xff000000),
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
                      width: s.width * 0.25,

                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, "/about");
                          //  Navigator.push(
                          //      context,
                          //      PageRouteBuilder(
                          //          transitionDuration: Duration(seconds: 2),
                          //          pageBuilder: (_, __, ___) => about()));
                          //  Navigator.push(
                          //    context,
                          //    _createRoute1(),
                          //  );
                          _showBottomSheet(context,s.height*0.7);
                        },
                        child: Text('About Us'),
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(), primary: Color(0xff798DB1)),

                      ),
                    ),
                  SizedBox(width: 10,),

                  Hero(
                    tag:"btn1",
                    child: Container(
                      width: s.width * 0.25,

                      child: ElevatedButton(
                        onPressed: () {
                         // Navigator.pushNamed(context, "/about");
                         //  Navigator.push(
                         //      context,
                         //      PageRouteBuilder(
                         //          transitionDuration: Duration(seconds: 2),
                         //          pageBuilder: (_, __, ___) => about()));
                         //  Navigator.push(
                         //    context,
                         //    _createRoute1(),
                         //  );
                          _showBottomSheet(context,s.height*0.7);
                        },
                        child: Text('Demo'),
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(), primary: Color(0xff798DB1)),

                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    width: s.width * 0.25,
                    child: ElevatedButton(
                      onPressed: () {
                        _showBottomSheet_contact(context,s.height);
                      },
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





  void _showBottomSheet(BuildContext context,double height) {
    showModalBottomSheet(
      context: context,

      isScrollControlled: true, // Allows the content to extend beyond the height of the screen
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: _buildBottomSheetContent(context,height),
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetContent(BuildContext context, double height) {
    return Column(

      mainAxisSize: MainAxisSize.max,

      children: [
        // Your widget content for the bottom sheet here
        // This will take the whole screen except the app bar
        // For example:
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Close the bottom sheet when the button is pressed
          },
          child: Text('Close'),
        ),
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Text('About Us'),
        ),
        Container(
          height: height,
        child: ListView(

          children: [
            Text("adatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadata"),


          ],
        ),
        ),



      ],
    );
  }

  void _showBottomSheet_contact(BuildContext context,double height) {
    showModalBottomSheet(
      context: context,

      isScrollControlled: true, // Allows the content to extend beyond the height of the screen
      builder: (BuildContext context) {
        return SingleChildScrollView(

          child: Container(
            height: height,
            // padding: EdgeInsets.only(
            //   bottom: MediaQuery.of(context).viewInsets.bottom,
            // ),
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                Padding(
                  padding:  EdgeInsets.fromLTRB(10, 30, 10, 10),
                  child: Row(
                    children: [

                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(Icons.arrow_back,size: 30,),
                              ),
                            ),
                          ),
                          Expanded(
                               child: Container(
                                  //margin:EdgeInsets.fromLTRB(100, 10, 100, 100)
                                    margin: EdgeInsets.only(top: 10),
                                    width: 180,
                                    child: Image.asset("images/gp.png")),
                             ),
                        ],),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    'Address',
                    style: TextStyle(color: Color(0xff798DB1),fontSize: 25,fontWeight: FontWeight.bold),
                  ),
                ),
                Text("Morroco", style: TextStyle(fontSize: 15)),
                Text("Casablanca", style: TextStyle(fontSize: 15)),
                Text("hay llala mereim bloc b", style: TextStyle(fontSize: 15)),
                Text("Appartement n2", style: TextStyle(fontSize: 15)),

                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    'Contact Us',
                    style: TextStyle(color: Color(0xff798DB1),fontSize: 25,fontWeight: FontWeight.bold),
                  ),
                ),

                // Container(
                //   width: 160,padding: EdgeInsets.only(bottom: 15),
                //   child: Image.asset("images/img.png"),),
                Text("+212 0604594645", style: TextStyle(fontSize: 15),),
                Text("global.pref@gmail.com", style: TextStyle(fontSize: 15),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone),
                    Text(": +212 0604594645", style: TextStyle(fontSize: 15),),
                  ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.mail),
                    Text(": global.pref@gmail.com", style: TextStyle(fontSize: 15),),
                  ],),




              ],
            ),
          ),
        );
      },
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
//
// // Function to create the custom route with bottom-up animation
// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => contact(),
//     transitionDuration: Duration(seconds: 2),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       var begin = Offset(0.0, 1.0);
//       var end = Offset.zero;
//       var curve = Curves.ease;
//
//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }

const List<String> list = <String>['en', 'fr'];


class DropdownButtonExample extends ConsumerStatefulWidget   {
  //const DropdownButtonExample({super.key});
  const DropdownButtonExample({Key? key}): super(key: key);


  @override
  _DropdownButtonExampleState createState() => _DropdownButtonExampleState();
}


class _DropdownButtonExampleState extends ConsumerState<DropdownButtonExample> {
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
          setState(() {
            dropdownValue = value!;
            ref.read(myProvider.notifier).state=dropdownValue;
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