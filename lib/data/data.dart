import 'package:flutter/material.dart';

import '../models/Ticket.dart';
import '../models/category.dart';
import '../models/expansion_error.dart';

const Categorys= [
   Category( id: '',name:"Centre De Relation Client",img: "images/menu_imgs/service.png"),
   //Category( id: '',name:"RECRUTMENT",img: "images/menu_imgs/crm.png"),
   //Category( id: '',name:"Tableaux de bord",img: "images/menu_imgs/bord.png"),
   //Category( id: '',name:"Configuration",img: "images/menu_imgs/configuration.png"),
   //Category( id: '',name:"Configuration",img: "images/menu_imgs/Application.png"),
   Category( id: '',name:"Contacts",),
   Category( id: '',name:"CRM",img: "images/menu_imgs/img2.png"),
  // Category( id: '',name:"CRM",img: "images/menu_imgs/contacts.png"),


];

var help_list=[
   ExpantionError(header: "Can't find phone number?",text:"here is our phone number : 06014681674",isexpanded: false),
   ExpantionError(header: "Map isn't working?",text:"you should go to setting go to our app and activate location services and after that if it doesn't work you should try to reinstall the app if it doesnt work please contatct our support",isexpanded: false),
   ExpantionError(header: "title",text:"Details goes here goe dskh skjn about you expaired Details goes here goe dskh skjn about you expaired Details goes here goe dskh skjn about you expaired",isexpanded: false),
];


const List<String> lang_list = <String>['en','fr',"es"];

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
      progress: 1,
   ), Ticket(
      name: "Ticket2",
      personName: "Anomalie de virement instantane journal",
      companyId: "Global Performance Business",
      doneStageBoolean: false,
      reopenStageBoolean: false,
      cancelStageBoolean: true,
      closedStageBoolean: false,
      active: true,
      emailSubject: "a.karjout@gmail.ma",
      isFastTrack: false,
      progress: 0.45,
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
      progress: 0.15,
   ),
   Ticket(
      name: "Ticket3",
      personName: "John Doe",
      companyId: "123",
      doneStageBoolean: false,
      reopenStageBoolean: true,
      cancelStageBoolean: false,
      closedStageBoolean: true,
      active: true,
      emailSubject: "adm.mdd@gmail.com",
      isFastTrack: false,
      progress: 0.15,
   ),
]
;