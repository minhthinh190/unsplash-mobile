// Unsplash API 
class UnsplashPhoto {
  User author;
  Urls source;

  UnsplashPhoto({this.author, this.source});

  factory UnsplashPhoto.fromMap(Map<String, dynamic> jsonData) {
    return UnsplashPhoto(
      author: User.fromMap(jsonData['user']),
      source: Urls.fromMap(jsonData['urls']),
    );
  }
}

class User {
  final String id;
  final String name;
  final String profileImage;

  User({this.id, this.name, this.profileImage});

  factory User.fromMap(Map<String, dynamic> jsonData) {
    return User(
      id: jsonData['id'],
      name: jsonData['name'],
      profileImage: jsonData['profile_image']['medium'],
    );
  }
}

class Urls {
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;

  Urls({this.raw, this.full, this.regular, this.small, this.thumb});

  factory Urls.fromMap(Map<String, dynamic> jsonData) {
    return Urls(
      raw: jsonData['raw'],
      full: jsonData['full'],
      regular: jsonData['regular'],
      small: jsonData['small'],
      thumb: jsonData['thumb'],
    );
  }
}