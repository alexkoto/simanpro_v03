class Proyek {
  final String idpm;
  final String kontrak;
  final String nama;
  final String lokasi;
  final DateTime mulai;
  final DateTime selesai;
  final double terpakai;
  final double anggaran;
  final int progres;
  final List<AnggotaTim> tim;
  final List<Tahapan> tahapan;
  final List<Aktivitas> aktivitas;
  final List<Pembayaran> pembayaran;
  final List<Pengeluaran> pengeluaran;

  Proyek({
    required this.idpm,
    required this.kontrak,
    required this.nama,
    required this.lokasi,
    required this.mulai,
    required this.selesai,
    required this.terpakai,
    required this.anggaran,
    required this.progres,
    required this.tim,
    required this.tahapan,
    required this.aktivitas,
    required this.pembayaran,
    required this.pengeluaran,
  });
}

class AnggotaTim {
  final String nama;
  final String peran;

  AnggotaTim({required this.nama, required this.peran});
}

class Tahapan {
  final String nama;
  final int progres;

  Tahapan({required this.nama, required this.progres});
}

class Aktivitas {
  final String judul;
  final String deskripsi;
  final DateTime waktu;

  Aktivitas({
    required this.judul,
    required this.deskripsi,
    required this.waktu,
  });
}

class Pembayaran {
  final String nama;
  final double jumlah;
  final DateTime tanggal;
  final String status;

  Pembayaran({
    required this.nama,
    required this.jumlah,
    required this.tanggal,
    required this.status,
  });
}

class Pengeluaran {
  final String kategori;
  final double jumlah;
  final List<ItemPengeluaran> items;

  Pengeluaran({
    required this.kategori,
    required this.jumlah,
    required this.items,
  });
}

class ItemPengeluaran {
  final String nama;
  final double jumlah;

  ItemPengeluaran({required this.nama, required this.jumlah});
}
