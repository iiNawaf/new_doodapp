class LiveChatReports{
  String senderID;
  String senderUsername;
  String message;
  String reportTime;
  String status; //active, blocked

  LiveChatReports({this.message, this.senderUsername, this.senderID, this.reportTime, this.status});
}

class CommunityChatReports{
  String communityID;
  String senderID;
  String senderUsername;
  String message;
  String reportTime;
  String status; //active, blocked

  CommunityChatReports({this.message, this.senderUsername, this.senderID, this.reportTime, this.status, this.communityID});
}