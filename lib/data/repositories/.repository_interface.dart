abstract interface class IRepository<T> {
  Future<List<T>> getAll();
  Future<List<T>> getWithFilter({queryParams});
}
