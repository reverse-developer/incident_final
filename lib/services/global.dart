import 'package:incident_report/modals/report.dart';
import 'package:incident_report/services/database.dart';

class Global {
  static final Map models = {
    Report: (data) => Report.fromMap(data),
  };

  static final Collection<Report> reportRef =
      Collection<Report>(path: "reports");
}
