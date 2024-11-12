import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxstatemanagement/controllers/product_controller.dart';
import 'package:getxstatemanagement/models/product.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Products Example', style: TextStyle(fontSize: 20)),
              SizedBox(height: 16),
              Obx(() => Text(
                    'Total Price: \$${productController.totalPrice.value.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18),
                  )),
              SizedBox(height: 16),
              Expanded(
                child: Obx(
                  () {
                    if (productController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      itemCount: productController.products.length,
                      itemBuilder: (context, index) {
                        final product = productController.products[index];
                        return ListTile(
                          title: Text(product.name),
                          subtitle: Text('\$${product.price}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                productController.removeProduct(product.id),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  productController.addProduct(
                    Product(
                      id: DateTime.now().millisecondsSinceEpoch,
                      name: 'New Product',
                      price: 199.99,
                    ),
                  );
                },
                child: Text('Add New Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
