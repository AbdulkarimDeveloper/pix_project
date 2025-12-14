class PixData {
  PixData({required this.total, required this.totalHits, required this.hits});

  final int? total;
  final int? totalHits;
  final List<Hit> hits;

  PixData copyWith({int? total, int? totalHits, List<Hit>? hits}) {
    return PixData(
      total: total ?? this.total,
      totalHits: totalHits ?? this.totalHits,
      hits: hits ?? this.hits,
    );
  }

  factory PixData.fromJson(Map<String, dynamic> json) {
    return PixData(
      total: json["total"],
      totalHits: json["totalHits"],
      hits: json["hits"] == null
          ? []
          : List<Hit>.from(json["hits"]!.map((x) => Hit.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "total": total,
    "totalHits": totalHits,
    "hits": hits.map((x) => x.toJson()).toList(),
  };
}

class Hit {
  Hit({
    required this.id,
    required this.pageUrl,
    required this.type,
    required this.tags,
    required this.previewUrl,
    required this.previewWidth,
    required this.previewHeight,
    required this.webformatUrl,
    required this.webformatWidth,
    required this.webformatHeight,
    required this.largeImageUrl,
    required this.fullHdurl,
    required this.imageUrl,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageSize,
    required this.views,
    required this.downloads,
    required this.likes,
    required this.comments,
    required this.userId,
    required this.user,
    required this.userImageUrl,
  });

  final int? id;
  final String? pageUrl;
  final String? type;
  final String? tags;
  final String? previewUrl;
  final int? previewWidth;
  final int? previewHeight;
  final String? webformatUrl;
  final int? webformatWidth;
  final int? webformatHeight;
  final String? largeImageUrl;
  final String? fullHdurl;
  final String? imageUrl;
  final int? imageWidth;
  final int? imageHeight;
  final int? imageSize;
  final int? views;
  final int? downloads;
  final int? likes;
  final int? comments;
  final int? userId;
  final String? user;
  final String? userImageUrl;

  Hit copyWith({
    int? id,
    String? pageUrl,
    String? type,
    String? tags,
    String? previewUrl,
    int? previewWidth,
    int? previewHeight,
    String? webformatUrl,
    int? webformatWidth,
    int? webformatHeight,
    String? largeImageUrl,
    String? fullHdurl,
    String? imageUrl,
    int? imageWidth,
    int? imageHeight,
    int? imageSize,
    int? views,
    int? downloads,
    int? likes,
    int? comments,
    int? userId,
    String? user,
    String? userImageUrl,
  }) {
    return Hit(
      id: id ?? this.id,
      pageUrl: pageUrl ?? this.pageUrl,
      type: type ?? this.type,
      tags: tags ?? this.tags,
      previewUrl: previewUrl ?? this.previewUrl,
      previewWidth: previewWidth ?? this.previewWidth,
      previewHeight: previewHeight ?? this.previewHeight,
      webformatUrl: webformatUrl ?? this.webformatUrl,
      webformatWidth: webformatWidth ?? this.webformatWidth,
      webformatHeight: webformatHeight ?? this.webformatHeight,
      largeImageUrl: largeImageUrl ?? this.largeImageUrl,
      fullHdurl: fullHdurl ?? this.fullHdurl,
      imageUrl: imageUrl ?? this.imageUrl,
      imageWidth: imageWidth ?? this.imageWidth,
      imageHeight: imageHeight ?? this.imageHeight,
      imageSize: imageSize ?? this.imageSize,
      views: views ?? this.views,
      downloads: downloads ?? this.downloads,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      userId: userId ?? this.userId,
      user: user ?? this.user,
      userImageUrl: userImageUrl ?? this.userImageUrl,
    );
  }

  factory Hit.fromJson(Map<String, dynamic> json) {
    return Hit(
      id: json["id"],
      pageUrl: json["pageURL"],
      type: json["type"],
      tags: json["tags"],
      previewUrl: json["previewURL"],
      previewWidth: json["previewWidth"],
      previewHeight: json["previewHeight"],
      webformatUrl: json["webformatURL"],
      webformatWidth: json["webformatWidth"],
      webformatHeight: json["webformatHeight"],
      largeImageUrl: json["largeImageURL"],
      fullHdurl: json["fullHDURL"],
      imageUrl: json["imageURL"],
      imageWidth: json["imageWidth"],
      imageHeight: json["imageHeight"],
      imageSize: json["imageSize"],
      views: json["views"],
      downloads: json["downloads"],
      likes: json["likes"],
      comments: json["comments"],
      userId: json["user_id"],
      user: json["user"],
      userImageUrl: json["userImageURL"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "pageURL": pageUrl,
    "type": type,
    "tags": tags,
    "previewURL": previewUrl,
    "previewWidth": previewWidth,
    "previewHeight": previewHeight,
    "webformatURL": webformatUrl,
    "webformatWidth": webformatWidth,
    "webformatHeight": webformatHeight,
    "largeImageURL": largeImageUrl,
    "fullHDURL": fullHdurl,
    "imageURL": imageUrl,
    "imageWidth": imageWidth,
    "imageHeight": imageHeight,
    "imageSize": imageSize,
    "views": views,
    "downloads": downloads,
    "likes": likes,
    "comments": comments,
    "user_id": userId,
    "user": user,
    "userImageURL": userImageUrl,
  };
}
