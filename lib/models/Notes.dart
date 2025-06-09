class Note {
  final int? id;
  final String title;
  final String description;
  final String? image;
  final String createdDate;
  final String updatedDate;

  Note({
    this.id,
    required this.title,
    required this.description,
    this.image,
    required this.createdDate,
    required this.updatedDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'created_date': createdDate,
      'updated_date': updatedDate,
    };
  }

  Map<String, dynamic> toMapForInsert() {
    return {
      'title': title,
      'description': description,
      'image': image,
      'created_date': createdDate,
      'updated_date': updatedDate,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      image: map['image'],
      createdDate: map['created_date'],
      updatedDate: map['updated_date'],
    );
  }
}
