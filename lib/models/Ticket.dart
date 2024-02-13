class Ticket {
  String name;
  String personName;
  String companyId;
  bool doneStageBoolean;
  bool reopenStageBoolean;
  bool cancelStageBoolean;
  bool closedStageBoolean;
  bool active;
  String emailSubject;
  bool isFastTrack;
  double progress;


  Ticket({
    required this.name,
    required this.personName,
    required this.companyId,
    required this.doneStageBoolean,
    required this.reopenStageBoolean,
    required this.cancelStageBoolean,
    required this.closedStageBoolean,
    required this.active,
    required this.emailSubject,
    required this.isFastTrack,
    required this.progress,
  });

    Map<String, dynamic> toJson() {
    return {
      "name": name,
      "person_name": personName,
      "company_id": companyId,
      "done_stage_boolean": doneStageBoolean,
      "reopen_stage_boolean": reopenStageBoolean,
      "cancel_stage_boolean": cancelStageBoolean,
      "closed_stage_boolean": closedStageBoolean,
      "active": active,
      "email_subject": emailSubject,
      "is_fast_track": isFastTrack,
      "progress": progress,
    };
  }

}
