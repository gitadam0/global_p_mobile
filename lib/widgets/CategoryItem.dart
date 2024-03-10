import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'CategoryDetailPage.dart';

class CategoryItem extends StatelessWidget {
  final String img;
  final String name;

  const CategoryItem({required this.img, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //context.pushNamed('categoryDetails',pathParameters: {'id1': name, 'id2': name} );
        if (name == "Centre De Relation Client") {
          print("Centre De Relation Client");
          context.push('/CategoryDetailsCRC' );
          //context.push('/CategoryDetailsCRCNew' );
        }
        else if (name == "Contacts") {
          context.push('/CategoryDetailsContacts' );
        }
        else if (name == "CRM") {
          print("CRM");
        }

      },
      child: Container(
        margin: EdgeInsets.only(bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 90,
              child: ClipRRect(
                child: Image.asset(
                  img,
                  fit: BoxFit.fitHeight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(name,textAlign: TextAlign.center,softWrap: true,),
            ),
          ],
        ),
      ),
    );
  }
}
