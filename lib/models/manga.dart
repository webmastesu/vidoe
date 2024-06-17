class Manga {
  final String id;
  final String tmdbId;
  final String name;
  final String description;
  final String genres;
  final String releaseDate;
  final String poster;
  final String banner;
  final String youtubeTrailer;
  final bool downloadable;
  final int type;
  final int status;
  final int contentType;
  final String? customTag;

  Manga({
    required this.id,
    required this.tmdbId,
    required this.name,
    required this.description,
    required this.genres,
    required this.releaseDate,
    required this.poster,
    required this.banner,
    required this.youtubeTrailer,
    required this.downloadable,
    required this.type,
    required this.status,
    required this.contentType,
    this.customTag,
  });

  factory Manga.fromJson(Map<String, dynamic> json) {
    return Manga(
      id: json['id'].toString(),
      tmdbId: json['TMDB_ID'].toString(),
      name: json['name'],
      description: json['description'],
      genres: json['genres'],
      releaseDate: json['release_date'],
      poster: json['poster'],
      banner: json['banner'],
      youtubeTrailer: json['youtube_trailer'],
      downloadable: json['downloadable'] == "1",
      type: int.parse(json['type']),
      status: int.parse(json['status']),
      contentType: int.parse(json['content_type']),
      customTag: json['custom_tag'],
    );
  }
}
