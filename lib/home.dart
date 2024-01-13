
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_p/widgets/CategoryItem.dart';
import 'package:global_p/widgets/ContactBottomSheet.dart';
import 'package:global_p/widgets/CustomBottomNavigationBar.dart';
import 'package:global_p/widgets/language_dropdown.dart';
import 'package:go_router/go_router.dart';

import 'all_providers.dart';
import 'data/data.dart';
import 'main.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class home extends ConsumerStatefulWidget {
  const home({Key? key}) : super(key: key);


  @override
  _homeState createState() => _homeState();
}

class _homeState extends ConsumerState<home> {

  @override
  Widget build(BuildContext context) {
    var selected_index=ref.watch(selectedIndex_bottomnav);
    Size s = MediaQuery.of(context).size;
    AppLocalizations? localizations = AppLocalizations.of(context);
    //var auth2 = ref.watch(remember_me);
    //var size = MediaQuery.of(context).size;
    //final String lang = ref.watch(languageProvider);

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
            // IconButton(
            //   icon: Icon(
            //     Icons.settings,
            //     color: Color(0xff798DB1),
            //   ),
            //   onPressed: () {
            //     // do something
            //   },
            // ),
            //DropdownButtonExample(),
            LangDropdownButton()

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
              title: const Text('Settings'),
              onTap: () {
                //Navigator.pushNamed(context, "/add_user");
              },
            ),
            ListTile(
              title:  Text( AppLocalizations.of(context)!.logout.toString()),
              onTap: () {
                //Navigator.pushReplacementNamed(context, "/login");
                context.go('/login');
              },
            ),
          ],
        ),
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 5,vertical:40),
              primary: false,
              crossAxisCount: 3,
                childAspectRatio: 0.9,
                children: [ for (var category in Categorys)
                  CategoryItem(img: category.img, name: "name")
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



