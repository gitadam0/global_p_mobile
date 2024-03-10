
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_p/widgets/CategoryItem.dart';
import 'package:global_p/widgets/ContactBottomSheet.dart';
import 'package:global_p/widgets/CustomBottomNavigationBar.dart';
import 'package:global_p/widgets/language_dropdown.dart';
import 'package:go_router/go_router.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import '../../../data/data.dart';
import '../../../mainLogin.dart';
import 'dart:developer';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/Ticket.dart';
import '../../my_colors.dart';


//final orpc = OdooClient('http://192.168.1.44:8069');
final orpc = OdooClient('http://83.171.249.157:8069');
class CategoryDetailsCRCNew extends ConsumerStatefulWidget {
  CategoryDetailsCRCNew({Key? key}) : super(key: key);


  @override
  _CategoryDetailsCRCNew createState() => _CategoryDetailsCRCNew();
}

class _CategoryDetailsCRCNew extends ConsumerState<CategoryDetailsCRCNew> {

  @override
  Widget build(BuildContext context) {
    var selected_index=ref.watch(selectedIndex_bottomnav);
    Size s = MediaQuery.of(context).size;
    AppLocalizations? localizations = AppLocalizations.of(context);

    Future<dynamic> fetchCentreDeRelationClient() async {
      //await orpc.authenticate('odoo15_2023_adam', 'odoo15_2023_adam', '123');
      await orpc.authenticate('odoo_crc', 'adm.mdd@gmail.com', '12345678');
      return orpc.callKw({
        'model': 'helpdesk.ticket',
        'method': 'search_read',
        'args': [],
        //name
        //person_name
        //company_id
        //done_stage_boolean
        //cancel_stage_boolean
        //reopen_stage_boolean
        //closed_stage_boolean
        //active
        //email_subject
        //create_date
        //is_fast_track
        //progress: 100.0
        'kwargs': {
          'context': {'bin_size': true},
          'domain': [],
          'fields': [
            "name",
            "person_name",
            "company_id",
            "done_stage_boolean",
            "reopen_stage_boolean",
            "cancel_stage_boolean",
            "closed_stage_boolean",
            "active",
            "email_subject",
            "is_fast_track",
            "progress",
          ],
          'limit': 80,
        },
      });
    }






    Widget buildTickets() {


        /*//from database
        //from database
        //from database
        *//*return FutureBuilder(
            future: fetchCentreDeRelationClient(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final record =
                      snapshot.data[index] as Map<String, dynamic>;
                      return RelationClientTicketListItem(record,context);
                    });
              } else {
                if (snapshot.hasError) return Text('Unable to fetch data'+snapshot.error.toString());
                return CircularProgressIndicator();
              }
            });*//*
        //from offline
        //from offline
        //from offline*/
        return RelationClientTicketListItemtestinglocaldata(testTicketList );



    }




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
            Expanded(child: buildTickets()),
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
          _showMyDialog();
        },
        mini: true,
        child: const Icon(Icons.add, color: Colors.white, size: 25),
      ),
    );

  }




  //
  //
  //create ticket
  //
  //
  Future<void> _showMyDialog() async {
    TextEditingController nameController = TextEditingController();
    TextEditingController companyController = TextEditingController();
    TextEditingController percentageController = TextEditingController();

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

                    Icon(Icons.receipt_long,size:60,color: mcgpalette0,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text('Create Ticket'),
                    ),
                  ],
                ),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //ticket name
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Ticket Name',
                            labelStyle:TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                            /*suffixIcon: Icon(
                              Icons.person,
                            ),*/
                            focusedBorder:  OutlineInputBorder(
                              borderSide:  BorderSide(color: Colors.black ),
                            ),
                          ),
                        ),
                      ),
                      //ticket company
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: companyController,
                          decoration: InputDecoration(
                            labelText: 'Company',
                            labelStyle:TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                            focusedBorder:  OutlineInputBorder(
                              borderSide:  BorderSide(color: Colors.black ),
                            ),
                          ),
                        ),
                      ),
                      //ticket ppercentage
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a percentage';
                            }
                            if (double.parse(value)  <0 ) {
                              return 'percentage should be more then0';
                            }
                            if (double.parse(value)  >100 ) {
                              percentageController.text="100";
                              return null;
                            }
                            return null;
                          },
                          controller: percentageController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            labelText: 'Percentage %',
                            labelStyle:TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                            focusedBorder:  OutlineInputBorder(
                              borderSide:  BorderSide(color: Colors.black ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // Validate the form
                          if (_formKey.currentState!.validate()) {
                            testTicketList.add(
                                Ticket(
                                    name: nameController.text, personName: "personName",
                                    companyId: "companyId",
                                    doneStageBoolean: false,
                                    reopenStageBoolean: false,
                                    cancelStageBoolean: false,
                                    closedStageBoolean: false,
                                    active: false, emailSubject: "emailSubject",
                                    isFastTrack: false,
                                    progress: (double.parse(percentageController.text)/100)
                                )
                            );
                            print(double.parse(percentageController.text)/100);
                            setState(() {
                            });
                            Navigator.of(context).pop();
                          } else {

                            print('Button clicked with empty TextField');
                          }
                        });
                        // if(nameController.text.trim().isEmpty || int.parse(percentageController.text) <0){
                        //   print("error check log");
                        // }else{
                        //   /*//createPartner(nameController.text);
                        //   setState(() {
                        //     //fetchContacts();
                        //   });*/
                        //
                        //   if(double.parse(percentageController.text)>100){
                        //     percentageController.text="100";
                        //   }
                        //   testTicketList.add(
                        //       Ticket(
                        //           name: nameController.text, personName: "personName",
                        //           companyId: "companyId",
                        //           doneStageBoolean: false,
                        //           reopenStageBoolean: false,
                        //           cancelStageBoolean: false,
                        //           closedStageBoolean: false,
                        //           active: false, emailSubject: "emailSubject",
                        //           isFastTrack: false,
                        //           progress: (double.parse(percentageController.text)/100)
                        //       )
                        //   );
                        //   print(double.parse(percentageController.text)/100);
                        //   setState(() {
                        //   });
                        //   Navigator.of(context).pop();
                        // }

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("Create"),
                      )
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }



}




