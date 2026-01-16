import 'package:hive/hive.dart';
part 'Person.g.dart';

// mỗi class nếu ghi vào local thì phải có HiveType (typeId là độc nhất)
// flutter pub run build_runner build để build lấy adapter
// flutter pub run build_runner build --delete-conflicting-outputs để fix bug khi build lại nếu lần build trước bị lỗi

@HiveType(typeId: 0)
class Person {

  //đánh index
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int age;

  Person(this.id, this.name, this.age);

}
