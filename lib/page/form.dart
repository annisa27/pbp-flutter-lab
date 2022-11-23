import 'package:counter_7/main.dart';
import 'package:counter_7/page/data_budget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:counter_7/widgets/drawer.dart';
import '../model/global.dart' as globals;

class MyBudgetFormPage extends StatefulWidget {
  const MyBudgetFormPage({super.key});

  @override
  State<MyBudgetFormPage> createState() => _TambahBudgetPageState();
}

class Budget {
  late String judul;
  late int nominal;
  late String jenisBudget;
  late DateTime date;

  Budget(
      {required this.judul, required this.nominal, required this.jenisBudget, required this.date});
}

class _TambahBudgetPageState extends State<MyBudgetFormPage> {
  final _formKey = GlobalKey<FormState>();
  String? _judul;
  int? nominal;
  String? jenisBudget;
  List<String> listJenisBudget = ['Pemasukan', 'Pengeluaran'];
  DateTime date = DateTime.now();

  onPressed(BuildContext context) {
    var data =
        Budget(judul: _judul!, nominal: nominal!, jenisBudget: jenisBudget!, date: date);
    globals.budgets.add(data);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyDataBudgetPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Budget'),
      ),
      drawer: const DrawerApp(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Contoh: Bayar UKT/Fee Project",
                      labelText: "Judul",
                       // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.account_balance_wallet),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        _judul = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _judul = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Judul tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Contoh: 10000",
                      labelText: "Nominal",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.attach_money),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        if (value != '') {
                          nominal = int.parse(value!);
                        }
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        if (value != '') {
                          nominal = int.parse(value!);
                        }
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Nominal tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:const EdgeInsets.all(8.0),
                  child: ListTile(

                    title: Text(date.toString()),
                    // make date to center
                    trailing: const Icon(Icons.keyboard_arrow_down),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != date)
                        setState(() {
                          date = picked;
                        });
                    },

                  ),
                )
                ,
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: jenisBudget,
                    icon: const Icon(Icons.arrow_drop_down),
                    items: listJenisBudget.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        jenisBudget = newValue!;
                      });
                    },
                    hint: Container(
                      width: 150, //and here
                      child: const Text(
                        "Pilih Jenis",
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.all(16.0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.center),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (jenisBudget == null || jenisBudget == '') {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 20,
                                child: Container(
                                  child: ListView(
                                    padding: const EdgeInsets.only(
                                        top: 60, bottom: 60),
                                    shrinkWrap: true,
                                    children: <Widget>[
                                      const Center(
                                          child: Text(
                                              'Jenis tidak boleh kosong')),
                                      const SizedBox(width: 60),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Kembali'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          onPressed(context);
                        }
                      }
                    },
                    child: const Text(
                      "Simpan",
                      style: TextStyle(color: Colors.white )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}