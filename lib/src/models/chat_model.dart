/// A placeholder class that represents an entity or model.
class Chat {
  const Chat(this.id, this.title, this.logo, this.picture, this.chatName);

  final int id;
  final String title;
  final String logo;
  final String? picture;
  final String? chatName;

  // Convert Chat to a map for serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'logo': logo,
      'picture': picture,
      'chatName': chatName,
    };
  }

  // Create a Chat from a map for deserialization
  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      map['id'] as int,
      map['title'] as String,
      map['logo'] as String,
      map['picture'] as String?,
      map['chatName'] as String?,
    );
  }
}
