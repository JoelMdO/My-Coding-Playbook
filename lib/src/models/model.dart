class Data {
  final int? id;
  final String? section;
  final String? subject;
  final String? code;
  final String? description;
  final String? error;

  Data(
      {this.section,
      this.subject,
      this.code,
      this.description,
      this.id,
      this.error});

  //crea mapa a partir del objeto
  Map<String, dynamic> toMap() {
    return {
      'DataID': id,
      'Section': section,
      'Subject': subject,
      'Code': code,
      'Description': description,
      'Error': error
    };
  }

  //crea un objeto a partir del mapa
  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      id: map['DataID'],
      section: map['Section'],
      subject: map['Subject'],
      code: map['Code'],
      description: map['Description'],
      error: map['Error'],
    );
  }
}
