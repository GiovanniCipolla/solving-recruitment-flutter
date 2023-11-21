import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/screens/home.dart';

Future<bool> showExitDialog(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Vuoi uscire ?'),
          content:
              const Text('Sei sicuro di voler chiusere dall\' applicazione ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Sì'),
            ),
          ],
        ),
      ) ??
      false;
}

Future<bool> showAlertDialog(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('OPS.. :-( '),
          content: const Text('Questa funzionalità sarà presto disponibile'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Ok'),
            ),
          ],
        ),
      ) ??
      false;
}

Future<bool> backHome(context) async {
  await Navigator.pushNamedAndRemoveUntil(
      context, Home.routeName, (route) => false);
  return true;
}

TextFormField customTextFormFieldWithoutValidator(controller, label) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
    ),
  );
}

TextFormField customTextFormFieldWithValidator(controller, label) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
    ),
    validator: (value) {
      if (value == null || value.trim().isEmpty) {
        return 'Il campo $label non può essere vuoto.';
      }
      return null;
    },
  );
}

TextFormField customTextFormFieldWithEmail(controller, label) {
  return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: label,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Inserisci una email valida';
        }
        if (!value.contains('@')) {
          return 'Inserisci una email valida';
        }
        return null;
      });
}

