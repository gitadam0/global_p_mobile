
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_p/widgets/CategoryItem.dart';
import 'package:global_p/widgets/ContactBottomSheet.dart';
import 'package:global_p/widgets/CustomBottomNavigationBar.dart';
import 'package:global_p/widgets/language_dropdown.dart';
import 'package:go_router/go_router.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import '../../data/data.dart';
import '../../main.dart';
import 'dart:developer';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/Ticket.dart';
import 'PartnerListPage.dart';


//final orpc = OdooClient('http://192.168.1.44:8069');
final orpc = OdooClient('http://83.171.249.157:8069');
class CategoryDetailsCRC extends ConsumerStatefulWidget {
  CategoryDetailsCRC({Key? key}) : super(key: key);


  @override
  _CategoryDetailsCRC createState() => _CategoryDetailsCRC();
}

class _CategoryDetailsCRC extends ConsumerState<CategoryDetailsCRC> {

  @override
  Widget build(BuildContext context) {
    var selected_index=ref.watch(selectedIndex_bottomnav);
    Size s = MediaQuery.of(context).size;
    AppLocalizations? localizations = AppLocalizations.of(context);
    //var auth2 = ref.watch(remember_me);
    //var size = MediaQuery.of(context).size;
    //final String lang = ref.watch(languageProvider);
    List<Ticket> testTicketList = [
      Ticket(
        name: "Ticket1",
        personName: "Problem d'exeuction",
        companyId: "Global Performance Business",
        doneStageBoolean: true,
        reopenStageBoolean: false,
        cancelStageBoolean: false,
        closedStageBoolean: false,
        active: true,
        emailSubject: "a.karjout@globalperformance.ma",
        isFastTrack: false,
        progress: 1,
      ), Ticket(
        name: "Ticket2",
        personName: "Anomalie de virement instantane journal",
        companyId: "Global Performance Business",
        doneStageBoolean: false,
        reopenStageBoolean: false,
        cancelStageBoolean: true,
        closedStageBoolean: false,
        active: true,
        emailSubject: "a.karjout@gmail.ma",
        isFastTrack: false,
        progress: 0.45,
      ),
      Ticket(
        name: "Ticket3",
        personName: "John Doe",
        companyId: "123",
        doneStageBoolean: false,
        reopenStageBoolean: false,
        cancelStageBoolean: false,
        closedStageBoolean: false,
        active: true,
        emailSubject: "adm.mdd@gmail.com",
        isFastTrack: false,
        progress: 0.15,
      ),
    ]
    ;


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
          });

        */},
        mini: true,
        child: const Icon(Icons.add, color: Colors.white, size: 25),
      ),
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