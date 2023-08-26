import 'package:flutter/material.dart';
import 'package:mobil_projesi/color_utils.dart';
import 'package:mobil_projesi/Comm/comHelper.dart';
class getTextFormField extends StatelessWidget{
  TextEditingController controller;
  String hintName;
  IconData icon;
  bool isObscureText;
  TextInputType inputType;

  getTextFormField(
      { required this.controller, required this.hintName, required this.icon,this.isObscureText=false,this.inputType=TextInputType.text});
  @override
  Widget build(BuildContext context){
    return Container(
        padding : EdgeInsets.symmetric(horizontal:20.0),
        margin : EdgeInsets.only(top:10.0),
        child : TextFormField(
          controller : controller,
          obscureText: isObscureText,
          keyboardType: inputType,
          validator : (value){
            if(value == null || value.isEmpty){
              return 'Lütfen $hintName Giriniz';
            }
            if(hintName=="E-Posta"&&!validateEmail(value)){
              return 'Lütfen geçerli bir e-posta girin.';
            }
            return null;

          },

          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color : Colors.transparent),),
            focusedBorder : OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color : Colors.blue),
            ),
            prefixIcon : Icon(Icons.person),
            hintText: hintName,
            labelText: hintName,
            fillColor :  hexStringToColor("#D8DCE4"),
            filled:true,
          ),


        )
    );
  }
}