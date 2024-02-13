
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_p/widgets/CategoryItem.dart';
import 'package:global_p/widgets/ContactBottomSheet.dart';
import 'package:global_p/widgets/CustomBottomNavigationBar.dart';
import 'package:global_p/widgets/categoryDetails/RelationClientTicketListPage.dart';
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
class CategoryDetails extends ConsumerStatefulWidget {
  var id1;
  var id2;

   CategoryDetails({Key? key,this.id1, this.id2}) : super(key: key);


  @override
  _CategoryDetails createState() => _CategoryDetails();
}

class _CategoryDetails extends ConsumerState<CategoryDetails> {

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
        progress: 0.75,
      ), Ticket(
        name: "Ticket2",
        personName: "Anomalie de virement instantane journal",
        companyId: "Global Performance Business",
        doneStageBoolean: true,
        reopenStageBoolean: false,
        cancelStageBoolean: true,
        closedStageBoolean: false,
        active: true,
        emailSubject: "a.karjout@gmail.ma",
        isFastTrack: false,
        progress: 0.75,
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
        progress: 0.75,
      ),
    ]
    ;

    var id1Value = widget.id1;
    var id2Value = widget.id2;
    Future<dynamic> fetchContacts() async {
      //await orpc.authenticate('odoo15_2023_adam', 'odoo15_2023_adam', '123');
      await orpc.authenticate('odoo_crc', 'adm.mdd@gmail.com', '12345678');
      return orpc.callKw({
        'model': 'res.partner',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {'bin_size': true},
          'domain': [],
          'fields': ['id', 'name', 'email', '__last_update', 'image_128','active'],
          'limit': 80,
        },
      });
    }
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

    Future<int> createPartner() async {

      //await orpc.authenticate('odoo15_2023_adam', 'odoo15_2023_adam', '123');

      var result = await orpc.callKw({
        'model': 'res.partner',
        'method': 'create',
        'args': [
            {'name': 'A1','email':'ADAMMOUADDINETEST@GMAIL'},
        ],
        'kwargs': {}, // Add an empty kwargs map
      });

      return result as int;
    }




    Widget buildCategoryWidget(String categoryName) {


      if (categoryName == "Centre De Relation Client") {
        //from database
        //from database
        //from database
        return FutureBuilder(
            future: fetchCentreDeRelationClient(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final record =
                      snapshot.data[index] as Map<String, dynamic>;
                      return RelationClientTicketListItem(record);
                    });
              } else {
                if (snapshot.hasError) return Text('Unable to fetch data'+snapshot.error.toString());
                return CircularProgressIndicator();
              }
            });
        //from offline
        //from offline
        //from offline
        //return RelationClientTicketListItemtestinglocaldata(testTicketList );

        // for testing purposes
        // for testing purposes
        // for testing purposes
        /*return  FutureBuilder(
           future: fetchCentreDeRelationClient(),
           builder: (context, snapshot) {
             if (snapshot.connectionState == ConnectionState.waiting) {
               return CircularProgressIndicator();
             } else if (snapshot.hasError) {
               return Text('Error: ${snapshot.error}');
             } else {
               // Use the data from the snapshot
               var data = snapshot.data;
               log(data.toString());

               return Text('Centre De Relation Client: $data');
             }
           },
         );*/
      } else if (categoryName == "Contacts") {
        return FutureBuilder(
            future: fetchContacts(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final record = snapshot.data[index] as Map<String, dynamic>;
                      return buildPartnerListItem(record);
                    });
              } else {
                if (snapshot.hasError) return Text('Unable to fetch data'+snapshot.error.toString());
                return CircularProgressIndicator();
              }
            });
      } else if (categoryName == "CRM") {
        return Container(
          child: Text('Widget for CRM'),
        );
      }


      // Default case, you can return a generic widget or null
      return Container(
        child: Text('no page found'),
      );
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
        child:
        id2Value!=null?
        //
        //show's page for each category
        //
        buildCategoryWidget(id2Value)
        :Text(id2Value),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        onPressed: (){
          createPartner();
          setState(() {
            fetchContacts();
          });

        },
        mini: true,
        child: const Icon(Icons.add, color: Colors.white, size: 25),
      ),




    );

  }
}



Widget buildPartnerListItem(Map<String, dynamic> record) {
  var unique = record['__last_update'] as String;
  unique = unique.replaceAll(RegExp(r'[^0-9]'), '');
  final avatarUrl = '${orpc.baseURL}/web/image?model=res.partner&field=image_128&id=${record["id"]}&unique=$unique';
  return Card(
    elevation: 3,
    margin: EdgeInsets.all(10),
    child: ListTile(
      leading: Container(
        width: 70, // Set the width as needed for your square image
        height: 70, // Set the height as needed for your square image
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                avatarUrl
              // 'http://192.168.1.44:8069/web/image?model=res.partner&field=image_128&id=27&unique=2023-12-25%2022:24:06',
            ),
          ),
        ),
      ),
      title: Text('${record['name']}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Email:${record['email'] is String ? record['email'] : ''}'),
          //Text('ID: ${record['id']}'),
          Text('Last Update: ${record['__last_update']}'),
          Text('active: ${record['active']}'),
          //Text('Base URL: ${orpc.baseURL}'),
        ],
      ),
    ),
  );
}

Widget RelationClientTicketListItem(Map<String, dynamic> record) {

  return Card(
    elevation: 3,
    margin: EdgeInsets.all(10),
    child: ListTile(

      title: Text('${record['name']}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Company Name:${record["company_id"][1]} ' ),
          //Text('ID: ${record['id']}'),
          Text('person_name: ${record['person_name']}'),
          Text('active: ${record['active']}'),
          record['done_stage_boolean'] ? Text('done_stage_boolean: ${record['done_stage_boolean']}') : Container(),
          record['reopen_stage_boolean'] ? Text('reopen_stage_boolean: ${record['reopen_stage_boolean']}') : Container(),
          record['closed_stage_boolean'] ? Text('closed_stage_boolean: ${record['closed_stage_boolean']}') : Container(),
          record['cancel_stage_boolean'] ? Text('cancel_stage_boolean: ${record['cancel_stage_boolean']}') : Container(),
          Text('done_stage_boolean: ${record['done_stage_boolean']}'),
          Text('reopen_stage_boolean: ${record['reopen_stage_boolean']}'),
          Text('closed_stage_boolean: ${record['closed_stage_boolean']}'),
          Text('cancel_stage_boolean: ${record['cancel_stage_boolean']}'),
          Text('email_subject: ${record['email_subject']}'),
          Text('is_fast_track: ${record['is_fast_track']}'),
          Text('progress: ${record['progress']}'),
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
              if (record.doneStageBoolean) RoundedStatusWidget("done stage",Colors.green),
              if (record.reopenStageBoolean) RoundedStatusWidget("reopen stage",Colors.yellow),
              if (record.closedStageBoolean) RoundedStatusWidget("closed stage",Colors.redAccent),
              if (record.cancelStageBoolean) RoundedStatusWidget("cancel stage",Colors.red),
              if (!record.doneStageBoolean && !record.reopenStageBoolean && !record.closedStageBoolean && !record.cancelStageBoolean)
                RoundedStatusWidget("new stage",Color.fromRGBO(
                    19, 103, 20, 1.0)),
              Text('is_fast_track: ${record.isFastTrack}'),
              Text('progress: ${record.progress}'),
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