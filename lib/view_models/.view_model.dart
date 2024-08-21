abstract class ViewModel {
  Future<void> fetchData();
  Future<void> fetchDataWithQuery(queryParams);
}