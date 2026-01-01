class MatchModel {
  final String team1;
  final String team2;
  final int team1Score;
  final int team2Score;
  final bool isRunning;
  final String winner;

  MatchModel({
    required this.team2,
    required this.team1Score,
    required this.team2Score,
    required this.isRunning,
    required this.winner,
    required this.team1,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      team2: json["team_2"],
      team1Score: json["team_1_score"],
      team2Score: json["team_2_score"],
      isRunning: json["isRunning"],
      winner: json["winner_team"],
      team1: json["team_1"],
    );
  }
}
