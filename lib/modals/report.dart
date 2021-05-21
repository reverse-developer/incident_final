class Report {
  final String id;
  final String name;
  final String city;
  final String email;
  final String picture;
  final int minutes;
  final int hour;
  final DateTime time;
  final String description;

  Report(
      {this.id,
      this.name,
      this.picture,
      this.city,
      this.email,
      this.description,
      this.hour,
      this.minutes,
      this.time});

  factory Report.fromMap(Map data) => Report(
        id: data["id"],
        name: data["name"],
        picture: data["picture"],
        city: data["city"],
        email: data["email"],
        description: data["description"],
        hour: data["hour"],
        minutes: data["minutes"],
        time: data["time"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "picture": picture,
        "email": email,
        "description": description,
        "city": city,
        "hour": hour,
        "minutes": minutes,
        "time": time,
      };
}
