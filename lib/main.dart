 
import 'package:flutter/material.dart';
import 'package:flutter_not_sepeti/models/kategori.dart';
import 'package:flutter_not_sepeti/not_detay.dart';
import 'package:flutter_not_sepeti/utils/database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NotListesi());
  }
}

class NotListesi extends StatelessWidget {
  DatabaseHelper databaseHelper = DatabaseHelper();
  var _scaffold = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffold,
        appBar: AppBar(
          title: Center(
            child: Text("Not Sepeti"),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              heroTag: "notEkle",
              onPressed: () => _detaySayfasinaGit(context),
              child: Icon(Icons.add_circle),
              mini: true,
              tooltip: "Not Ekle",
            ),
            FloatingActionButton(
                heroTag: "kategoriEkle",
                onPressed: () {
                  kategoriEkleDialog(context);
                },
                child: Icon(Icons.add),
                tooltip: "Kategori Ekle"),
          ],
        ));
  }

  void kategoriEkleDialog(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    String yeniKategoriAdi;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              "Kategori Ekle",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            children: <Widget>[
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onSaved: (yeniDeger) {
                      yeniKategoriAdi = yeniDeger;
                    },
                    decoration: InputDecoration(
                        labelText: "Kategori Adı",
                        border: OutlineInputBorder()),
                    validator: (gelenKategoriAdi) {
                      if (gelenKategoriAdi.length < 3) {
                        return "En az 3 karakter giriniz";
                      }
                    },
                  ),
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Vazgeç"),
                    color: Colors.red,
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        databaseHelper
                            .kategoriEkle(Kategori(yeniKategoriAdi))
                            .then((kategoriID) {
                          if (kategoriID > 0) {
                            _scaffold.currentState.showSnackBar(SnackBar(
                              content: Text("Kategori Eklendi"),
                              duration: Duration(seconds: 2),
                            ));
                            Navigator.pop(context);
                          }
                        });
                      }
                    },
                    child: Text("Kaydet"),
                    color: Colors.green,
                  ),
                ],
              )
            ],
          );
        });
  }

  _detaySayfasinaGit(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => NotDetay(baslik: "Yeni Not")));
  }
}
