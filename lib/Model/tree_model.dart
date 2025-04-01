class Tree {
  final int tid;
  final int pid;
  final int id;
  final String name;
  final double circumference;
  final double height;
  final int age;
  final double credit;

  Tree(
      {required this.tid,
      required this.pid,
      required this.id,
      required this.name,
      required this.circumference,
      required this.height,
      required this.age,
      required this.credit});

  factory Tree.fromJson(Map<String, dynamic> json) {
    return Tree(
        tid: json['tid'],
        pid: json['pid'],
        id: json['id'],
        name: json['name'],
        circumference: json['circumference'],
        height: json['height'],
        age: json['age'],
        credit: json['credit']);
  }
}
