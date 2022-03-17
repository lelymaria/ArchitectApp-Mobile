import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/forms/lelang_form.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/utils/validations.dart';
import 'package:architect_app/views/home/form/second_screen.dart';
import 'package:architect_app/views/home/form/style_info.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  final LelangForm form;

  FirstScreen({this.form});

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<Jasa> tmpJasa = [];
  Property selectedProperty;
  DesignStyle selectedDesign;
  TextEditingController _budgetFrom = new TextEditingController();
  TextEditingController _budgetTo = new TextEditingController();
  TextEditingController _luas = new TextEditingController();
  TextEditingController _panjang = new TextEditingController();
  TextEditingController _lebar = new TextEditingController();
  Repository _repository = Repository();
  AuthPreference _authPreference = AuthPreference();
  final _formKey = GlobalKey<FormState>();
  bool isCheck = false;
  String _dataalamat;
  String _datatelepon;

  _initialize() async {
    try {
      var res = await _repository.getDataOwner(_authPreference);
      setState(() {
        _dataalamat = res['data']['owner']['alamat'];
        _datatelepon = res['data']['owner']['telepon'];
      });
    } catch (e) {}
  }

  @override
  void initState() {
    _initialize();
    _lebar.addListener(() {
      setState(() {
        var luas = int.parse(_panjang.text) * int.parse(_lebar.text);
        _luas.text = luas.toString();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _panjang.dispose();
    _lebar.dispose();
    super.dispose();
  }

  List<Property> properties = [
    Property("Rumah Tinggal"),
    Property("Apartemen"),
    Property("Toko"),
    Property("Restoran"),
    Property("Hotel"),
  ];

  List<DropdownMenuItem> generatedProperties(List<Property> properties) {
    List<DropdownMenuItem> items = [];
    for (var item in properties) {
      items.add(DropdownMenuItem(
        child: Text(item.name),
        value: item,
      ));
    }
    return items;
  }

  List<DesignStyle> designs = [
    DesignStyle("Minimalis"),
    DesignStyle("Modern"),
    DesignStyle("Tradisional"),
    DesignStyle("Scandinavian"),
  ];

  List<DropdownMenuItem> generatedDesigns(List<DesignStyle> properties) {
    List<DropdownMenuItem> items = [];
    for (var item in properties) {
      items.add(DropdownMenuItem(
        child: Text(item.designName),
        value: item,
      ));
    }
    return items;
  }

  Map<String, bool> valueJasa = {
    "Desain": false,
    "Rencana Anggaran Biaya": false,
    // "Kontraktor": false,
  };

  @override
  Widget build(BuildContext context) {
    print(tmpJasa.toString());
    // print(tmpJasa.length);
    // tmpJasa.clear();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cari Jasa",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView(
            children: [
              Text("Jasa yang dibutuhkan", style: blackFontStyle3),
              ListView(
                shrinkWrap: true,
                children: valueJasa.keys.map((String key) {
                  return new CheckboxListTile(
                      title: new Text(key),
                      value: valueJasa[key],
                      onChanged: (bool value) {
                        setState(() {
                          valueJasa[key] = value;
                          tmpJasa.clear();
                          valueJasa.forEach((key, value) {
                            if (value) {
                              tmpJasa.add(Jasa('"$key"', value));
                            }
                          });
                        });
                        // print(key);
                      });
                }).toList(),
              ),
              if (isCheck == true)
                Text("Pilih minimal satu",
                    style: TextStyle(color: Colors.red, fontSize: 12)),
              SizedBox(height: 15),
              Row(
                children: [
                  Text("Gaya Desain  ", style: blackFontStyle3),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StyleInfo()));
                    },
                    child:
                        Icon(Icons.info_outline, size: 18, color: Colors.amber),
                  )
                ],
              ),
              Container(
                child: DropdownButtonFormField(
                    value: selectedDesign,
                    items: generatedDesigns(designs),
                    hint: Text("Pilih salah satu"),
                    isExpanded: true,
                    onChanged: (item) {
                      setState(() {
                        selectedDesign = item;
                      });
                    },
                    validator: (value) =>
                        value == null ? "Pilih salah satu" : null),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Panjang", style: blackFontStyle3),
                        TextFormField(
                          validator: Validations.emptyValidation,
                          controller: _panjang,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Lebar", style: blackFontStyle3),
                        TextFormField(
                          validator: Validations.emptyValidation,
                          controller: _lebar,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              Text("Luas Ruangan (m2)", style: blackFontStyle3),
              TextFormField(
                controller: _luas,
                keyboardType: TextInputType.number,
                readOnly: true,
              ),
              SizedBox(height: 15),
              Text("Estimasi Anggaran (Mulai)", style: blackFontStyle3),
              Row(
                children: [
                  Text("Rp  "),
                  Expanded(
                    child: TextFormField(
                      validator: Validations.emptyValidation,
                      controller: _budgetFrom,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text("Estimasi Anggaran (Sampai)", style: blackFontStyle3),
              Row(
                children: [
                  Text("Rp  "),
                  Expanded(
                    child: TextFormField(
                      validator: Validations.emptyValidation,
                      controller: _budgetTo,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                FocusScope.of(context).unfocus();
                if (tmpJasa.length == 0) {
                  setState(() {
                    isCheck = true;
                  });
                } else {
                  var checkbox = tmpJasa.toString();
                  var desain =
                      checkbox.contains("Desain 2D / 3D") == true ? 1 : 0;
                  var rab = checkbox.contains("Rencana Anggaran Biaya") == true
                      ? 1
                      : 0;
                  // var kontraktor = checkbox.contains("Kontraktor") == true ? 1 : 0;
                  widget.form.budgetFrom = int.parse(_budgetFrom.text);
                  widget.form.budgetTo = int.parse(_budgetTo.text);
                  widget.form.panjang = double.parse(_panjang.text);
                  widget.form.lebar = double.parse(_lebar.text);
                  widget.form.desain = desain.toString();
                  widget.form.rab = rab.toString();
                  // widget.form.kontraktor = kontraktor.toString();
                  widget.form.style = selectedDesign.toString();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SecondScreen(
                              form: widget.form,
                              alamat: _dataalamat,
                              telepon: _datatelepon)));
                }
              }
              // else if (tmpJasa.length == 0) {
              //   setState(() {
              //     isCheck = true;
              //   });
              // }
              // else {
              //   setState(() {
              //     isCheck = false;
              //   });
              // }
            },
            child: Text("Selanjutnya"),
            style: ElevatedButton.styleFrom(primary: Colors.amber),
          ),
        ),
      ),
    );
  }
  // void itemChange(bool val, int index) {
  //   setState(() {
  //     jasa[index].isCheck = val;
  //     jasa.forEach((element) {
  //       if (element.isCheck == true) {
  //         tmpJasa.add(element.title);
  //         isCheck = true;
  //       }
  //     });
  //   });
  // }
}

class Property {
  String name;
  Property(this.name);
}

class DesignStyle {
  String designName;
  DesignStyle(this.designName);

  @override
  String toString() {
    return '$designName';
  }
}

class Jasa {
  String title;
  bool isCheck;

  Jasa(this.title, this.isCheck);

  @override
  String toString() {
    return '$title';
  }
}
