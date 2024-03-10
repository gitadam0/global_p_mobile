


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
import '../my_colors.dart';
import 'PartnerListPage.dart';


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

            //Expanded(child: Ticketstage(testTicketList) ),
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

            Slidable(
              // Specify a key if the Slidable is dismissible.
              key: const ValueKey(0),

              // The start action pane is the one at the left or the top side.
              startActionPane: ActionPane(
                // A motion is a widget used to control how the pane animates.
                motion: const ScrollMotion(),

                // A pane can dismiss the Slidable.
                dismissible: Dismissible(
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      print("edit");
                      return false;
                    } else if (direction == DismissDirection.endToStart) {
                      print("delete");
                      return true;
                    }
                  },
                  key: Key("item.key"),
                  child: Container(
                    color: Colors.red,
                    height: 20,
                  ),
                ),


                // All actions are defined in the children parameter.
                children: [
                  // A SlidableAction can have an icon and/or a label.
                  SlidableAction(
                    onPressed: (context){

                    },
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    backgroundColor: Color(0xFF21B7CA),
                    foregroundColor: Colors.white,
                    icon: Icons.share,
                    label: 'Share',
                    onPressed: (context){

                    },
                  ),
                ],
              ),

              // The end action pane is the one at the right or the bottom side.
              endActionPane:  ActionPane(
                motion: StretchMotion(),
                children: [
                  SlidableAction(
                    // An action can be bigger than the others.
                    flex: 2,
                    onPressed: (context){
                      print("open");
                    },
                    backgroundColor: Color(0xFF7BC043),
                    foregroundColor: Colors.white,
                    icon: Icons.archive,
                    label: 'Archive',
                  ),
                ],
              ),


              // The child of the Slidable is what the user sees when the
              // component is not dragged.
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
            Container(
              height: 100,
              color: Colors.red,
              child: SwipeWidget(
                  onSwipe: () => print('Swiped!'),
                  onSwipeLeft: () => print('Swiped left! I feel rejected...'),
                  onSwipeRight: () => print('Swiped right!'),
                  onUpdate: (distance) => print('The distance of the swipe is $distance (from 0 to 1)'),
                distance: 0.5,
                angle: 0,
                rotation: 100,
                //scale: 2,
                dragStrenght: 1,
                child: Card(
                    elevation: 5,
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
      Ticket record = ticketList[index];

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