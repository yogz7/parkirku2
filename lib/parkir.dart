// import 'package:flutter/material.dart';
// import 'package:parkirku/edit.dart';
// import 'package:parkirku/Tambah parkir.dart'; // Impor file edit.dart

// class Car {
//   final String name;
//   final String no_plat;
//   final String jenis;

//   Car({required this.name, required this.no_plat, required this.jenis});
// }

// class RiwayatScreen extends StatefulWidget {
//   const RiwayatScreen({Key? key}) : super(key: key);

//   @override
//   _RiwayatScreenState createState() => _RiwayatScreenState();
// }

// class _RiwayatScreenState extends State<RiwayatScreen> {
//   final List<Car> cars = [
//     Car(name: 'Brio', no_plat: 'L 1234 NH', jenis: 'Mobil'),
//     Car(name: 'Mustang', no_plat: 'S 2345 BH', jenis: 'Truk'),
//     Car(name: 'Civic', no_plat: 'J 3455 KT', jenis: 'Bus'),
    
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.red.shade900,
//         toolbarHeight: 80,
//         title: Align(
//               alignment: Alignment.center, // Mengatur teks ke atas
//               child: Text('Sedang AParkir',style: TextStyle(fontSize: 30, ))
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: cars.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(cars[index].name),
//             subtitle: Text('${cars[index].no_plat} - ${cars[index].jenis}'),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () async {
//                     final updatedCar = await Navigator.push<Car>(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => EditCarScreen(car: cars[index]),
//                       ),
//                     );

//                     if (updatedCar != null) {
//                       setState(() {
//                         cars[index] = updatedCar;
//                       });
//                     }
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () {
//                     setState(() {
//                       cars.removeAt(index);
//                     });
//                   },
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final newCar = await Navigator.push<Car>(
//             context,
//             MaterialPageRoute(
//               builder: (context) => daftar(car: Car(name: '', no_plat: '', jenis: '')),
//             ),
//           );

//           if (newCar != null) {
//             setState(() {
//               cars.add(newCar);
//             });
//           }
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.red.shade900,
//       ),
//     );
//   }
// }