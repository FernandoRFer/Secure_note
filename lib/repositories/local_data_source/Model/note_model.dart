class NoteModel {
  int? id;
  int? idUsuario;
  String title;
  String note;

  NoteModel({
    this.id,
    this.idUsuario,
    required this.title,
    required this.note,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json["Id"],
      idUsuario: json["IdUsuario"],
      title: json["title"] ?? '',
      note: json["note"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['IdUsuario'] = idUsuario;
    data['title'] = title;
    data['note'] = note;

    return data;
  }
}
