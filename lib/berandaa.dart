import 'package:flutter/material.dart';

class berandaa extends StatefulWidget {
  const berandaa({Key? key}) : super(key: key);

  @override
  _berandaaState createState() => _berandaaState();
}

class _berandaaState extends State<berandaa>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        toolbarHeight: 80,
        title: Align(
              alignment: Alignment.bottomLeft, // Mengatur teks ke atas
              child: Text('ParkirKu',style: TextStyle(fontSize: 30, ))
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            UserProfileSection(),
            SizedBox(height: 16),
            ParkingOptionsSection(),
            SizedBox(height: 16),
            RegularParkingSection(),
            Expanded(child: Container()),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavBar(),
    );
  }
}

class UserProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.shade900,
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.person, size: 40, color: Colors.white),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Yogi Asfira Andriawan', style: TextStyle(color: Colors.white, fontSize: 18)),
              Text('yogs@gmail.com', style: TextStyle(color: Colors.white70)),
            ],
          ),
          Spacer(),
          Column(
            children: [
              Text('Poin Anda', style: TextStyle(color: Colors.white)),
              Text('0 Poin', style: TextStyle(color: Colors.white)),
            ],
          ),
          Icon(Icons.notifications, color: Colors.white),
        ],
      ),
    );
  }
}

class ParkingOptionsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ParkingOption(icon: Icons.location_on, label: 'Lokasi Parkir'),
        ParkingOption(icon: Icons.local_parking, label: 'Mitra Terdekat'),
        ParkingOption(icon: Icons.card_giftcard, label: 'Klaim Voucher'),
      ],
    );
  }
}

class ParkingOption extends StatelessWidget {
  final IconData icon;
  final String label;

  ParkingOption({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 40, color: Colors.red.shade900),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}

class RegularParkingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.qr_code, size: 40),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Parkir Biasa'),
              Text('Tap untuk parkir'),
            ],
          ),
        ],
      ),
    );
  }
}

