import 'package:flutter/material.dart';
import 'package:rich_alert/rich_alert.dart';

bool isNumeric(String s) {
  if (s.isEmpty) return false;

  final n = num.tryParse(s);
  return (n == null) ? false : true;
}

void mostrarAlerta(BuildContext context, String mensaje) {

  showDialog(
    context: context,
    builder: (context) {
      return RichAlertDialog(
        alertTitle: richTitle("¡Denegado!"),
        alertSubtitle: richSubtitle(mensaje),
        alertType: RichAlertType.WARNING,
        actions: <Widget>[
          TextButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
            child: Text(
              "OK", 
              style: TextStyle(
                color: Colors.white
              )
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}
