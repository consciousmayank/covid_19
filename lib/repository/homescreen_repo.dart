import 'package:covid19graphs/models/history.dart';
import 'package:covid19graphs/models/latest_data.dart';
import 'package:covid19graphs/repository/repository.dart';

class HomeScreenRepo{
  MainRepository _client;

  HomeScreenRepo(){
    _client = MainRepository();
  }

  Future<LatestStats> getCaseCounts() async {
    return _client.getLatestData();
  }

  
  Future<History> getHistory() async {
    return _client.getHistoryData();
  }


}