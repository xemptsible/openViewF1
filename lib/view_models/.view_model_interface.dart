abstract class IViewModel {
  Future<void> fetchData();
  Future<void> fetchDataWithQuery(queryParams);
}