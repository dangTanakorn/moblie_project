class Untrees {
  final int utid;
  final int uid;
  final String name;
  final double circumference;
  final double height;
  final int age;
  final double credit;

  Untrees(
      {required this.utid,
      required this.uid,
      required this.name,
      required this.circumference,
      required this.height,
      required this.age,
      required this.credit});

  factory Untrees.fromJson(Map<String, dynamic> json) {
    return Untrees(
        utid: json['utid'],
        uid: json['uid'],
        name: json['name'],
        circumference: json['circumference'],
        height: json['height'],
        age: json['age'],
        credit: json['credit']);
  }
}
