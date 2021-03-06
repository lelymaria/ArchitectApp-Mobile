import 'package:intl/intl.dart';

/* List Format */
class Generals {
  static formatRupiah(angka) {
    String rupiah =
        NumberFormat.currency(locale: 'id-ID', symbol: 'Rp. ', decimalDigits: 0)
            .format(angka);
    return rupiah;
  }

  static rupiahNotRp(angka) {
    String rupiah = NumberFormat.simpleCurrency(
      decimalDigits: 0,
    ).format(angka);
    return rupiah;
  }

  // android download storage
  static String downloadStorage = '/storage/emulated/0/Download';

  // static String baseUrl = "http://192.168.42.231:8000";
  static String baseUrl = "http://arsitekco.proyek.ti.polindra.ac.id/public";
  // static String baseUrl = "http://10.0.2.2:8000";
  // static String baseUrl = "http://1803010.web.ti.polindra.ac.id";

  // Format File
  static List<String> listFormatFile = [
    "PDF",
    "pdf",
    "JPG",
    "jpg",
    "JPEG",
    "jpeg",
    "PNG",
    "png",
  ];

  // Format File
  static List<String> listFormatImage = [
    "JPG",
    "jpg",
    "JPEG",
    "jpeg",
    "PNG",
    "png",
  ];

  // Format File
  static List<String> listFormatPdf = ["PDF", "pdf"];
}
