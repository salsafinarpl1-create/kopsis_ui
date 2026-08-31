import 'package:flutter/material.dart';
import 'package:kopsis_ui/keranjang_item.dart';

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
      child: ListTile(
        leading: const Icon(Icons.inventory_2),
        title: Text(nama),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Anggota Rp $hargaAnggota'),
            Text(
              kategori,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        trailing: KeranjangItem(
          stok: stok,
          harga: hargaAnggota,
        ),
      ),
    );
  }
}