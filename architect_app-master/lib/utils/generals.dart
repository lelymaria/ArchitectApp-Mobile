import 'package:intl/intl.dart';

class Generals {
  static formatRupiah(angka) {
    String rupiah =
        NumberFormat.currency(locale: 'id-ID', symbol: 'Rp. ', decimalDigits: 0)
            .format(angka);
    return rupiah;
  }
  
  static rupiahNotRp(angka) {
    String rupiah =
        NumberFormat.simpleCurrency(decimalDigits: 0,)
            .format(angka);
    return rupiah;
  }

   // android download storage
  static String downloadStorage = '/storage/emulated/0/Download';

  // static String baseUrl = "http://192.168.43.163:8000";
  static String baseUrl = "http://192.168.100.12:8000";
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
