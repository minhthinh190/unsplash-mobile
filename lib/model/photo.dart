class Photo {
  final String photographer;
  final String photographer_url;
  final int photographer_id;
  Src src;

  Photo({
    this.src,
    this.photographer_url,
    this.photographer_id,
    this.photographer,
  });

  factory Photo.fromMap(Map<String, dynamic> jsonData) {
    return Photo(
      src: Src.fromMap(jsonData["src"]),
      photographer_url: jsonData["photographer_url"],
      photographer_id: jsonData["photographer_id"],
      photographer: jsonData["photographer"],
    );
  }
}

class Src {
  String original;
  String small;
  String portrait;

  Src({
    this.portrait,
    this.original,
    this.small,
  });

  factory Src.fromMap(Map<String, dynamic> jsonData) {
    return Src(
      portrait: jsonData["portrait"],
      original: jsonData["original"],
      small: jsonData["small"],
    );
  }
}
