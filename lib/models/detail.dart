class Detail {
  late String status;
  late int statusCode;
  late List<Chapter> chapter;

  Detail({required this.status, required this.statusCode, required this.chapter});

  Detail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      chapter = <Chapter>[];
      json['data'].forEach((v) {
        chapter.add(new Chapter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    if (this.chapter != null) {
      data['data'] = this.chapter.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chapter {
  late int chId;
  late int courseId;
  late String chTitle;
  late String chDateadd;
  late String chTimetotal;
  late int chView;
  late String chUrl;

  Chapter(
      {required this.chId,
        required this.courseId,
        required this.chTitle,
        required this.chDateadd,
        required this.chTimetotal,
        required this.chView,
        required this.chUrl});

  Chapter.fromJson(Map<String, dynamic> json) {
    chId = json['ch_id'];
    courseId = json['course_id'];
    chTitle = json['ch_title'];
    chDateadd = json['ch_dateadd'];
    chTimetotal = json['ch_timetotal'];
    chView = json['ch_view'];
    chUrl = json['ch_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ch_id'] = this.chId;
    data['course_id'] = this.courseId;
    data['ch_title'] = this.chTitle;
    data['ch_dateadd'] = this.chDateadd;
    data['ch_timetotal'] = this.chTimetotal;
    data['ch_view'] = this.chView;
    data['ch_url'] = this.chUrl;
    return data;
  }
}
