
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'data/data.dart';
import 'models/expansion_error.dart';

final help_list_provider = StateProvider.autoDispose((ref) {
  return help_list;
});

class Help extends ConsumerStatefulWidget {
  //const Help({Key? key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends ConsumerState<Help> {

  var page_controller=PageController();

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    var helplist_watch=ref.watch(help_list_provider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        centerTitle: true,
        title: Image.asset("images/gp.png",height: 40,),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
      child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpansionPanelList(
            //animationDuration: Duration(milliseconds: 300),

            expansionCallback: (int index, bool isExpanded) {
              ref.read(help_list_provider.notifier).state[index].isexpanded =
              !ref.read(help_list_provider.notifier).state[index].isexpanded;
              //
              //the code above for some reason doesnt update the state so i have update it below
              //
              ref.read(help_list_provider.notifier).update((state) => [...state]) ;
            },
            children: ref.watch(help_list_provider).map<ExpansionPanel>((ExpantionError e) {
              return ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text( e.header),
                  );
                },
                body:  Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: Text(e.text),
                ),

                isExpanded: e.isexpanded,
              );
            }).toList(),

          )


        ],
      ),
      ),
    ),

    );
  }
}
