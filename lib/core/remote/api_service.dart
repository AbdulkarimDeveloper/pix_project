import 'dart:convert';

import 'package:pixa_project/core/remote/dio_instace.dart';
import 'package:pixa_project/modules/models/pix_data.dart';
import 'package:pixa_project/utils/constants.dart';

class ApiService {
  Future<List<Hit>> fetchImages({required int page, int perPage = 20}) async {
    final dio = DioInstance.i.instnace;
    final response = await dio
        .get(
          Constants.baseUrl,
          queryParameters: {
            'key': Constants.pixKey,
            'page': page,
            'per_page': perPage,
          },
        )
        .timeout(Constants.durationRequest);

    print('datadata: ${response.statusCode}');
    final data = PixData.fromJson(jsonDecode(response.data!));
    print('datadata: ${data}');

    return data.hits;
  }
}
