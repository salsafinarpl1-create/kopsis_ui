import 'package:flutter/material.dart';
import 'barang_card.dart';

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
      'stok': 0,
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
      'nama' : 'Penggaris',
      'anggota' : 6000,
      'umum' : 7000,
      'stok' : 12,
    },
    {
      'nama' : 'Spidol',  
      'anggota' : 6000,
      'umum' : 5000,
      'stok' : 17,
    },
    {
      'nama' : 'Lem Kertas',
      'anggota' : 4000,
      'umum' : 4500,
      'stok' : 10,
    },
    {
      'nama' : 'Biskuit',
      'anggota' : 5500,
      'umum' : 6000,
      'stok' : 17,
    },
    {
      'nama' : 'Susu Kotak',
      'anggota' : 4500, 
      'umum' : 5000,
      'stok' : 22,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Koperasi Sekolah'),
      ),

      body: Builder(
        builder: (context) {
          final barangTersedia = daftarBarang
                .where((barang) => barang['stok'] > 0)
                .toList();
          return ListView.builder(
            itemCount: barangTersedia.length,
            itemBuilder: (context, index) {
                final barang = barangTersedia[index];

          return BarangCard(
            nama: barang['nama'],
            hargaAnggota: barang['anggota'],
            stok: barang['stok'],
            kategori: 'Alat Tulis',
            sorot: true,
          );
        },
          );
        },
      ),
    );
  }
}