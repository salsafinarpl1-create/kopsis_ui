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

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        useMaterial3: true,
      ),

      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Koperasi Sekolah',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),

        body: Column(
          children: [
            // TEXT FIELD PENCARIAN
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Cari barang',
                  hintText: 'Masukkan nama barang',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.green[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    pencarian = value;
                  });
                },
              ),
            ),

            // INFORMASI LEBAR LAYAR
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
                    color: Colors.green,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // EXPANDED
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int jumlahKolom;

                  // RESPONSIVE GRID
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

                      // Ukuran kartu dibuat aman
                      childAspectRatio: 1.65,
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

// ============================================================
// BARANG CARD - STATELESS
// ============================================================

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
      color: Colors.green[100],
      margin: EdgeInsets.zero,
      elevation: 2,

      child: Padding(
        padding: const EdgeInsets.all(10),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ICON + NAMA
            Row(
              children: [
                const Icon(
                  Icons.inventory_2,
                  color: Colors.green,
                  size: 28,
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    nama,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),

            // HARGA
            Text(
              'Anggota Rp $hargaAnggota',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),

            // KATEGORI
            Text(
              kategori,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.green,
              ),
            ),

            // STOK
            Text(
              'Stok: $stok',
              style: const TextStyle(
                fontSize: 12,
              ),
            ),

            const Spacer(),

            // KERANJANG ITEM
            Center(
              child: KeranjangItem(
                stok: stok,
                harga: hargaAnggota,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// KERANJANG ITEM - STATEFUL
// ============================================================

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

    if (widget.stok == 0) {
      jumlah = 0;
    }

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

    final int totalHarga = jumlah * widget.harga;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // TOMBOL KURANG
        IconButton(
          icon: const Icon(
            Icons.remove,
            color: Colors.green,
          ),
          tooltip: 'Kurangi jumlah',

          onPressed: jumlah > 0
              ? () {
                  setState(() {
                    jumlah--;
                  });
                }
              : null,
        ),

        // JUMLAH + TOTAL
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              jumlah.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              'Rp$totalHarga',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.green,
              ),
            ),
          ],
        ),

        // TOMBOL TAMBAH
        IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.green,
          ),
          tooltip: 'Tambah jumlah',

          onPressed: jumlah < widget.stok
              ? () {
                  setState(() {
                    jumlah++;
                  });
                }
              : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Jumlah melebihi stok barang!',
                      ),
                    ),
                  );
                },
        ),
      ],
    );
  }
}