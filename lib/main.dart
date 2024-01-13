import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_p/about.dart';
import 'package:global_p/contact.dart';
import 'package:global_p/data/data.dart';
import 'package:global_p/models/expansion_error.dart';
import 'package:global_p/routes/go_routers.dart';
import 'package:global_p/splash.dart';
import 'package:global_p/widgets/ContactBottomSheet.dart';
import 'package:global_p/widgets/CustomBottomNavigationBar.dart';
import 'package:global_p/widgets/language_dropdown.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'all_providers.dart';
import 'home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'my_colors.dart';



final remember_me = StateProvider.autoDispose((ref) {
  return false;
});

final selectedIndex_bottomnav = StateProvider.autoDispose((ref) {
  return -1;
});



void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  //String language="en";



  @override
  Widget build(BuildContext context,WidgetRef ref) {


    final String lang = ref.watch(languageProvider);
    //final String remember = ref.watch(myProvider);
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
        Locale('es'), // Spanish
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: mcgpalette0,
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

class MyHomePage extends ConsumerStatefulWidget  {
   MyHomePage({super.key, required this.title});

  final String title;



  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {

  var value=false;

  var visible = true;
  var myform=GlobalKey<FormState>();
  var t1 =TextEditingController();
  var t2 =TextEditingController();
  var auth = false;

  var stepper_step=0;

  //String dropdownValue = lang_list.first;
  @override
  Widget build(BuildContext context) {
    var selected_index=ref.watch(selectedIndex_bottomnav);
    var auth2 = ref.watch(remember_me);
    Size s = MediaQuery.of(context).size;
    AppLocalizations? localizations = AppLocalizations.of(context);

    //
    //
    //Scaffold
    //
    //

    return Scaffold(
       bottomNavigationBar: CustomBottomNavigationBar(
      selectedTabIndex: selected_index,
      onTabTapped: (value) {
        if (value == 0) {
          context.push("/onboarding");
        }
        if (value == 1) {
          //_showBottomSheet_contact(context, s.height);
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return ContactBottomSheet();
            },
          );
        }
        if (value == 2) {
          context.push('/map');
        }
        if (value == 3) {
          context.push('/help');
        }
      },
      localizations: localizations,
    ),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        centerTitle: true,
        title: Image.asset("images/gp.png",height: 40,),
          actions: <Widget>[
            LangDropdownButton()


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
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Container(
                width: s.width*0.75,
                child: Align(alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.signin.toString(),
                      style:TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff798DB1)) ,
                    )
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //
            //
            //Login form
            //
            //
            Form(
              key: myform,
              child: Column(children: [

                    Txtfield(

                        child: TextFormField(
                          controller: t1,
                          //autovalidateMode:AutovalidateMode.onUserInteraction,
                          // validator: (val){
                          //   if(!(val=="admin")){
                          //     return "wrong username";
                          //   }
                          // },
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
                            hintText: AppLocalizations.of(context)!.username.toString(),
                          ),
                          cursorColor: Color(0xff798DB1),
                        )
                    ),
                SizedBox(
                  height: 20,
                ),
                Txtfield(
                    child: TextFormField(
                      controller: t2,
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
                          hintText: AppLocalizations.of(context)!.password.toString()
                      ),
                      cursorColor: Color(0xff798DB1),
                    )),
              ],),
            ),

            auth?
            Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              //decoration: BoxDecoration(color: Color(0x55000000)),
              width: s.width*0.72,
              child: Text("wrong credentiels",style: TextStyle(color: Colors.red),),
            ):
            Container(
              height: 0,
              padding: EdgeInsets.fromLTRB(0, 0, 0,0 ),
              //decoration: BoxDecoration(color: Color(0x55000000)),
              width: s.width*0.72,
              child: Text("",style: TextStyle(color: Colors.red),),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              //decoration: BoxDecoration(color: Color(0x55000000)),
              width: s.width*0.8,
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //
                  //Checkbox
                  //
                  Row(children: [
                    /*Transform.scale(
                      scale: 0.9,
                      child: Checkbox(
                        checkColor: Color(0xff000000),
                        activeColor:Color(0xff798DB1) ,
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(4))),
                        value: auth2,
                        onChanged: (n){

                          ref.read(remember_me.notifier).state=!ref.watch(remember_me);
                        },
                      ),
                    ),*/
                    Transform.scale(
                      scale: 1,
                      child: Switch(
                        activeColor: Color(0xff798DB1),
                        value: auth2,
                        onChanged: (newValue) {
                          ref.read(remember_me.notifier).state = !ref.watch(remember_me);
                        },
                      ),
                    ),

                    Text(AppLocalizations.of(context)!.rememberme.toString()),


                  ],),
                ],
              ),
            ),
            //
            //
            // // // Login Button
            //
            //
            SizedBox(
              height: 50,
              width: s.width * 0.8,
              //width: 150,
              child: ElevatedButton(
                onPressed: () {
                   // if(myform.currentState!.validate()){
                   // }
                  if(t1.text=="" && t2.text==""){
                    setState(() {
                      auth=false;
                      context.go('/home');
                    });
                  }else{
                    setState(() {
                      auth=true;
                    });
                  }
                  //context.go('/home');
                },
                child: Text(AppLocalizations.of(context)!.login.toString()),
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(), primary: Color(0xff798DB1)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: (){
                  _showMyDialog();
                },
                child: Text(
                  AppLocalizations.of(context)!.forgot.toString(),
                  style: TextStyle(
                      color: Color(0xff000000),
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xff143a80),fontSize: 15),


                ),
              ),
            ),


            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       "forgot password?",
            //       style: TextStyle(
            //           color: Color(0xff000000),
            //           decoration: TextDecoration.underline,
            //           decorationColor: Color(0xff143a80)),
            //     ),
            //   ],
            // ),
            Expanded(
                child: SizedBox(
              height: 10,
            )),
            //
            //
            //OLD BOTTOM NAVIGATION
            //
            //
            /*Container(
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
                         // _showBottomSheet(context,s.height*0.7);
                          //context.go('/onboarding');
                          //GoRouter.of(context).go("/onboarding");
                          context.push("/onboarding");
                          //GoRouter.of(context).push("/onboarding");
                        },
                        child: Text('Demo',style: TextStyle(color: Colors.black),),
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(), primary: Color(0xffd7d7d7)),

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
            ),*/

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




  /*void _showBottomSheet(BuildContext context,double height) {
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
            Text("adatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatyy"),
          ],
        ),
        ),
      ],
    );
  }*/

  //
  //
  //
  //Contact
  //
  //
  /*void _showBottomSheet_contact(BuildContext context,double height) {
    showModalBottomSheet(
      context: context,

      isScrollControlled: true, // Allows the content to extend beyond the height of the screen
      builder: (BuildContext context) {
        Size s = MediaQuery.of(context).size;
        return SingleChildScrollView(

          child: Container(
            height: height,
            // padding: EdgeInsets.only(
            //   bottom: MediaQuery.of(context).viewInsets.bottom,
            // ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Text(
                    'Contact Us',
                    style: TextStyle(color: Color(0xff798DB1),fontSize: 25,fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text("Nos conseillers sont à votre disposition pour toute information ou réclamation du lundi au vendredi de 8h30 à 20h30 et le samedi de 10h à 18h.", style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Center(
                              child: GestureDetector(
                                onTap: (){
                                  //launch("tel://0604485462");
                                  //UrlLauncher.launch("tel://21213123123");
                                  launch("tel:" + Uri.encodeComponent('*123#'));

                                },
                                child: Container(
                                  child: Icon(Icons.phone),
                                  padding: EdgeInsets.symmetric(horizontal: 42, vertical: 5),
                                  height: 60,
                                  width: s.width*0.4 ,
                                  decoration: BoxDecoration(
                                      color: Color(0xffe5e5e5),
                                      borderRadius: BorderRadius.circular(29)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Center(
                              child: GestureDetector(
                                onTap: (){
                                  launch('mailto:adm.mdd@gmail.com');
                                },
                                child: Container(
                                  child: Icon(Icons.mail),
                                  padding: EdgeInsets.symmetric(horizontal: 42, vertical: 5),
                                  height: 60,
                                  width: s.width*0.4 ,
                                  decoration: BoxDecoration(
                                      color: Color(0xffe5e5e5),
                                      borderRadius: BorderRadius.circular(29)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),


                  ],
                  ),
                ),




              ],
            ),
          ),
        );
      },
    );
  }*/



  /*//
  //
  //
  //Help
  //
  //

  void _showBottomSheet_help(BuildContext context,double height) {
    showModalBottomSheet(
      isScrollControlled: true, // Allows the content to extend beyond the height of the screen
      context: context,
      builder: (BuildContext context) {
        Size s = MediaQuery.of(context).size;
        var helplist_watch=ref.watch(help_list_provider);

            return Container(
              height: height,
              // padding: EdgeInsets.only(
              //   bottom: MediaQuery.of(context).viewInsets.bottom,
              // ),
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
                                    child: Icon(Icons.arrow_back, size: 30,),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Text(
                      'HELPPPPPPPPPPPPPPPPPPPPP Us',
                      style: TextStyle(color: Color(0xff798DB1),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ExpansionPanelList(
                    //animationDuration: Duration(milliseconds: 100),
                    expansionCallback: (int index, bool isExpanded) {
                      //help_list[index].isexpanded=!isExpanded;
                      ref.read(help_list_provider.notifier).state[index].isexpanded = !ref.read(help_list_provider.notifier).state[index].isexpanded;

                    },
                    children: helplist_watch.map<ExpansionPanel>((
                        ExpantionError e) {
                      return ExpansionPanel(
                        headerBuilder:
                            (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text('Item 1' + e.text),
                          );
                        },
                        body: ListTile(
                          title: Text('Item 1 child'),
                          subtitle: Text('Details goes here'),
                        ),
                        isExpanded: e.isexpanded,
                      );
                    }).toList(),

                  )


                ],
              ),
            );

      },
    );
  }*/

  //
  //
  //Forgot password
  //
  //
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must not tap button!
      builder: (BuildContext context) {
        Size s = MediaQuery.of(context).size;
        return AlertDialog(
          content:  SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Icon(Icons.error_outline,size:60,color: mcgpalette0,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text('Forgot password'),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("enter your email and we'll send you a link if we find it",style: TextStyle(color: Colors.grey)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    //initialValue: 'Input text',
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle:TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.mail,


                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderSide:  BorderSide(color: Colors.black ),
                      ),
                    ),


                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("Send"),
                      )
                  ),
                ),



              ],
            ),
          ),
          actions: <Widget>[
            /*TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },

            ),*/
            /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: s.width,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Send")
                ),
              ),
            )*/
          ],
        );
      },
    );
  }





//

}//_MyHomePageState end

//


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



//
//
//Opens map to one location
//
//
Future<void> _openMap(double latitude, double longitude) async {
  final String mapUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
  if (await canLaunch(mapUrl)) {
    await launch(mapUrl);
  } else {
    throw 'Could not launch map.';
  }
}
