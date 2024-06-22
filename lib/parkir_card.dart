import 'package:flutter/material.dart';
import 'package:parkirku/detail_page.dart';
import 'package:parkirku/parkir.dart';

class ParkirCard extends StatelessWidget {
  const ParkirCard({super.key, required this.parkir, required double width});
  final Parkir parkir;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) {
              return DetailPage(parkir: parkir);
            }),
          ),
        );
      },
      child: Container(
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Pengguna : ${parkir.namaPengguna}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text('nomor plat : ${parkir.nomorPlat}'),
              Text('jenis kendaraan : ${parkir.jenisKendaraan}'),
            ],
          )),
    );
  }
}
