// import 'package:flutter/material.dart';
// import 'package:solving_recruitment_flutter/common.dart';
// import 'package:solving_recruitment_flutter/models/candidato.dart';

// class CandidatoUpdateScreen extends StatefulWidget {
//   const CandidatoUpdateScreen({super.key, required this.candidato});

//   final Candidato candidato;

//   @override
//   State<CandidatoUpdateScreen> createState() => _CandidatoUpdateScreenState();
// }

// class _CandidatoUpdateScreenState extends State<CandidatoUpdateScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController nomeController;
//   late TextEditingController cognomeController;
//   late TextEditingController emailController = TextEditingController();
//    late TextEditingController luogoDiNascitaController =
//       TextEditingController();
//   late TextEditingController dataDiNascitaController = TextEditingController();
//   late TextEditingController residenzaController = TextEditingController();
//   late TextEditingController recapitoTelefonicoController =
//       TextEditingController();
//   late TextEditingController recapitoExtra = TextEditingController();
//   late TextEditingController cap = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     // Inizializza i controller con i valori del candidato
//     nomeController = TextEditingController(text: widget.candidato.nome ?? '');
//     cognomeController =
//         TextEditingController(text: widget.candidato.cognome ?? '');
//     emailController = TextEditingController(text: widget.candidato.email ?? '');
//     luogoDiNascitaController =
//         TextEditingController(text: widget.candidato.luogoDiNascita ?? '');
//     dataDiNascitaController =
//         TextEditingController(text: widget.candidato.dataDiNascita ?? '');
//     residenzaController =
//         TextEditingController(text: widget.candidato.residenza ?? '');
//     recapitoTelefonicoController =
//         TextEditingController(text: widget.candidato.recapitoTelefonico ?? '');
//     recapitoExtra = TextEditingController(text: widget.candidato.recapitoExtra ?? '');
//     cap = TextEditingController(text: widget.candidato.cap ?? '');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Modifica Candidato',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Theme.of(context).primaryColor,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               customTextFormFieldWithValidator(nomeController, 'Nome'),
//               customTextFormFieldWithValidator(cognomeController, 'Cognome'),
//              TextFormField(
//                     controller: emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: const InputDecoration(
//                       labelText: 'Email',
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Inserisci una email valida';
//                       }
//                       if (!value.contains('@')) {
//                         return 'Inserisci una email valida';
//                       }
//                       return null;
//                     }),
//               ElevatedButton(
//                 onPressed: () async {
//                   // // Esegui l'aggiornamento con i valori dei controller
//                   // final candidato = Candidato(
//                   //   nome: nomeController.text,
//                   //   cognome: cognomeController.text,
//                   // );
        
//                   // final candidatoProvider =
//                   //     Provider.of<CandidatoProvider>(context, listen: false);
//                   // bool result =
//                   //     await candidatoProvider.updateCandidato(candidato);
        
//                   // if (result) {
//                   //   // Aggiornamento riuscito
//                   //   Navigator.pop(context);
//                   // } else {
//                   //   print('Errore durante l\'aggiornamento');
//                   // }
//                 },
//                 child: const Text('Modifica'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
