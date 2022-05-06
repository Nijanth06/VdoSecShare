class VideoModel{
  String? videoName;
  String? downloadURL;

  VideoModel({this.videoName,this.downloadURL});

  factory VideoModel.fromMap(map) {
    return VideoModel(
      videoName: map['videoName'],
      downloadURL: map['downloadURL'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'videoName': videoName,
      'downloadURL': downloadURL,

    };
  }
}