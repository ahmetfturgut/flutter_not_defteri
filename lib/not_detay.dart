import 'package:flutter/material.dart';
import 'package:flutter_not_sepeti/models/kategori.dart';
import 'package:flutter_not_sepeti/utils/database_helper.dart';

class NotDetay extends StatefulWidget {
  String baslik;
  NotDetay({this.baslik});
  @override
  _NotDetayState createState() => _NotDetayState();
}

class _NotDetayState extends State<NotDetay> {
  var formKey = GlobalKey<FormState>();
  List<Kategori> tumKategoriler;
  DatabaseHelper databaseHelper;
  int kategoriID = 1;

  @override
  void initState() {
    super.initState();
    tumKategoriler = List<Kategori>();
    databaseHelper = DatabaseHelper();
    databaseHelper.kategorileriGetir().then((kategoriIcerebMapListesi) {
      for (Map okunanMap in kategoriIcerebMapListesi) {
        tumKategoriler.add(Kategori.fromMap(okunanMap));
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.baslik),
      ),
      body: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Container(
                child: DropdownButtonHideUnderline(
                    child: tumKategoriler.length <= 0
                        ? CircularProgressIndicator()
                        : DropdownButton<int>(
                            value: kategoriID,
                            items: kategoriItemtemleriOlustur(),
                            onChanged: (secilenKategoriID) {
                              setState(() {
                                kategoriID = secilenKategoriID;
                              });
                            })),
                padding: EdgeInsets.symmetric(vertical: 9, horizontal: 24),
                margin: EdgeInsets.all(19),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.redAccent, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              )
            ],
          )),
    );
  }

  List<DropdownMenuItem<int>> kategoriItemtemleriOlustur() {
    return tumKategoriler
        .map((kategori) => DropdownMenuItem<int>(
            value: kategori.kategoriID, child: Text(kategori.kategoriBaslik)))
        .toList();
  }
}
