import 'dart:async';
import 'package:d3_season_journey/model/season_journey_model.dart';
import 'package:get/get_connect/connect.dart';

class ApiService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://api.jebstern.com/';
  }

  Future<SeasonJourneyModel> getSchema() async {
    Response<dynamic> response = await get('d3-season-journey');
    return SeasonJourneyModel.fromJson(response.body);
  }
}
