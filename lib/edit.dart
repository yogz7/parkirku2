// import 'package:flutter/material.dart';
// import 'package:parkirku/parkir.dart';

// class EditCarScreen extends StatefulWidget {
//   final Car car;

//   const EditCarScreen({Key? key, required this.car}) : super(key: key);

//   @override
//   _EditCarScreenState createState() => _EditCarScreenState();
// }

// class _EditCarScreenState extends State<EditCarScreen> {
//   late TextEditingController _nameController;
//   late TextEditingController _noPlatController;
//   late TextEditingController _hariController;
//   bool _isButtonEnabled = false;

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.car.name);
//     _noPlatController = TextEditingController(text: widget.car.no_plat);
//     _hariController = TextEditingController(text: widget.car.jenis);

//     _nameController.addListener(_validateFields);
//     _noPlatController.addListener(_validateFields);
//     _hariController.addListener(_validateFields);
//   }

//   void _validateFields() {
//     setState(() {
//       _isButtonEnabled = _nameController.text.isNotEmpty &&
//           _noPlatController.text.isNotEmpty &&
//           _hariController.text.isNotEmpty;
//     });
//   }

//   @override
//   void dispose() {
//     _nameController.removeListener(_validateFields);
//     _noPlatController.removeListener(_validateFields);
//     _hariController.removeListener(_validateFields);

//     _nameController.dispose();
//     _noPlatController.dispose();
//     _hariController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.red.shade900,
//         title: Text('Edit'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Name'),
//             ),
//             TextField(
//               controller: _noPlatController,
//               decoration: InputDecoration(labelText: 'No Plat'),
//             ),
//             TextField(
//               controller: _hariController,
//               decoration: InputDecoration(labelText: 'Jenis Kendaraan'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _isButtonEnabled
//                   ? () {
//                       Navigator.pop(
//                         context,
//                         Car(
//                           name: _nameController.text,
//                           no_plat: _noPlatController.text,
//                           jenis: _hariController.text,
//                         ),
//                       );
//                     }
//                   : null,
//               child: Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }