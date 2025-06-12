class ApiUrl {
  static const String root = 'https://fakestoreapi.com/';
  static const String getALLProduct = '${root}products';

  static String getSingleProduct(int id) {
    return '${root}products/$id';
  }
}
