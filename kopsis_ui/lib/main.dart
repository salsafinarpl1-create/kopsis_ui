import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static const List<Map<String, dynamic>> daftarBarang = [
    {
      'nama': 'Buku Tulis',
      'anggota': 3000,
      'umum': 3500,
      'stok': 40,
      'kategori': 'Alat Tulis',
    },
    {
      'nama': 'Pulpen',
      'anggota': 2500,
      'umum': 3000,
      'stok': 25,
      'kategori': 'Alat Tulis',
    },
    {
      'nama': 'Roti',
      'anggota': 5000,
      'umum': 5500,
      'stok': 15,
      'kategori': 'Makanan',
    },
    {
      'nama': 'Pensil',
      'anggota': 2000,
      'umum': 2500,
      'stok': 30,
      'kategori': 'Alat Tulis',
    },
    {
      'nama': 'Penghapus',
      'anggota': 1500,
      'umum': 2000,
      'stok': 20,
      'kategori': 'Alat Tulis',
    },
    {
      'nama': 'Penggaris',
      'anggota': 2500,
      'umum': 3000,
      'stok': 18,
      'kategori': 'Alat Tulis',
    },
    {
      'nama': 'Spidol',
      'anggota': 4000,
      'umum': 4500,
      'stok': 12,
      'kategori': 'Alat Tulis',
    },
    {
      'nama': 'Buku Gambar',
      'anggota': 5000,
      'umum': 6000,
      'stok': 0,
      'kategori': 'Alat Tulis',
    },
    {
      'nama': 'Lem Kertas',
      'anggota': 3500,
      'umum': 4000,
      'stok': 14,
      'kategori': 'Alat Tulis',
    },
    {
      'nama': 'Tempat Pensil',
      'anggota': 10000,
      'umum': 12000,
      'stok': 10,
      'kategori': 'Aksesoris',
    },
  ];

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TextEditingController _controller;
  String kataCari = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Hanya menampilkan barang yang stoknya lebih dari 0
    final barangTersedia = MyApp.daftarBarang
        .where((barang) => barang['stok'] > 0)
        .toList();

    // Menyaring barang berdasarkan kata yang diketik
    final hasilCari = barangTersedia
        .where(
          (barang) => barang['nama']
              .toLowerCase()
              .contains(kataCari),
        )
        .toList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Koperasi Sekolah'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Cari barang...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (nilai) {
                  setState(() {
                    kataCari = nilai.toLowerCase().trim();
                  });
                },
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: hasilCari.length,
                itemBuilder: (context, index) {
                  final barang = hasilCari[index];

                  return BarangCard(
                    nama: barang['nama'],
                    hargaAnggota: barang['anggota'],
                    stok: barang['stok'],
                    kategori: barang['kategori'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===============================
// BARANG CARD
// ===============================

class BarangCard extends StatelessWidget {
  final String nama;
  final int hargaAnggota;
  final int stok;
  final String kategori;

  const BarangCard({
    super.key,
    required this.nama,
    required this.hargaAnggota,
    required this.stok,
    required this.kategori,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade200,
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            const Icon(Icons.inventory_2),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Anggota Rp $hargaAnggota',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    kategori,
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            KeranjangItem(
              stok: stok,
              harga: hargaAnggota,
            ),
          ],
        ),
      ),
    );
  }
}

// ===============================
// KERANJANG ITEM
// ===============================

class KeranjangItem extends StatefulWidget {
  final int stok;
  final int harga;

  const KeranjangItem({
    super.key,
    required this.stok,
    required this.harga,
  });

  @override
  State<KeranjangItem> createState() => _KeranjangItemState();
}

class _KeranjangItemState extends State<KeranjangItem> {
  int jumlah = 1;

  @override
  void initState() {
    super.initState();
    print('initState dipanggil');
  }

  @override
  void dispose() {
    print('dispose dipanggil');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build dipanggil');

    int totalHarga = jumlah * widget.harga;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            setState(() {
              if (jumlah > 0) {
                jumlah--;
              }
            });
          },
        ),

        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(jumlah.toString()),
            Text(
              'Rp$totalHarga',
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),

        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            if (jumlah < widget.stok) {
              setState(() {
                jumlah++;
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Jumlah melebihi stok barang!',
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}