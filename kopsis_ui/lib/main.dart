import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const KoperasiPage(),
    );
  }
}

class KoperasiPage extends StatelessWidget {
  const KoperasiPage({super.key});

  // Data barang koperasi
  final List<Map<String, dynamic>> daftarBarang = const [
    {
      'nama': 'Buku Tulis',
      'anggota': 3000,
      'umum': 3500,
      'stok': 40,
    },
    {
      'nama': 'Pulpen',
      'anggota': 2500,
      'umum': 3000,
      'stok': 25,
    },
    {
      'nama': 'Roti',
      'anggota': 5000,
      'umum': 5500,
      'stok': 15,
    },
    {
      'nama': 'Pensil',
      'anggota': 2000,
      'umum': 2500,
      'stok': 30,
    },
    {
      'nama': 'Penghapus',
      'anggota': 1500,
      'umum': 2000,
      'stok': 20,
    },
    {
      'nama': 'Spidol',
      'anggota': 4000,
      'umum': 4500,
      'stok': 18,
    },
    {
      'nama': 'Buku Gambar',
      'anggota': 5000,
      'umum': 5500,
      'stok': 22,
    },
    {
      'nama': 'Kertas HVS',
      'anggota': 10000,
      'umum': 12000,
      'stok': 10,
    },
    {
      'nama': 'Air Mineral',
      'anggota': 3000,
      'umum': 3500,
      'stok': 35,
    },
    {
      'nama': 'Susu Kotak',
      'anggota': 5000,
      'umum': 6000,
      'stok': 12,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Koperasi Sekolah'),
      ),

      body: ListView.builder(
        itemCount: daftarBarang.length,
        itemBuilder: (context, index) {
          final barang = daftarBarang[index];

          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.inventory_2),
              title: Text(barang['nama']),
              subtitle: Text(
                'Anggota Rp ${barang['anggota']} | '
                'Umum Rp ${barang['umum']}',
              ),
              trailing: Text(
                'Stok ${barang['stok']}',
              ),
            ),
          );
        },
      ),
    );
  }
}