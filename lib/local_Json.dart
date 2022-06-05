import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_json_http/model/araba_model.dart';

class LocalJson extends StatefulWidget {
  const LocalJson({Key? key}) : super(key: key);

  @override
  State<LocalJson> createState() => _LocalJsonState();
}

class _LocalJsonState extends State<LocalJson> {
  late final Future<List<Arabalar>> _listeyiDoldur;
  String _title = "Http Json";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listeyiDoldur = arabalarJsonOku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (() {
        setState(() {
          _title = "Tıklama algılandı";
        });
      })),
      body: FutureBuilder<List<Arabalar>>(
        future: _listeyiDoldur,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Arabalar> arabaListesi = snapshot.data!;

            return ListView.builder(
                itemCount: arabaListesi.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(arabaListesi[index].arabaAdi.toString()),
                    subtitle: Text(arabaListesi[index].ulke.toString()),
                    leading: CircleAvatar(
                      child:
                          Text(arabaListesi[index].model[0].fiyat.toString()),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<List<Arabalar>> arabalarJsonOku() async {
    try {
      await Future.delayed(
        Duration(seconds: 1),
        /* () {
          return Future.error("bir hata ile karşılaşıldı.");
        }, */
      );

      String okunanStringDeger = await DefaultAssetBundle.of(context)
          .loadString("assets/arabalar.json");
      debugPrint(okunanStringDeger); // direk string olarak yazdirir..
      var jsonObject = jsonDecode(okunanStringDeger);
      debugPrint(jsonObject.toString()); // json formatında yazdırır..
      print("*****");

      List<Arabalar> tumArabalar =
          (jsonObject as List).map((e) => Arabalar.fromJson(e)).toList();

      print(tumArabalar.length.toString());
      print(tumArabalar[0].arabaAdi.toString());
      print(tumArabalar[0].model[1].fiyat.toString());

      return tumArabalar;
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }
}
