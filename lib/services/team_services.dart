import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../model/team.dart';

class TeamService {
  static List<Team> teams = [];

  //get teams from API
  static Future<List<Team>> getTeams() async {
    try {
      final headers = {'Authorization': '03771ac5-18f5-4a65-b745-6f90cce9af61'};
      final url = Uri.parse('https://api.balldontlie.io/v1/teams');
      final response = await http.get(url, headers: headers);

      var jsonData = jsonDecode(response.body);

      for (var eachTeam in jsonData['data']) {
        final team = Team(
          id: eachTeam['id'],
          abbreviation: eachTeam['abbreviation'],
          city: eachTeam['city'],
        );
        teams.add(team);
      }
    } catch (e) {
      log("message", error: e.toString());
    }
    return teams;
  }
}
