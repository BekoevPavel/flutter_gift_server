import 'package:flutter_gift_server/data/wishs_model_datasourse.dart';
import 'package:flutter_gift_server/domain/entity/wishyou_entity.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class DateController {
  RxList wishs = [].obs;
  var textGetX = 0.obs;

  static DateController? _instance;
  DateController._();

  static DateController getInstance() {
    return _instance ??= DateController._();
  }

  late WishsFirebaseDataSourse wishToFireBace;
}
