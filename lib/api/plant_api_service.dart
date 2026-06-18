import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../model/identificacao_planta.dart';

class PlantApiService {

  static const String apiKey =
      "2b105lBsTJ0t2lghxzSprfU";

  Future<IdentificacaoPlanta?> identificarPlanta(
      File imagem) async {

    final uri = Uri.parse(
      "https://my-api.plantnet.org/v2/identify/all?api-key=$apiKey",
    );

    final request = http.MultipartRequest(
      "POST",
      uri,
    );

    request.files.add(
      await http.MultipartFile.fromPath(
        "images",
        imagem.path,
      ),
    );

    request.fields["organs"] = "leaf";

    final response = await request.send();

    if (response.statusCode != 200) {
      return null;
    }

    final responseString =
    await response.stream.bytesToString();

    final data =
    jsonDecode(responseString);

    if (data["results"] == null ||
        data["results"].isEmpty) {
      return null;
    }

    final resultado =
    data["results"][0];

    final nome =
    resultado["species"]
    ["scientificNameWithoutAuthor"];

    final score =
    resultado["score"];

    return IdentificacaoPlanta(
      nome: nome,
      descricao:
      "Identificação realizada pela API Pl@ntNet",
      porcentagem:
      "${(score * 100).toStringAsFixed(2)}%",
    );
  }
}