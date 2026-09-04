import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static const List<Map<String, dynamic>> daftarBarang = [
    {
      'nama':
          'Buku Tulis Bergaris 58 Lembar Sampul Tebal Untuk Keperluan Sekolah',
      'anggota': 3000,
      'umum': 3500,
      'stok': 40,
      'kategori': 'ATK',
    },
    {
      'nama': 'Pulpen',
      'anggota': 2500,
      'umum': 3000,
      'stok': 25,
      'kategori': 'ATK',
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
      'stok': 20,
      'kategori': 'ATK',
    },
    {
      'nama': 'Penghapus',
      'anggota': 1500,
      'umum': 2000,
      'stok': 18,
      'kategori': 'ATK',
    },
    {
      'nama': 'Buku Gambar',
      'anggota': 4000,
      'umum': 4500,
      'stok': 12,
      'kategori': 'ATK',
    },
    {
      'nama': 'Air Mineral',
      'anggota': 3000,
      'umum': 3500,
      'stok': 30,
      'kategori': 'Minuman',
    },
    {
      'nama': 'Teh Kotak',
      'anggota': 4000,
      'umum': 4500,
      'stok': 20,
      'kategori': 'Minuman',
    },
    {
      'nama': 'Mie Instan',
      'anggota': 3500,
      'umum': 4000,
      'stok': 10,
      'kategori': 'Makanan',
    },
    {
      'nama': 'Snack',
      'anggota': 2500,
      'umum': 3000,
      'stok': 15,
      'kategori': 'Makanan',
    },
  ];

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String pencarian = '';

  @override
  Widget build(BuildContext context) {
    final daftarFilter = MyApp.daftarBarang.where((barang) {
      final nama = barang['nama'].toString().toLowerCase();

      return nama.contains(pencarian.toLowerCase());
    }).toList();

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
                decoration: InputDecoration(
                  labelText: 'Cari barang',
                  hintText: 'Masukkan nama barang',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    pencarian = value;
                  });
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Lebar layar: '
                  '${MediaQuery.of(context).size.width.toStringAsFixed(0)} px',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int jumlahKolom;

                  if (constraints.maxWidth < 600) {
                    jumlahKolom = 1;
                  } else if (constraints.maxWidth < 1000) {
                    jumlahKolom = 2;
                  } else {
                    jumlahKolom = 3;
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: jumlahKolom,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,

                      // Dibuat lebih proporsional agar tidak
                      // menyebabkan overflow ke bawah.
                      childAspectRatio: 1.8,
                    ),
                    itemCount: daftarFilter.length,
                    itemBuilder: (context, index) {
                      final barang = daftarFilter[index];

                      return BarangCard(
                        nama: barang['nama'],
                        hargaAnggota: barang['anggota'],
                        stok: barang['stok'],
                        kategori: barang['kategori'],
                        sorot: barang['stok'] == 0,
                      );
                    },
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

class BarangCard extends StatelessWidget {
  final String nama;
  final int hargaAnggota;
  final int stok;
  final String kategori;
  final bool sorot;

  const BarangCard({
    super.key,
    required this.nama,
    required this.hargaAnggota,
    required this.stok,
    required this.kategori,
    this.sorot = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: sorot ? Colors.green[100] : null,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon berada di atas
            const Icon(
              Icons.inventory_2,
              size: 32,
            ),

            const SizedBox(height: 6),

            // Nama barang dipotong jika terlalu panjang
            Text(
              nama,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              'Anggota Rp $hargaAnggota',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),

            Text(
              kategori,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 4),

            // Memberi ruang fleksibel agar layout tetap aman
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: KeranjangItem(
                  stok: stok,
                  harga: hargaAnggota,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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