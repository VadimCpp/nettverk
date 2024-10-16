/// A placeholder class that represents an entity or model.
class SampleItem {
  const SampleItem(this.id, this.title, this.logo, this.picture);

  final int id;
  final String title;
  final String logo;
  final String? picture;

  // Convert SampleItem to a map for serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'logo': logo,
      'picture': picture,
    };
  }

  // Create a SampleItem from a map for deserialization
  factory SampleItem.fromMap(Map<String, dynamic> map) {
    return SampleItem(
      map['id'] as int,
      map['title'] as String,
      map['logo'] as String,
      map['picture'] as String?,
    );
  }
}
