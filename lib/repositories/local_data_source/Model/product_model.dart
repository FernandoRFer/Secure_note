class ProductModel {
  int? id;
  int? idUsuario;
  String produto;
  String descricao;

  ProductModel({
    this.id,
    this.idUsuario,
    required this.produto,
    required this.descricao,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["Id"],
      idUsuario: json["IdUsuario"],
      produto: json["Produto"],
      descricao: json["Descricao"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['IdUsuario'] = idUsuario;
    data['Produtos'] = produto;
    data['Senha'] = descricao;

    return data;
  }
}
