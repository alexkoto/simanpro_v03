// lib/widgets/screen_navigator.dart

import 'package:flutter/material.dart';
import 'package:simanpro_v03/screens/dashbord/alert_system_screen.dart';
import 'package:simanpro_v03/screens/dashbord/financial_overview_screen.dart';
import 'package:simanpro_v03/screens/dashbord/ringkasan_proyek_screen.dart';
import 'package:simanpro_v03/screens/proyek/daftar_proyek_screen.dart';
import 'placeholder_screen.dart';

Widget getScreenByTitle(String title) {
  switch (title) {
    case 'Ringkasan Proyek':
      return const RingkasanProyekScreen();
    case 'Financial Overview':
      return const FinancialOverviewScreen();
    case 'Alert System':
      return const AlertSystemScreen();
    case 'Daftar Proyek':
      return  DaftarProyekScreen();
    case 'Document Control':
      // return const DocumentControlScreen();
    case 'Timeline & Scheduling':
      // return TimelineSchedulingScreen();
    case 'Stock Management':
      // return StockManagementScreen();
    case 'Purchase Order':
      // return PurchaseOrderScreen();
    case 'Penggunaan Material':
      // return PenggunaanMaterialScreen();
    case 'Pengembalian Material':
      // return PengembalianMaterialScreen();
    case 'Equipment':
      // return EquipmentScreen();
      break;
    case 'Equipment Tracking':
      // return EquipmentTrackingScreen();
      break;
    case 'Maintenance Log':
      // return MaintenanceLogScreen();
      break;
    case 'Fuel Monitoring':
      // return FuelMonitoringScreen();
      break;
    case 'Peminjaman Kendaraan':
      // return PeminjamanKendaraanScreen();
      break;
    case 'Jatuh Tempo Pajak & Perizinan':
      // return PajakPerizinanScreen();
      break;
    case 'Absensi Online':
      // return AbsensiOnline();
      break;
    case 'Skill Matrix':
      // return SkillMatrixScreen();
      break;
    case 'Timesheet':
      // return TimesheetScreen();
      break;
    case 'Inspeksi Harian':
      // return InspeksiHarianScreen();
      break;
    case 'Laporan Insiden':
      // return LaporanInsidenScreen();
      break;
    case 'Audit QC':
      // return AuditQCScreen();
      break;
    case 'Progress Billing':
      // return ProgressBillingScreen();
      break;
    case 'Biaya Operasional':
      // return BiayaOperasionalScreen();
      break;
    case 'Invoice Management':
      // return InvoiceManagementScreen();
      break;
    case 'Daily Report':
      // return DailyReportScreen();
      break;
    case 'Laporan Bulanan':
      // return MonthlyReportScreen();
      break;
    case 'Arsip Digital':
      // return ArsipDigitalScreen();
      break;
    case 'Photo Documentation':
    case 'Offline Mode':
    case 'Signature Capture':
    case 'Timeline':
      return PlaceholderScreen(title: title);
    default:
      return PlaceholderScreen(title: title);
  }

  return PlaceholderScreen(title: title); // fallback jika case masih dikomentari
}
