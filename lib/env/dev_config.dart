import 'base_config.dart';

class DevConfig implements BaseConfig {

  @override
  String get apiHost => "http://51.20.12.7:8080/api/";

  @override
  bool get httpLogs => true;

  @override
  String get apiVersion => "";

  @override
  String get apiTechnicianHost => "http://51.20.12.7:8080/api/";

}