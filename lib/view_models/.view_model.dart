abstract class ViewModel<T> {
  List<T> list = [];
  String errorMsg = "";
  bool isLoading = false;

  Future<void> fetchData();
  Future<void> fetchDataWithQuery(queryParams);
}
