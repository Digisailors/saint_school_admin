import '../models/response.dart';

abstract class crud {
  Future<Result> add();
  Future<Result> change();
  Future<Result> delete();
}
