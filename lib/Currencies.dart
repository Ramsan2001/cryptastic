import 'package:hive/hive.dart';

@HiveType(typeId: 0, adapterName: "myCurrencie")
class Currencie extends HiveObject{
  @HiveField(0)
  late String currencie;
  @HiveField(1)
  late double amount;
  @HiveField(2)
  late double value;
}