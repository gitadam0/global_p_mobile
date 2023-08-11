import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_p/about.dart';
import 'package:global_p/contact.dart';
import 'package:global_p/routes/go_routers.dart';
import 'package:global_p/splash.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'my_colors.dart';


final myProvider = StateProvider.autoDispose((ref) {
  return "en";
});

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


    final String lang = ref.watch(myProvider);
    final String remember = ref.watch(myProvider);
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

   String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {

    var selected_index=ref.watch(selectedIndex_bottomnav);
    var auth2 = ref.watch(remember_me);
    Size s = MediaQuery.of(context).size;

    //
    //
    //Scaffold
    //
    //

    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selected_index == -1 ? 0: selected_index,
        selectedItemColor: selected_index == -1 ? Colors.grey[600] : Color(0xff798DB1),
        unselectedItemColor: Colors.grey[600],
        /*backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.onSurface,

        selectedLabelStyle: textTheme.caption,
        unselectedLabelStyle: textTheme.caption,
        */

        onTap: (value) {
          // Respond to item press.
          //ref.read(selectedIndex_bottomnav.notifier).state=value;
          if (value==0){
            context.push("/onboarding");
          }
          if (value==1){
            _showBottomSheet_contact(context,s.height);
          }
          if (value==2){
            //MapUtils.openMap(-3.823216,-38.481700);
            navigateTo(-3.823216,-38.481700);
          }
        },
        items: [
          BottomNavigationBarItem(
            label: 'Demo',
            icon: Icon(Icons.phone_android_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Contact',
            icon: Icon(Icons.call),
          ),
          BottomNavigationBarItem(
            label: 'Location',
            icon: Icon(Icons.location_on),
          ),
          BottomNavigationBarItem(
              label: 'Help',
            icon: Icon(Icons.contact_support),
          ),
        ],
      ),
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
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Container(
                width: s.width*0.75,
                child: Align(alignment: Alignment.centerLeft,
                    child: Text(
                      "Sign In",
                      style:TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff798DB1)) ,
                    )
                ),
              ),
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
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              //decoration: BoxDecoration(color: Color(0x55000000)),
              width: s.width*0.8,
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //
                  //Checkbox
                  //
                  Row(children: [
                    Transform.scale(
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
                    ),
                    Text("Remember me"),


                  ],),
                  GestureDetector(
                    onTap: (){
                      _showMyDialog();
                    },
                    child: Text(
                      "forgot password?",
                      style: TextStyle(
                          color: Color(0xff000000),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xff143a80)),
                    ),
                  ),
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
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(), primary: Color(0xff798DB1)),
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
//
  //
  //
  //Contact
  //
  //
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
//
  //
  //Forgot password
  //
  //
  Future<void> _showMyDialog() async {
    return showDialog<void>(

      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {

        return AlertDialog(

          title: const Text('Forgot password'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),

                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    //initialValue: 'Input text',
                    decoration: InputDecoration(
                      labelText: 'Label text',
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


              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },

            ),
          ],
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
        elevation: 16,
        style: const TextStyle(color: Colors.black),
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





class MapUtils {

  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}

 void navigateTo(double lat, double lng) async {
var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
if (await canLaunch(uri.toString())) {
await launch(uri.toString());
} else {
//print("could not launch");
throw 'Could not launch ${uri.toString()}';
}
}