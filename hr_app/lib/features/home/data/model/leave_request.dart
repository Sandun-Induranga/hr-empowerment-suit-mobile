class LeaveRequest{
  String userId;
  String reason;
  int dayCount;
  String status;
  DateTime date;

  LeaveRequest({
    required this.userId,
    required this.reason,
    required this.dayCount,
    required this.status,
    required this.date
  });

  factory LeaveRequest.fromJson(Map<String, dynamic> json){
    return LeaveRequest(
      userId: json['user_id'],
      reason: json['reason'],
      dayCount: json['day_count'],
      status: json['status'],
      date: DateTime.parse(json['date'])
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'user_id': userId,
      'reason': reason,
      'day_count': dayCount,
      'status': status,
      'date': date.toIso8601String()
    };
  }
}
