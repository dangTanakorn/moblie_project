class Untrees {
  final int utid;
  final int uid;
  final int id;
  final String name;
  final double circumference;
  final double height;
  final int age;
  final double credit;

  Untrees(
      {required this.utid,
      required this.uid,
      required this.id,
      required this.name,
      required this.circumference,
      required this.height,
      required this.age,
      required this.credit});

  factory Untrees.fromJson(Map<String, dynamic> json) {
    return Untrees(
        utid: json['utid'],
        uid: json['uid'],
        id: json['id'],
        name: json['name'],
        circumference: json['circumference'],
        height: json['height'],
        age: json['age'],
        credit: json['credit']);
  }
}
