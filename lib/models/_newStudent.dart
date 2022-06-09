class Student {
  Student({
    required this.ic,
    required this.studentClass,
    required this.section,
    required this.name,
    required this.parent,
    this.inQueue,
    this.queuedTime,
  });

  String ic;
  String studentClass;
  String section;
  String name;
  List<String> parent;
  bool? inQueue;
  DateTime? queuedTime;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        ic: json["ic"],
        studentClass: json["class"],
        section: json["section"],
        name: json["name"],
        parent: List<String>.from(json["parent"].map((x) => x)),
        inQueue: json["inQueue"],
        queuedTime: json["queuedTime"]?.toDate(),
      );

  Map<String, dynamic> toJson() => {
        "ic": ic,
        "class": studentClass,
        "section": section,
        "name": name,
        "parent": List<dynamic>.from(parent.map((x) => x)),
        "queuedTime": queuedTime,
        "inQueue": inQueue,
      };
}
