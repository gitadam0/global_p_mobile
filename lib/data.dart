import 'package:flutter/material.dart';

import 'models/category.dart';
import 'models/expansion_error.dart';

const Categorys= [
   Category( id: '',name:"Espace de Service",img: "images/menu_imgs/service.png"),
   Category( id: '',name:"RECRUTMENT",img: "images/menu_imgs/crm.png"),
   Category( id: '',name:"Tableaux de bord",img: "images/menu_imgs/bord.png"),
   Category( id: '',name:"Configuration",img: "images/menu_imgs/configuration.png"),
   Category( id: '',name:"Configuration",img: "images/menu_imgs/Application.png"),
   Category( id: '',name:"Contacts"),
   Category( id: '',name:"CRM",img: "images/menu_imgs/img2.png"),
   Category( id: '',name:"CRM",img: "images/menu_imgs/contacts.png"),


];

var help_list=[
   ExpantionError(header: "Can't find phone number?",text:"here is our phone number : 06014681674",isexpanded: false),
   ExpantionError(header: "Map isn't working?",text:"you should try to reinstall the app if it doesnt work please contatct our support",isexpanded: false),
   ExpantionError(header: "title",text:"Details goes here goe dskh skjn about you expaired Details goes here goe dskh skjn about you expaired Details goes here goe dskh skjn about you expaired",isexpanded: false),
];
