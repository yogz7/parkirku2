import 'package:flutter/material.dart';
import 'package:parkirku/parkir.dart';

class DetailPage extends StatelessWidget {
  final Parkir parkir;
  const DetailPage({super.key, required this.parkir});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Page',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red.shade900,
      ),
      body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'id_parkir: ${parkir.idParkir}',
        ),
        Text(
          'Nama Pengguna: ${parkir.namaPengguna}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        Text('Nomor Plaat: ${parkir.nomorPlat}'),
        Text('Jenis Kendaraan: ${parkir.jenisKendaraan}'),
      ])),
    );
  }
}
