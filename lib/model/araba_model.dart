// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);


import 'dart:convert';

List<Arabalar> welcomeFromJson(String str) => List<Arabalar>.from(json.decode(str).map((x) => Arabalar.fromJson(x)));

String welcomeToJson(List<Arabalar> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Arabalar {
    Arabalar({
        required this.arabaAdi,
        required this.ulke,
        required this.kurulusYil,
        required this.model,
    });

    final String arabaAdi;
    final String ulke;
    final String kurulusYil;
    final List<ArabaModeller> model;

    factory Arabalar.fromJson(Map<String, dynamic> jsonVerisi) => Arabalar(
        arabaAdi: jsonVerisi["araba_adi"],
        ulke: jsonVerisi["ulke"],
        kurulusYil: jsonVerisi["kurulus_yil"],
        model: List<ArabaModeller>.from(jsonVerisi["model"].map((x) => ArabaModeller.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "araba_adi": arabaAdi,
        "ulke": ulke,
        "kurulus_yil": kurulusYil,
        "model": List<dynamic>.from(model.map((x) => x.toJson())),
    };
}

class ArabaModeller {
    ArabaModeller({
        required this.modelAdi,
        required this.fiyat,
        required this.benzinli,
    });

    final String modelAdi;
    final int fiyat;
    final bool benzinli;

    factory ArabaModeller.fromJson(Map<String, dynamic> json) => ArabaModeller(
        modelAdi: json["model_adi"],
        fiyat: json["fiyat"],
        benzinli: json["benzinli"],
    );

    Map<String, dynamic> toJson() => {
        "model_adi": modelAdi,
        "fiyat": fiyat,
        "benzinli": benzinli,
    };
}
