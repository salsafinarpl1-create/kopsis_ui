import 'package:flutter/material.dart';

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

    // Kalau stok 0, jumlah dimulai dari 0
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
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: jumlah > 0
              ? () {
                  setState(() {
                    jumlah--;
                  });
                }
              : null,
        ),

        // Jumlah dan total harga
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                jumlah.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Rp$totalHarga',
                style: const TextStyle(
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        IconButton(
          icon: const Icon(Icons.add),
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