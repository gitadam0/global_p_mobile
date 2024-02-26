/*
// PartnerListPage.dart
import 'package:flutter/material.dart';

class PartnerListPage extends StatelessWidget {
  final Map<String, dynamic> partnerData; // Replace with your actual data

  //PartnerListPage({required this.partnerData,required String baseurl });
  PartnerListPage( this.partnerData, String baseurl );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Partner List'),
      ),
      body: ListView.builder(
        itemCount: partnerData.length,
        itemBuilder: (context, index) {
          final record = partnerData[index];
          print(record.toString());
          print(record.toString());
          print(record.toString());
          print(record.toString());
          return buildPartnerListItem(record,"");
        },
      ),
    );
  }

  Widget buildPartnerListItem(Map<String, dynamic> record,String baseurl) {
    //var unique = record['__last_update'] as String;
    //unique = unique.replaceAll(RegExp(r'[^0-9]'), '');
    //final avatarUrl =
     //   '${baseurl}/web/image?model=res.partner&field=image_128&id=${record["id"]}&unique=$unique';
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Container(
          width: 70, // Set the width as needed for your square image
          height: 70, // Set the height as needed for your square image
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,

          ),
        ),
        title: Text('${record['name']}'),
      ),
    );
  }
}
*/
