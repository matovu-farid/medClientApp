import 'package:flutter/material.dart';
class SubmitButton extends StatelessWidget{
  final VoidCallback onPressed;
  AlignmentGeometry alignment;

  SubmitButton({@required this.onPressed,this.alignment = Alignment.centerRight});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: FlatButton(
        color: Colors.amber,
        onPressed: onPressed,
        child: Text('Submit',style: TextStyle(color: Colors.white),),
      ),
    );
  }

}