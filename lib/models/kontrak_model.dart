class Kontrak {
  final int idKontrak;
  final String noKontrak;
  final String namaKontrak;
  final int idPemberiKerja;
  final int? idProjectManager;
  final double nilaiKontrak;
  final DateTime tglMulai;
  final DateTime tglSelesai;
  final String lokasiProyek;
  final String? alamatProyek;
  final String? kotaProyek;
  final String? provinsiProyek;
  final String jenisKontrak;
  final String sumberDana;
  final String? kategoriProyek;
  final String? keterangan;
  final String status;
  final bool isActive;
  final int createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? namaPemberiKerja;
  final String? namaProjectManager;

  Kontrak({
    required this.idKontrak,
    required this.noKontrak,
    required this.namaKontrak,
    required this.idPemberiKerja,
    this.idProjectManager,
    required this.nilaiKontrak,
    required this.tglMulai,
    required this.tglSelesai,
    required this.lokasiProyek,
    this.alamatProyek,
    this.kotaProyek,
    this.provinsiProyek,
    required this.jenisKontrak,
    required this.sumberDana,
    this.kategoriProyek,
    this.keterangan,
    required this.status,
    required this.isActive,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.namaPemberiKerja,
    this.namaProjectManager,
  });

  factory Kontrak.fromJson(Map<String, dynamic> json) {
    return Kontrak(
      idKontrak: json['id_kontrak'],
      noKontrak: json['no_kontrak'],
      namaKontrak: json['nama_kontrak'],
      idPemberiKerja: json['id_pemberi_kerja'],
      idProjectManager: json['id_projectmanager'],
      nilaiKontrak: double.parse(json['nilai_kontrak'].toString()),
      tglMulai: DateTime.parse(json['tgl_mulai']),
      tglSelesai: DateTime.parse(json['tgl_selesai']),
      lokasiProyek: json['lokasi_proyek'],
      alamatProyek: json['alamat_proyek'],
      kotaProyek: json['kota_proyek'],
      provinsiProyek: json['provinsi_proyek'],
      jenisKontrak: json['jenis_kontrak'],
      sumberDana: json['sumber_dana'],
      kategoriProyek: json['kategori_proyek'],
      keterangan: json['keterangan'],
      status: json['status'],
      isActive: json['is_active'] == 1,
      createdBy: json['created_by'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      namaPemberiKerja: json['nama_pemberi_kerja'],
      namaProjectManager: json['nama_project_manager'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_kontrak': idKontrak,
      'no_kontrak': noKontrak,
      'nama_kontrak': namaKontrak,
      'id_pemberi_kerja': idPemberiKerja,
      'id_projectmanager': idProjectManager,
      'nilai_kontrak': nilaiKontrak,
      'tgl_mulai': tglMulai.toIso8601String(),
      'tgl_selesai': tglSelesai.toIso8601String(),
      'lokasi_proyek': lokasiProyek,
      'alamat_proyek': alamatProyek,
      'kota_proyek': kotaProyek,
      'provinsi_proyek': provinsiProyek,
      'jenis_kontrak': jenisKontrak,
      'sumber_dana': sumberDana,
      'kategori_proyek': kategoriProyek,
      'keterangan': keterangan,
      'status': status,
      'is_active': isActive ? 1 : 0,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}