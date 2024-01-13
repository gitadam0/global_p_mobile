


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../all_providers.dart';
import '../data/data.dart';

class LangDropdownButton extends ConsumerStatefulWidget {
  //const DropdownButtonExample({super.key});


  @override
  _LangDropdownButtonState createState() => _LangDropdownButtonState();
}


class _LangDropdownButtonState extends ConsumerState<LangDropdownButton> {


  String dropdownValue = lang_list.first;

  @override
  Widget build(BuildContext context) {
    var dropdownValue1=ref.watch(languageProvider);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: DropdownButton<String>(
        value: dropdownValue1,

        //elevation: 16,
        style:
        const TextStyle(color: Colors.black),

        onChanged: (String? value) {
          // This is called when the user selects an item.
          print("dropdownValue.toString()");
          setState(() {
            dropdownValue = value!;
            ref.read(languageProvider.notifier).state=dropdownValue;
          });
        },
        items: lang_list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
