import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String img;
  final String name;

  const CategoryItem({required this.img, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: ClipRRect(
              child: Image.asset(
                img,
                fit: BoxFit.fitHeight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            height: 90,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(name, softWrap: false),
          ),
        ],
      ),
    );
  }
}
