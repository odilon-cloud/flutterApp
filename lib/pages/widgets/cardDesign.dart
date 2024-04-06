// import 'package:flutter/material.dart';
//
// class CustomCard extends StatelessWidget {
//   final String text;
//   final Color color;
//   final double progress;
//
//   const CustomCard({Key? key, required this.text, required this.color, required this.progress}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: color,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       child: Material(
//         elevation: 5.0,
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           child: ListTile(
//             leading: const Icon(Icons.person_2_sharp, size: 50),
//             title: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   text,
//                   style: const TextStyle(fontSize: 20, color: Colors.white),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 8.0),
//                 LinearProgressIndicator(
//                   value: progress,
//                   backgroundColor: Colors.white,
//                   valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }