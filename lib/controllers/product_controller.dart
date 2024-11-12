import 'package:get/get.dart';
import 'package:getxstatemanagement/models/product.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = false.obs;
  var totalPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      isLoading.value = true;

      await Future.delayed(Duration(seconds: 8));
      var productList = [
        Product(id: 1, name: 'Laptop', price: 999.99),
        Product(id: 2, name: 'Phone', price: 699.99),
      ];
      products.value = productList;
      calculateTotal();
    } finally {
      isLoading.value = false;
    }
  }

  // calculateTotal
  void calculateTotal() {
    totalPrice.value = products.fold(0, (sum, product) => sum + product.price);
  }

  // addProduct
  void addProduct(Product product) {
    products.add(product);
    calculateTotal();
  }

  //removeProduct
  void removeProduct(int id) {
    products.removeWhere((product) => product.id == id);
    calculateTotal();
  }
}
