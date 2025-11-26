
import '../../meeting/model/TableMeetingsModel.dart';


class HomeModelResponse {
  final bool status;
  final List<TableMeetingsModel> data;
  final String? message;

  HomeModelResponse({required this.status, required this.data,this.message});

  factory HomeModelResponse.fromJson(Map<String, dynamic> json) {
    return HomeModelResponse(
      status: json['success'],
      data: json.containsKey('data') ?(json['data'] as List).map((item) => TableMeetingsModel.fromJson(item)).toList():[],
      message: json.containsKey('message') ? json['message'] : null,
    );
  }
}

class Data {

  final List<TableMeetingsModel> brands;

  Data({

    required this.brands,

  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(

      brands: (json['brands'] as List).map((item) => TableMeetingsModel.fromJson(item)).toList(),

    );
  }
}





