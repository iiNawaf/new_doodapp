class Dood {
  final String id;
  String? senderID;
  String? content;
  dynamic sendTime;
  bool? isReported;

  Dood({
    required this.id,
    this.content,
    this.senderID,
    this.sendTime,
    this.isReported,
  });
}
