import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simanpro_v03/models/proyek.dart';
import 'package:simanpro_v03/widgets/custom_appbar.dart';

class DaftarProyekScreen extends StatelessWidget {
  const DaftarProyekScreen({super.key});

  static final List<Proyek> daftarProyek = [
    Proyek(
      idpm: 'PM/001',
      kontrak: 'PJU/PKU/III-2023/001',
      nama: 'Pemasangan PJU Solar Cell',
      lokasi: 'Pekanbaru Kota',
      mulai: DateTime(2023, 3, 5),
      selesai: DateTime(2023, 6, 20),
      terpakai: 185000000,
      anggaran: 250000000,
      progres: 74,
      tim: [
        AnggotaTim(nama: 'Alex Candra', peran: 'Manajer Proyek'),
        AnggotaTim(nama: 'Badrul', peran: 'Teknisi Listrik'),
        AnggotaTim(nama: 'Cindy', peran: 'Quality Control'),
      ],
      tahapan: [
        Tahapan(nama: 'Survey Lokasi', progres: 100),
        Tahapan(nama: 'Pemasangan Tiang', progres: 80),
        Tahapan(nama: 'Instalasi Panel Surya', progres: 60),
        Tahapan(nama: 'Pengujian', progres: 40),
      ],
      aktivitas: [
        Aktivitas(
          judul: 'Pemasangan tiang selesai',
          deskripsi: 'Pemasangan tiang PJU di lokasi A selesai.',
          waktu: DateTime.now().subtract(const Duration(days: 1)),
        ),
        Aktivitas(
          judul: 'Pengujian panel surya',
          deskripsi: 'Pengujian panel surya di lokasi B.',
          waktu: DateTime.now().subtract(const Duration(days: 2)),
        ),
      ],
      pembayaran: [
        Pembayaran(
          nama: 'Termin 1',
          jumlah: 75000000,
          tanggal: DateTime(2023, 3, 15),
          status: 'Lunas',
        ),
        Pembayaran(
          nama: 'Termin 2',
          jumlah: 60000000,
          tanggal: DateTime(2023, 4, 20),
          status: 'Lunas',
        ),
        Pembayaran(
          nama: 'Termin 3',
          jumlah: 50000000,
          tanggal: DateTime(2023, 5, 25),
          status: 'Pending',
        ),
      ],
      pengeluaran: [
        Pengeluaran(
          kategori: 'Material',
          jumlah: 120000000,
          items: [
            ItemPengeluaran(nama: 'Panel Surya', jumlah: 80000000),
            ItemPengeluaran(nama: 'Baterai', jumlah: 30000000),
            ItemPengeluaran(nama: 'Kabel', jumlah: 10000000),
          ],
        ),
        Pengeluaran(
          kategori: 'Tenaga Kerja',
          jumlah: 45000000,
          items: [
            ItemPengeluaran(nama: 'Gaji Teknisi', jumlah: 30000000),
            ItemPengeluaran(nama: 'Transportasi', jumlah: 15000000),
          ],
        ),
        Pengeluaran(
          kategori: 'Lain-lain',
          jumlah: 20000000,
          items: [
            ItemPengeluaran(nama: 'Dokumentasi', jumlah: 5000000),
            ItemPengeluaran(nama: 'Administrasi', jumlah: 15000000),
          ],
        ),
      ],
    ),
    Proyek(
      idpm: 'PM/001',
      kontrak: 'PJK/UR/IV-2023/002',
      nama: 'Perbaikan Jaringan Listrik Kampus',
      lokasi: 'Universitas Riau, Pekanbaru',
      mulai: DateTime(2023, 4, 10),
      selesai: DateTime(2023, 8, 15),
      terpakai: 320000000,
      anggaran: 400000000,
      progres: 80,
      tim: [
        AnggotaTim(nama: 'Saipul Anwar', peran: 'Manajer Proyek'),
        AnggotaTim(nama: 'Yusi', peran: 'Teknisi Listrik'),
        AnggotaTim(nama: 'Mita', peran: 'Quality Control'),
      ],
      tahapan: [
        Tahapan(nama: 'Pengecekan Kerusakan', progres: 100),
        Tahapan(nama: 'Penggantian Kabel', progres: 75),
        Tahapan(nama: 'Perbaikan Panel', progres: 50),
        Tahapan(nama: 'Testing Jaringan', progres: 25),
      ],
      aktivitas: [
        Aktivitas(
          judul: 'Penggantian kabel selesai',
          deskripsi: 'Kabel baru sudah terpasang di gedung A.',
          waktu: DateTime.now().subtract(const Duration(days: 3)),
        ),
        Aktivitas(
          judul: 'Pemeriksaan panel listrik',
          deskripsi: 'Panel listrik di gedung B sudah diperiksa.',
          waktu: DateTime.now().subtract(const Duration(days: 4)),
        ),
      ],
      pembayaran: [
        Pembayaran(
          nama: 'Termin 1',
          jumlah: 150000000,
          tanggal: DateTime(2023, 4, 20),
          status: 'Lunas',
        ),
        Pembayaran(
          nama: 'Termin 2',
          jumlah: 120000000,
          tanggal: DateTime(2023, 6, 10),
          status: 'Lunas',
        ),
      ],
      pengeluaran: [
        Pengeluaran(
          kategori: 'Material',
          jumlah: 200000000,
          items: [
            ItemPengeluaran(nama: 'Kabel NYY', jumlah: 100000000),
            ItemPengeluaran(nama: 'Panel LVMDP', jumlah: 100000000),
          ],
        ),
        Pengeluaran(
          kategori: 'Tenaga Kerja',
          jumlah: 80000000,
          items: [
            ItemPengeluaran(nama: 'Instalasi', jumlah: 50000000),
            ItemPengeluaran(nama: 'Transportasi', jumlah: 30000000),
          ],
        ),
        Pengeluaran(
          kategori: 'Lain-lain',
          jumlah: 40000000,
          items: [
            ItemPengeluaran(nama: 'Izin Kerja', jumlah: 10000000),
            ItemPengeluaran(nama: 'Dokumentasi', jumlah: 30000000),
          ],
        ),
      ],
    ),
    Proyek(
      idpm: 'PM/002',
      kontrak: 'ILR/DUM/II-2023/003',

      nama: 'Instalasi Listrik Rumah Sakit Awal Bros',
      lokasi: 'Dumai',
      mulai: DateTime(2023, 2, 1),
      selesai: DateTime(2023, 5, 30),
      terpakai: 275000000,
      anggaran: 350000000,
      progres: 79,
      tim: [
        AnggotaTim(nama: 'Juni Anita', peran: 'Manajer Proyek'),
        AnggotaTim(nama: 'Dika', peran: 'Teknisi Listrik'),
        AnggotaTim(nama: 'Cindy', peran: 'Quality Control'),
      ],
      tahapan: [
        Tahapan(nama: 'Perencanaan Teknis', progres: 100),
        Tahapan(nama: 'Pemasangan Kabel', progres: 85),
        Tahapan(nama: 'Instalasi MCB & Panel', progres: 65),
        Tahapan(nama: 'Uji Coba', progres: 45),
      ],
      aktivitas: [
        Aktivitas(
          judul: 'Pemasangan kabel selesai',
          deskripsi: 'Kabel sudah terpasang di semua ruangan.',
          waktu: DateTime.now().subtract(const Duration(days: 5)),
        ),
        Aktivitas(
          judul: 'Instalasi MCB selesai',
          deskripsi: 'MCB sudah terpasang di panel listrik.',
          waktu: DateTime.now().subtract(const Duration(days: 6)),
        ),
      ],
      pembayaran: [
        Pembayaran(
          nama: 'Termin 1',
          jumlah: 150000000,
          tanggal: DateTime(2023, 2, 20),
          status: 'Lunas',
        ),
        Pembayaran(
          nama: 'Termin 2',
          jumlah: 100000000,
          tanggal: DateTime(2023, 4, 5),
          status: 'Lunas',
        ),
      ],
      pengeluaran: [
        Pengeluaran(
          kategori: 'Material',
          jumlah: 180000000,
          items: [
            ItemPengeluaran(nama: 'Kabel', jumlah: 60000000),
            ItemPengeluaran(nama: 'MCB & Panel', jumlah: 60000000),
            ItemPengeluaran(nama: 'Tray Kabel', jumlah: 60000000),
          ],
        ),
        Pengeluaran(
          kategori: 'Tenaga Kerja',
          jumlah: 65000000,
          items: [
            ItemPengeluaran(nama: 'Instalasi', jumlah: 45000000),
            ItemPengeluaran(nama: 'Konsumsi & Transportasi', jumlah: 20000000),
          ],
        ),
        Pengeluaran(
          kategori: 'Lain-lain',
          jumlah: 30000000,
          items: [
            ItemPengeluaran(nama: 'Administrasi', jumlah: 10000000),
            ItemPengeluaran(nama: 'Uji Kelayakan', jumlah: 20000000),
          ],
        ),
      ],
    ),
    Proyek(
      idpm: 'PM/003',
      kontrak: 'RGL/PNM/V-2023/004',
      nama: 'Rehabilitasi Gardu Listrik',
      lokasi: 'Panam, Pekanbaru',
      mulai: DateTime(2023, 5, 15),
      selesai: DateTime(2023, 9, 10),
      terpakai: 410000000,
      anggaran: 480000000,
      progres: 85,
      tim: [
        AnggotaTim(nama: 'Mita', peran: 'Manajer Proyek'),
        AnggotaTim(nama: 'Badrul', peran: 'Teknisi Listrik'),
        AnggotaTim(nama: 'Yusi', peran: 'Quality Control'),
      ],
      tahapan: [
        Tahapan(nama: 'Pemeriksaan Kondisi', progres: 100),
        Tahapan(nama: 'Penggantian Trafo', progres: 80),
        Tahapan(nama: 'Perbaikan Kabel', progres: 70),
        Tahapan(nama: 'Pengujian Sistem', progres: 50),
      ],
      aktivitas: [
        Aktivitas(
          judul: 'Penggantian trafo selesai',
          deskripsi: 'Trafo baru sudah terpasang dan berfungsi.',
          waktu: DateTime.now().subtract(const Duration(days: 7)),
        ),
        Aktivitas(
          judul: 'Pemeriksaan kabel selesai',
          deskripsi: 'Kabel sudah diperiksa dan diganti.',
          waktu: DateTime.now().subtract(const Duration(days: 8)),
        ),
      ],
      pembayaran: [
        Pembayaran(
          nama: 'Termin 1',
          jumlah: 200000000,
          tanggal: DateTime(2023, 6, 1),
          status: 'Lunas',
        ),
        Pembayaran(
          nama: 'Termin 2',
          jumlah: 150000000,
          tanggal: DateTime(2023, 7, 20),
          status: 'Lunas',
        ),
      ],
      pengeluaran: [
        Pengeluaran(
          kategori: 'Material',
          jumlah: 250000000,
          items: [
            ItemPengeluaran(nama: 'Trafo Distribusi', jumlah: 150000000),
            ItemPengeluaran(nama: 'Kabel TM', jumlah: 100000000),
          ],
        ),
        Pengeluaran(
          kategori: 'Tenaga Kerja',
          jumlah: 100000000,
          items: [
            ItemPengeluaran(nama: 'Pemasangan', jumlah: 70000000),
            ItemPengeluaran(nama: 'Pengujian', jumlah: 30000000),
          ],
        ),
        Pengeluaran(
          kategori: 'Lain-lain',
          jumlah: 60000000,
          items: [
            ItemPengeluaran(nama: 'Dokumentasi', jumlah: 10000000),
            ItemPengeluaran(nama: 'Survei Ulang', jumlah: 50000000),
          ],
        ),
      ],
    ),
    Proyek(
      idpm: 'PM/003',
      kontrak: 'PLP/KPR/VI-2023/005',
      nama: 'Pembangunan Listrik Pedesaan',
      lokasi: 'Kampar',
      mulai: DateTime(2023, 6, 1),
      selesai: DateTime(2023, 10, 30),
      terpakai: 380000000,
      anggaran: 450000000,
      progres: 84,
      tim: [
        AnggotaTim(nama: 'Saipul Anwar', peran: 'Manajer Proyek'),
        AnggotaTim(nama: 'Alex Candra', peran: 'Teknisi Listrik'),
        AnggotaTim(nama: 'Juni Anita', peran: 'Quality Control'),
      ],
      tahapan: [
        Tahapan(nama: 'Pemetaan Jaringan', progres: 100),
        Tahapan(nama: 'Pemasangan Tiang', progres: 75),
        Tahapan(nama: 'Penarikan Kabel', progres: 60),
        Tahapan(nama: 'Sambungan Rumah', progres: 40),
      ],
      aktivitas: [
        Aktivitas(
          judul: 'Pemasangan tiang selesai',
          deskripsi: 'Tiang listrik sudah terpasang di lokasi A.',
          waktu: DateTime.now().subtract(const Duration(days: 9)),
        ),
        Aktivitas(
          judul: 'Penarikan kabel selesai',
          deskripsi: 'Kabel sudah ditarik ke rumah-rumah warga.',
          waktu: DateTime.now().subtract(const Duration(days: 10)),
        ),
      ],
      pembayaran: [
        Pembayaran(
          nama: 'Termin 1',
          jumlah: 200000000,
          tanggal: DateTime(2023, 6, 15),
          status: 'Lunas',
        ),
        Pembayaran(
          nama: 'Termin 2',
          jumlah: 100000000,
          tanggal: DateTime(2023, 8, 5),
          status: 'Pending',
        ),
      ],
      pengeluaran: [
        Pengeluaran(
          kategori: 'Material',
          jumlah: 250000000,
          items: [
            ItemPengeluaran(nama: 'Tiang Beton', jumlah: 120000000),
            ItemPengeluaran(nama: 'Kabel TR', jumlah: 80000000),
            ItemPengeluaran(nama: 'Aksesoris Jaringan', jumlah: 50000000),
          ],
        ),
        Pengeluaran(
          kategori: 'Tenaga Kerja',
          jumlah: 90000000,
          items: [
            ItemPengeluaran(nama: 'Instalasi', jumlah: 60000000),
            ItemPengeluaran(nama: 'Transportasi', jumlah: 30000000),
          ],
        ),
        Pengeluaran(
          kategori: 'Lain-lain',
          jumlah: 40000000,
          items: [
            ItemPengeluaran(nama: 'Dokumentasi', jumlah: 15000000),
            ItemPengeluaran(nama: 'Keamanan', jumlah: 25000000),
          ],
        ),
      ],
    ), // Tambahkan proyek lain jika perlu
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Daftar Proyek'),
      body: SingleChildScrollView(
        child: PaginatedDataTable(
          // header: const Text('Daftar Proyek'),
          rowsPerPage: 5,
          columns: const [
            DataColumn(label: Text('No.SPK')),
            DataColumn(label: Text('Nama')),
            DataColumn(label: Text('Lokasi')),
            DataColumn(label: Text('Progress')),
            DataColumn(label: Text('Mulai')),
            DataColumn(label: Text('Selesai')),
            DataColumn(label: Text('Aksi')),
          ],
          source: _ProyekDataSource(daftarProyek, context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Tambah proyek baru')));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ProyekDataSource extends DataTableSource {
  final List<Proyek> proyekList;
  final BuildContext context;

  _ProyekDataSource(this.proyekList, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= proyekList.length) return null;

    final proyek = proyekList[index];
    final dateFormat = DateFormat('dd-MM-yyyy');

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(proyek.kontrak)),
        DataCell(Text(proyek.nama)),
        DataCell(Text(proyek.lokasi)),
        DataCell(Text('${proyek.progres}%')),
        DataCell(Text(dateFormat.format(proyek.mulai))),
        DataCell(Text(dateFormat.format(proyek.selesai))),
        DataCell(
          IconButton(
            icon: const Icon(Icons.info, color: Colors.blue),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Detail untuk ${proyek.nama}')),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => proyekList.length;

  @override
  int get selectedRowCount => 0;
}
