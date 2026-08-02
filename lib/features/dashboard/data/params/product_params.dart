class ProductParams {
  final int id;
  ProductParams({required this.id});
}

class ProductListParams {
  final int limit;
  final int skip;

  ProductListParams({
    this.limit = 10,
    this.skip = 0,
  });
}
