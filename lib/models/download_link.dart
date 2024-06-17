class DownloadLink {
  final int id;
  final int movieId;
  final String name;
  final String size;
  final String quality;
  final int linkOrder;
  final String url;
  final String type;
  final int status;
  final int skipAvailable;
  final String introStart;
  final String introEnd;
  final int endCreditsMarker;
  final int linkType;
  final String drmUuid;
  final String drmLicenseUri;

  DownloadLink({
    required this.id,
    required this.movieId,
    required this.name,
    required this.size,
    required this.quality,
    required this.linkOrder,
    required this.url,
    required this.type,
    required this.status,
    required this.skipAvailable,
    required this.introStart,
    required this.introEnd,
    required this.endCreditsMarker,
    required this.linkType,
    required this.drmUuid,
    required this.drmLicenseUri,
  });

  factory DownloadLink.fromJson(Map<String, dynamic> json) {
    return DownloadLink(
      id: int.parse(json['id']),
      movieId: int.parse(json['movie_id']),
      name: json['name'],
      size: json['size'],
      quality: json['quality'],
      linkOrder: int.parse(json['link_order']),
      url: json['url'],
      type: json['type'],
      status: int.parse(json['status']),
      skipAvailable: int.parse(json['skip_available']),
      introStart: json['intro_start'],
      introEnd: json['intro_end'],
      endCreditsMarker: int.parse(json['end_credits_marker']),
      linkType: int.parse(json['link_type']),
      drmUuid: json['drm_uuid'],
      drmLicenseUri: json['drm_license_uri'],
    );
  }
}
