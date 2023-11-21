// import 'package:flutter/material.dart';


// Widget buildTecnologieConosciute(
//   List<String> tecnologieConosciute,
//   TextEditingController nuovaTecnologiaController,
//   Function(void Function()) setStateCallback,
// ) {
//   return Wrap(
//     crossAxisAlignment: WrapCrossAlignment.center,
//     children: [
//       const Text('Tecnologie Conosciute: '),
//       for (String tecnologia in tecnologieConosciute)
//         Chip(
//           label: Text(tecnologia),
//           onDeleted: () {
//             setStateCallback(() {
//               tecnologieConosciute.remove(tecnologia);
//             });
//           },
//         ),
//       TextFormField(
//         controller: nuovaTecnologiaController,
//         decoration: const InputDecoration(
//           labelText: 'Nuova Tecnologia',
//         ),
//         onEditingComplete: () {
//           final nuovaTecnologia = nuovaTecnologiaController.text.trim();
//           if (nuovaTecnologia.isNotEmpty) {
//             setStateCallback(() {
//               tecnologieConosciute.add(nuovaTecnologia);
//               nuovaTecnologiaController.clear();
//             });
//           }
//         },
//       ),
//     ],
//   );
// }