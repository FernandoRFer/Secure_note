class NoteModel {
  int? id;
  int? idUsuario;
  String title;
  String note;
  bool invisibleMessage;

  NoteModel({
    this.id,
    this.idUsuario,
    required this.title,
    required this.note,
    this.invisibleMessage = true,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json["Id"],
      idUsuario: json["IdUsuario"],
      title: json["title"] ?? '',
      note: json["note"] ?? '',
      // invisibleMessage: json["invisibleMessage"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['IdUsuario'] = idUsuario;
    data['title'] = title;
    data['note'] = note;
    // data['invisibleMessage'] = invisibleMessage;

    return data;
  }
}