Widget RelationClientTicketListItem(Map<String, dynamic> record,BuildContext context) {

  return Card(
    elevation: 3,
    margin: EdgeInsets.all(10),
    child: ListTile(

      title: Text('${record['name']}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${record['email_subject']}'),
          Text('${record["company_id"][1]} ' ),
          if (record['person_name']!="") Text('${record['person_name']}'),
          Text('active: ${record['active']}'),
          if (record['done_stage_boolean']) RoundedStatusWidget("done stage",Colors.green),
          if (record['reopen_stage_boolean']) RoundedStatusWidget("reopen stage",Color.fromRGBO(
              255, 228, 0, 1.0)),
          if (record['closed_stage_boolean']) RoundedStatusWidget("closed stage",Colors.redAccent),
          if (record['cancel_stage_boolean']) RoundedStatusWidget("cancel stage",Colors.red),
          if (!record['done_stage_boolean'] && !record['reopen_stage_boolean'] && !record['closed_stage_boolean'] && !record['cancel_stage_boolean'])
            RoundedStatusWidget("new stage",Color.fromRGBO(
                19, 103, 20, 1.0)),
          Text('is_fast_track: ${record['is_fast_track']}'),
          //Text('progress: ${record['progress']}'),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 8, // Set the height as per your design
                width: MediaQuery.of(context).size.width* 0.7, // Adjust the width as needed
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), // Adjust the radius as needed
                  border: Border.all(color: Colors.grey), // Adjust the border color as needed
                ),
                child: LinearProgressIndicator(
                  value: record['progress'], // Assuming progress is a double between 0 and 1
                  minHeight: 8,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),

              Text('${record['progress']}%'),
            ],
          ),

          //Text('Base URL: ${orpc.baseURL}'),
        ],
      ),
    ),
  );
}

Widget RelationClientTicketListItemtestinglocaldata(List<Ticket> ticketList) {
  return ListView.builder(
    itemCount: ticketList.length,

    itemBuilder: (context, index) {
      Ticket record = ticketList[index];
      if (record.doneStageBoolean || record.cancelStageBoolean || record.closedStageBoolean || record.reopenStageBoolean) {
        // Skip items that don't meet the condition
        return Container(); // or return null;
      }
      return Card(
        elevation: 3,
        margin: EdgeInsets.all(10),
        child: ListTile(
          title: Text('${record.name}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${record.companyId} '),
              Text('${record.personName}'),
              Text('active: ${record.active}'),
              Text('${record.emailSubject}'),
              if (record.doneStageBoolean) RoundedStatusWidget("done stage",Colors.grey),
              if (record.reopenStageBoolean) RoundedStatusWidget("reopen stage",Colors.yellow),
              if (record.closedStageBoolean) RoundedStatusWidget("closed stage",Colors.redAccent),
              if (record.cancelStageBoolean) RoundedStatusWidget("cancel stage",Colors.red),
              if (!record.doneStageBoolean && !record.reopenStageBoolean && !record.closedStageBoolean && !record.cancelStageBoolean)
                RoundedStatusWidget("new stage",Color.fromRGBO(
                    19, 103, 20, 1.0)),
              Text('is_fast_track: ${record.isFastTrack}'),
              Text('progress: ${record.progress}'),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 8, // Set the height as per your design
                    width: MediaQuery.of(context).size.width* 0.7, // Adjust the width as needed
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4), // Adjust the radius as needed
                      border: Border.all(color: Colors.grey), // Adjust the border color as needed
                    ),
                    child: LinearProgressIndicator(
                      value: record.progress, // Assuming progress is a double between 0 and 1
                      minHeight: 8,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ),

                  Text((record.progress*100).toString()+'%'),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
Widget RoundedStatusWidget (String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      text,
      style: TextStyle(color: Colors.white),
    ),
  );
}