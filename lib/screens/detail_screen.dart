import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:ktracapplication/Theme/pallet.dart';
//
// class DetailScreen extends StatefulWidget {
//   @override
//   _ChecklistScreenState createState() => _ChecklistScreenState();
// }
//
// class _ChecklistScreenState extends State<DetailScreen> {
//   final List<String> checklistItems = [
//     'Engine light',
//     'Fuel',
//     'Tissue',
//     'Water',
//     'Sanitizer',
//     'Charging Accessories',
//     'Interior clean',
//     'Exterior clean',
//     'Tire warning',
//     'Other warning lights',
//   ];
//
//   final Map<String, bool> checklistStatus = {};
//
//   @override
//   void initState() {
//     super.initState();
//     for (var item in checklistItems) {
//       checklistStatus[item] = false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//        // title: Text('Condition Checklist'),
//         backgroundColor: Pallet.primary,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ...checklistItems.map((item) {
//               return Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: CheckboxListTile(
//                  // minTileHeight: 20,
//                  // checkColor: Pallet.primary,
//                   activeColor: Pallet.primary,
//                   tileColor: Pallet.greenlight.withOpacity(0.3),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   title: Text(item,style: TextStyle(fontWeight: FontWeight.bold,color: Pallet.primary),),
//                   value: checklistStatus[item],
//                   onChanged: (value) {
//                     setState(() {
//                       checklistStatus[item] = value!;
//                     });
//                   },
//                 ),
//               );
//             }).toList(),
//             Divider(),
//             // Text(
//             //   'Do you want to report any new scratches?',
//             //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             // ),
//             // ListTile(
//             //   leading: Radio(
//             //     value: true,
//             //     groupValue: null,
//             //     onChanged: (value) {
//             //       setState(() {
//             //         // Handle Yes selection
//             //       });
//             //     },
//             //   ),
//             //   title: Text('Yes'),
//             // ),
//             // ListTile(
//             //   leading: Radio(
//             //     value: false,
//             //     groupValue: null,
//             //     onChanged: (value) {
//             //       setState(() {
//             //         // Handle No selection
//             //       });
//             //     },
//             //   ),
//             //   title: Text('No'),
//             // ),
//             SizedBox(height: 20),
//             // Image.network(
//             //   'https://via.placeholder.com/150', // Replace with actual image URL
//             //   height: 150,
//             // ),
//             Container(
//               height: 200,
//               width: 350,
//               child: Image.asset("assets/images/faris-mohammed-vNeB9rkPLQ4-unsplash.jpg",
//               fit: BoxFit.cover,),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 // Take Handover logic
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Pallet.primary,
//               ),
//               child: Text('TAKE HANDOVER',
//               style: TextStyle(color: Colors.white),),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // void main() {
// //   runApp(MaterialApp(home: DetailScreen()));
// // }