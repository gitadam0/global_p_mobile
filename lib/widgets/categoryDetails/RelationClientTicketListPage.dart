// PartnerListPage.dart
import 'package:flutter/material.dart';

class RelationClientTicketListPage extends StatelessWidget {
  final Map<String, dynamic> partnerData;
   //String baseurl;

  //PartnerListPage({required this.partnerData,required String baseurl });
  RelationClientTicketListPage( this.partnerData );

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
          return buildPartnerListItem(record,"");
        },
      ),
    );
  }

  Widget buildPartnerListItem(Map<String, dynamic> record,String baseurl) {
    var unique = record['__last_update'] as String;
    unique = unique.replaceAll(RegExp(r'[^0-9]'), '');
    final avatarUrl =
        '${baseurl}/web/image?model=res.partner&field=image_128&id=${record["id"]}&unique=$unique';
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
}
