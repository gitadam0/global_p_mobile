import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedTabIndex;
  final Function(int) onTabTapped;
  var localizations;

  CustomBottomNavigationBar({
    required this.selectedTabIndex,
    required this.onTabTapped,
    this.localizations,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedTabIndex == -1 ? 0 : selectedTabIndex,
      selectedItemColor:
      selectedTabIndex == -1 ? Colors.grey[600] : Color(0xff798DB1),
      unselectedItemColor: Colors.grey[600],
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          label: localizations.demo.toString() ?? "Demo",
          icon: Icon(Icons.phone_android_outlined),
        ),
        BottomNavigationBarItem(
          label: localizations.contact.toString() ?? "Contact",
          icon: Icon(Icons.call),
        ),
        BottomNavigationBarItem(
          label: localizations?.location.toString() ?? "Location",
          icon: Icon(Icons.location_on),
        ),
        BottomNavigationBarItem(
          label: "FAQs" //localizations?.location.toString()
          ,
          icon: Icon(Icons.contact_support),
        ),
        BottomNavigationBarItem(
          label: "More",
          icon: Icon(Icons.add_circle),
        ),
      ],
    );
  }
}
