abstract class Repository<T> {
  Future<List<T>> getAll();
  Future<List<T>> getWithFilter({queryParams});
}
