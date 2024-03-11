class User {
  final String login;
  final int id;
  final String nodeId;
  final String avatarUrl;

  User({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        login: json['login'] as String,
        id: json['id'] as int,
        nodeId: json['node_id'] as String,
        avatarUrl: json['avatar_url'] as String,
      );
}
