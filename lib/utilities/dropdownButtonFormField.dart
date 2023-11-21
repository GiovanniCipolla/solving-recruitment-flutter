import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';

DropdownButtonFormField showLinguaInglese(
  LinguaInglese linguaIngleseSelezionata,
  Function(LinguaInglese?) onValueChanged,
) {
  return DropdownButtonFormField<LinguaInglese>(
    value: linguaIngleseSelezionata,
    items: [
      const DropdownMenuItem(
        value: null,
        child: Text('-'),
      ),
      ...LinguaInglese.values.map((LinguaInglese value) {
        return DropdownMenuItem(
          value: value,
          child: Text(linguaIngleseMap[value] ?? ''),
        );
      }).toList(),
    ],
    onChanged: (LinguaInglese? value) {
      onValueChanged(value);
    },
    decoration: const InputDecoration(
      labelText: 'Lingua Inglese',
    ),
  );
}


 
