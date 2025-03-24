import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:projcetapp/Model/tree_model.dart';
import 'package:projcetapp/model/plot_model.dart';
import 'package:projcetapp/model/untree_model.dart';
import 'package:projcetapp/model/users_model.dart';

class JsonService {
  Future<Map<String, dynamic>> loadJson() async {
    String jsonString = await rootBundle.loadString('assets/data.json');
    return jsonDecode(jsonString);
  }

  // User
  Future<List<User>> getUsers() async {
    Map<String, dynamic> jsonData = await loadJson();
    return (jsonData['users'] as List)
        .map((user) => User.fromJson(user))
        .toList();
  }

  Future<User?> getUserById(int userId) async {
    List<User> allUsers = await getUsers();
    return allUsers.firstWhere(
      (user) => user.uid == userId,
    );
  }

  // Plot
  Future<List<Plot>> getPlots() async {
    Map<String, dynamic> jsonData = await loadJson();
    return (jsonData['plots'] as List)
        .map((plot) => Plot.fromJson(plot))
        .toList();
  }

  Future<List<Plot>> getPlotsByUser(int userId) async {
    List<Plot> allPlots = await getPlots();
    return allPlots.where((plot) => plot.uid == userId).toList();
  }

  Future<Plot?> getPlotByPid(int plotId) async {
    List<Plot> allPlot = await getPlots();
    return allPlot.firstWhere((plot) => plot.pid == plotId);
  }

  // Tree
  Future<List<Tree>> getTree() async {
    Map<String, dynamic> jsonData = await loadJson();
    return (jsonData['trees'] as List)
        .map((tree) => Tree.fromJson(tree))
        .toList();
  }

  Future<List<Tree>> getTreeByPlot(int plotId) async {
    List<Tree> allTrees = await getTree();
    return allTrees.where((tree) => tree.pid == plotId).toList();
  }

  Future<Tree?> getTreeByTid(int treeId) async {
    List<Tree> allTrees = await getTree();
    return allTrees.firstWhere((tree) => tree.tid == treeId);
  }

  // UnTree
  Future<List<Untrees>> getUnTrees() async {
    Map<String, dynamic> jsonData = await loadJson();
    return (jsonData['unassignedTrees'] as List)
        .map((untree) => Untrees.fromJson(untree))
        .toList();
  }

  Future<List<Untrees>> getUnTreeByUser(int userId) async {
    List<Untrees> allTrees = await getUnTrees();
    return allTrees.where((untree) => untree.uid == userId).toList();
  }

  Future<Untrees?> getUnTreeByUtid(int unTreeId) async {
    List<Untrees> allTrees = await getUnTrees();
    return allTrees.firstWhere((tree) => tree.utid == unTreeId);
  }
}
