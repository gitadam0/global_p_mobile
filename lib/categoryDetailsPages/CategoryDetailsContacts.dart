


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_p/mainLogin.dart';
import 'package:global_p/widgets/ContactBottomSheet.dart';
import 'package:global_p/widgets/CustomBottomNavigationBar.dart';
import 'package:global_p/widgets/language_dropdown.dart';
import 'package:go_router/go_router.dart';
import 'package:odoo_rpc/odoo_rpc.dart';



import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../my_colors.dart';

final orpc = OdooClient('http://83.171.249.157:8069');

class CategoryDetailsContacts extends ConsumerStatefulWidget {
  const CategoryDetailsContacts({super.key});

  @override
  ConsumerState createState() => _CategoryDetailsContactsState();
}

class _CategoryDetailsContactsState extends ConsumerState<CategoryDetailsContacts> {

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Text("gggggggg"),
            FutureBuilder(
                future: fetchContacts(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            final record = snapshot.data[index] as Map<String, dynamic>;
                            return buildPartnerListItem(record);
                          }),
                    );
                  } else {
                    if (snapshot.hasError) return Text('Unable to fetch data'+snapshot.error.toString());
                    return CircularProgressIndicator();
                  }
                })
            ],
          )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        onPressed: (){
          /*createPartner();
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
  //create contact
  //
  //
  Future<void> _showMyDialog() async {
    TextEditingController nameController = TextEditingController();

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

                    Icon(Icons.contact_mail,size:60,color: mcgpalette0,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text('Create Contact'),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    //initialValue: 'Input text',
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle:TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.person,
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
                        if(nameController.text.trim().isEmpty){
                          print("this shouldnt be emptyy");
                        }else{
                          createPartner(nameController.text);
                          setState(() {
                            fetchContacts();
                          });
                          Navigator.of(context).pop();
                        }

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
          /*actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },

            ),
            Padding(
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
            )
          ],*/
        );
      },
    );
  }




}


Future<int> createPartner(String name) async {

  //await orpc.authenticate('odoo15_2023_adam', 'odoo15_2023_adam', '123');

  var result = await orpc.callKw({
    'model': 'res.partner',
    'method': 'create',
    'args': [
      {'name': name,'email':'ADAMMOUADDINETEST@GMAIL'},
    ],
    'kwargs': {}, // Add an empty kwargs map
  });

  return result as int;
}

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
      'limit': 2000,
    },
  });
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


