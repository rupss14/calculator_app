import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:math_expressions/math_expressions.dart';


void main(){
  runApp ( MaterialApp (
    debugShowCheckedModeBanner: false,
    home: calculator_app(),
  )
  );
}

class calculator_app extends StatefulWidget {
  const calculator_app ({super.key});

  @override
  State<calculator_app> createState() => _calculator_appState();
}

class _calculator_appState extends State<calculator_app > {
  //variables
//////////////***************************8
  var input='';
  var output='';
  var operation='';
  var hideInput=false;
  var outputSize=35.0;


  onButtonClick(value){  ////////////*******************
    //if user clicks AC
    if(value == "AC"){
      input='';
      output='';
    }
    // user clicks <
    else if(value=="<"){
      if(input.isNotEmpty){        //for buttons to function if zero input is given
      input=input.substring(0,input.length-1);}
    }
    //user clicks =
    else if(value == "="){
      if(input.isNotEmpty){      //for buttons to function if zero input is given
      var userInput=input;
      userInput= input.replaceAll("x","*");
      //create expression via parser
      Parser p =Parser();//i guess converter. converter to integer or string
      Expression expression=p.parse(userInput); //whatever the user will type is converted
      ContextModel cm= ContextModel();//bind the variables...tracks all known expression and variables.
      // evaluate expression
      var finalValue=expression.evaluate(EvaluationType.REAL, cm); //it is double
      output=finalValue.toString();//final variable is double so converted to string
      if(output.endsWith(".0")){
        output=output.substring(0,output.length-2);
      }
      input=output;  //so that expression will be erased.
      hideInput=true;
      outputSize=40.0;
      }
    }
    else{
      input=input+value;
      hideInput=false;
      outputSize=35.0;
    }

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:Colors.black ,
      body:Column(
        children:<Widget> [
          //input output area
          Expanded(
            child:Container(
              color: Colors.black,
              padding: EdgeInsets.all(12),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end, //for horizontal shift
                mainAxisAlignment: MainAxisAlignment.end, //for vertical shift
                children: <Widget>[
                  Text(
                    hideInput?'': input,   /////////////////***************
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Text(output, //////////*************
                    style: TextStyle(
                      fontSize: outputSize,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),

          //button area

          Row(
            children: <Widget>[
              button(text:"AC",
                tbgColor:Color(0xffcccccc),
                tColor: Colors.black.withOpacity(0.7),),
              button(text:"<",
                tbgColor:Color(0xffcccccc),
                tColor: Colors.black.withOpacity(0.7),),
              button(text:"",
                tbgColor:Colors.transparent,),
              button(text:"/",
                tbgColor: operatorColor,),
            ],
          ),
          Row(
            children: <Widget>[
              button(text:"7"),
              button(text:"8"),
              button(text:"9"),
              button(text:"x",
                tbgColor: operatorColor,),
            ],
          ),
          Row(
            children: <Widget>[
              button(text:"4"),
              button(text:"5"),
              button(text:"6"),
              button(text:"-",
                tbgColor: operatorColor,),
            ],
          ),
          Row(
            children: <Widget>[
              button(text:"1"),
              button(text:"2"),
              button(text:"3"),
              button(text:"+",
                tbgColor: operatorColor,),
            ],
          ),
          Row(
            children: <Widget>[
              button(text:"%",
                tbgColor:Color(0xffcccccc),
                tColor: Colors.black.withOpacity(0.7),),
              button(text:"0"),
              button(text:".",),
              button(text:"=",
                tbgColor: Colors.orange,),
            ],
          ),
        ],
      ),
    );
  }

Widget button({text,tColor=Colors.white,tbgColor=buttonColor}){
  return Expanded(
    child:Container(
      margin: EdgeInsets.all(8.0),
      child: ElevatedButton(
        style:ElevatedButton.styleFrom(
          shape:
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000.0),
          ),
          primary: tbgColor,
          padding:EdgeInsets.all(22.0),
        ),
        onPressed: () => onButtonClick(text), ///////********************************
        child: Text(text,
          style: TextStyle(
            fontSize:20,
            fontWeight: FontWeight.bold,
            color: tColor,
          ),),
      ),
    ),
  );
}
}

