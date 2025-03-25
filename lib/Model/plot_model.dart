class Plot {
  final int pid;
  final int uid;
  final String name;

  Plot({required this.pid, required this.uid, required this.name});

  factory Plot.fromJson(Map<String, dynamic> json) {
    return Plot(pid: json['pid'], uid: json['uid'], name: json['name']);
  }
}
