class Planta {

  static const TABLE_NAME = "planta";

  static const FIELD_ID = "id";
  static const FIELD_NOME = "nome";
  static const FIELD_DESCRICAO = "descricao";
  static const FIELD_PORCENTAGEM = "porcentagem";
  static const FIELD_FOTO = "foto";

  int? id;
  String nome;
  String descricao;
  String porcentagemIdentificacao;
  String? fotoPath;

  Planta({
    this.id,
    required this.nome,
    required this.descricao,
    required this.porcentagemIdentificacao,
    this.fotoPath,
  });

  Map<String, dynamic> toMap(){
    return {
      FIELD_ID: id,
      FIELD_NOME: nome,
      FIELD_DESCRICAO: descricao,
      FIELD_PORCENTAGEM: porcentagemIdentificacao,
      FIELD_FOTO: fotoPath,
    };
  }

  factory Planta.fromMap(Map<String, dynamic> map){
    return Planta(
      id: map[FIELD_ID],
      nome: map[FIELD_NOME],
      descricao: map[FIELD_DESCRICAO],
      porcentagemIdentificacao: map[FIELD_PORCENTAGEM],
      fotoPath: map[FIELD_FOTO],
    );
  }
}