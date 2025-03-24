class Plot {
  final int pid;
  final int uid;
  final String name;
  final double credit;

  Plot(
      {required this.pid,
      required this.uid,
      required this.name,
      required this.credit});

  factory Plot.fromJson(Map<String, dynamic> json) {
    return Plot(
        pid: json['pid'],
        uid: json['uid'],
        name: json['name'],
        credit: json['credit']);
  }
}
