import 'package:dio/dio.dart';
import 'package:mcs_bab_8/models/card_bridge_model.dart';

class CardApiService {
  Dio dio = Dio();
  String cardBridgeUrl = "http://10.174.175.181:50000"; // IP ADDRESS:PORT

  Future<CardBridgeModel> getUid() async {
    try {
      final response = await dio.get("$cardBridgeUrl/cards");
      return CardBridgeModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future deleteCard({required String idCard}) async {
    try {
      final response = await dio.delete("$cardBridgeUrl/card/delete/$idCard");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
