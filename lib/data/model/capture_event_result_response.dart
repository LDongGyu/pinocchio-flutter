import 'package:flutter_sancle/data/model/ingredient.dart';

/// ingredientList : [{"name":"아크릴","percentage":35}, {"name":"폴리에스테르","percentage":25}, {"name":"캐시미어","percentage":20}, {"name":"면","percentage":10}, {"name":"실크","percentage":10}]
/// waterType : "WASHER_ABOUT_40_KR"
/// bleachType : "ALL_KR"
/// ironingType : "IRONING_140_160_KR"
/// dryType : "DRY_SUNNY_HANGER_KR"
/// dryCleaning : "DRY_CLEANING_OIL_KR"
/// clothesColor : "BEIGE"

class CaptureEventResultResponse {
  List<Ingredient> _ingredientList;
  String _waterType;
  String _bleachType;
  String _ironingType;
  String _dryType;
  String _dryCleaning;
  String _clothesColor;

  List<Ingredient> get ingredientList => _ingredientList;

  String get waterType => _waterType;

  String get bleachType => _bleachType;

  String get ironingType => _ironingType;

  String get dryType => _dryType;

  String get dryCleaning => _dryCleaning;

  String get clothesColor => _clothesColor;

  CaptureEventResultResponse(
      {List<Ingredient> ingredientList,
      String waterType,
      String bleachType,
      String ironingType,
      String dryType,
      String dryCleaning,
      String clothesColor}) {
    _ingredientList = ingredientList;
    _waterType = waterType;
    _bleachType = bleachType;
    _ironingType = ironingType;
    _dryType = dryType;
    _dryCleaning = dryCleaning;
    _clothesColor = clothesColor;
  }

  CaptureEventResultResponse.fromJson(dynamic json) {
    if (json["ingredientList"] != null) {
      _ingredientList = [];
      json["ingredientList"].forEach((v) {
        _ingredientList.add(Ingredient.fromJson(v));
      });
    }
    _waterType = json["waterType"];
    _bleachType = json["bleachType"];
    _ironingType = json["ironingType"];
    _dryType = json["dryType"];
    _dryCleaning = json["dryCleaning"];
    _clothesColor = json["clothesColor"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_ingredientList != null) {
      map["ingredientList"] = _ingredientList.map((v) => v.toJson()).toList();
    }
    map["waterType"] = _waterType;
    map["bleachType"] = _bleachType;
    map["ironingType"] = _ironingType;
    map["dryType"] = _dryType;
    map["dryCleaning"] = _dryCleaning;
    map["clothesColor"] = _clothesColor;
    return map;
  }
}
