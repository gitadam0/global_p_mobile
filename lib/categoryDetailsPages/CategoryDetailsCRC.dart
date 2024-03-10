


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:global_p/widgets/CategoryItem.dart';
import 'package:global_p/widgets/ContactBottomSheet.dart';
import 'package:global_p/widgets/CustomBottomNavigationBar.dart';
import 'package:global_p/widgets/language_dropdown.dart';
import 'package:go_router/go_router.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:swipe_widget/swipe_widget.dart';

import '../../data/data.dart';
import '../../mainLogin.dart';
import 'dart:developer';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/Ticket.dart';


//final orpc = OdooClient('http://192.168.1.44:8069');
final orpc = OdooClient('http://83.171.249.157:8069');
class CategoryDetailsCRC extends ConsumerStatefulWidget {
  CategoryDetailsCRC({Key? key}) : super(key: key);


  @override
  _CategoryDetailsCRC createState() => _CategoryDetailsCRC();
}

class _CategoryDetailsCRC extends ConsumerState<CategoryDetailsCRC> {
  bool listtype=true;
  @override
  Widget build(BuildContext context) {
    var selected_index=ref.watch(selectedIndex_bottomnav);
    Size s = MediaQuery.of(context).size;
    AppLocalizations? localizations = AppLocalizations.of(context);

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

        ],
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body:Center(
        child: Column(
          children: [
            // diffrent list types
            Container(
              padding: EdgeInsets.only(right: 8,top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        listtype = false;
                      });

                    },
                    child: Container(
                      decoration: BoxDecoration(

                        border: Border.all(

                            color: listtype? Colors.white:Colors.black
                        ),

                      ),
                      child: Icon(Icons.grid_view_rounded),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      setState(() {
                        listtype = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(

                        border: Border.all(
                            color: listtype? Colors.black:Colors.white
                        ),

                      ),
                      child: Icon(Icons.list),
                    ),
                  ),
                ],
              ),
            ),
            //new
            GestureDetector(
              onPanUpdate: (details) {
                // Swiping in right direction.
                if (details.delta.dx > 0) {
                  print("swipe right");
                }
                // Swiping in left direction.
                if (details.delta.dx < 0) {
                  print("swipe left");
                }
              },
              onTap: (){
                context.push("/CategoryDetailsCRCNew");
              },
              child: Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text('New'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('new tickets000'),
                    ],
                  ),
                ),
              ),
            ),
            //done
            GestureDetector(
              onTap: (){
                context.push("/CategoryDetailsCRCDone");
              },
              child: Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text('Done'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Done tickets'),
                    ],
                  ),
                ),
              ),
            ),
            //canceld
            GestureDetector(
              onTap: (){
                context.push("/CategoryDetailsCRCanceled");
              },
              child: Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text('Canceled'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Canceled tickets'),
                    ],
                  ),
                ),
              ),
            ),
            //repon
            GestureDetector(
              onTap: (){
                context.push("/CategoryDetailsCRCReopend");
              },
              child: Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text('Reopend'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Reopend tickets'),
                    ],
                  ),
                ),
              ),
            ),
            //closed
            GestureDetector(
              onTap: (){
                context.push("/CategoryDetailsCRCClosed");
              },
              child: Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text('Closed'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Closed tickets'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        onPressed: (){/*
          createPartner();
          setState(() {
            fetchContacts();
          });*/
          //_showMyDialog();
        },
        mini: true,
        child: const Icon(Icons.add, color: Colors.white, size: 25),
      ),
    );

  }
}

Widget Ticketstage(List<Ticket> ticketList) {
  return ListView.builder(
    itemCount: ticketList.length,
    itemBuilder: (context, index) {
      return Card(
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: ListTile(
          title: Text('New'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('new tickets'),
            ],
          ),
        ),
      );
    },
  );
}