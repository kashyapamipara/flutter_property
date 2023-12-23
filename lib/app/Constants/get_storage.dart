import 'package:get_storage/get_storage.dart';

final getStorage = GetStorage();

void setData(String key, dynamic value) => getStorage.write(key, value);

int? getInt(String key) => getStorage.read(key);

String? getString(String key) => getStorage.read(key);

bool? getBool(String key) => getStorage.read(key);

double? getDouble(String key) => getStorage.read(key);

dynamic getData(String key) => getStorage.read(key);

void clearData() async => getStorage.erase();
