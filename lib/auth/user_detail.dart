// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class UserDetails extends StatelessWidget {
//   late final String documentId;

//   UserDetails({required this.documentId});

//   @override
//   Widget build(BuildContext context) {
//     final CollectionReference users =
//         FirebaseFirestore.instance.collection('users');
//     return FutureBuilder(
//       future: users.doc(documentId).get(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
        
//           return Text('Halo ${data['Nama Depan']}');
//         }
//         return CircularProgressIndicator();
//       },
//     );
//   }
// }
