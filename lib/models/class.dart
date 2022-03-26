class Class {
  Class({
    required this.section,
    required this.name,
  });

  String section;
  String name;

  factory Class.fromJson(Map<String, dynamic> json) => Class(
        section: json["section"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "section": section,
        "name": name,
      };
}
