
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoarding extends StatefulWidget {
  const onBoarding({Key? key}) : super(key: key);

  @override
  State<onBoarding> createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {

  var page_controller=PageController();
  var page_num=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          centerTitle: true,
          title: Image.asset("images/gp.png",height: 40,),
        iconTheme: IconThemeData(color: Colors.black),

      ),

      body: Container(
        margin: EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: page_controller,
          children: [
            Container(child: Center(child: Text("ddssf")),decoration: BoxDecoration(color: Colors.blue),),
            Container(child: Center(child: Text("ddssf")),decoration: BoxDecoration(color: Colors.orange),),
            Container(child: Center(child: Text("ddssf")),decoration: BoxDecoration(color: Colors.greenAccent),),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              TextButton(
                onPressed: (){
                  if(page_num>1){
                    context.pop();
                  }
                  page_num=2;
                  page_controller.jumpToPage(2);
                },
                child: Text("Skip"),
                style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
              ),
             SmoothPageIndicator(

                  controller: page_controller, count: 3,
                    //effect:  ColorTransitionEffect(),
                 effect: ColorTransitionEffect(
                   dotWidth:  15.0,
                   dotHeight: 15,
                   spacing: 5
                 ), // your preferred effect
                  onDotClicked: (index){
                      print(index);
                  }
              ),

            TextButton(
              onPressed: (){
                if(page_num>1){
                  context.pop();
                }
                page_controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                page_num++;

              },
              child: Text("Next"),
              style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
