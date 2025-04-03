import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';
import 'product_details.dart';

class ProductList extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<ProductProvider>(context, listen: false)
            .fetchProducts(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Product List'),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(75.0),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Consumer<ProductProvider>(
                    builder: (context, productProvider, child) {
                      return TextField(
                        style: TextStyle(color: Colors.white, fontSize: 17.5),
                        controller: _searchController,
                        onChanged: (value) {
                          productProvider.setSearchQuery(value.toLowerCase());
                        },
                        decoration: InputDecoration(
                          hintText: 'Search products',
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 17.5),
                          prefixIcon: Icon(Icons.search, color: Colors.black),
                          fillColor: Colors.white24,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            body: Consumer<ProductProvider>(
              builder: (context, productProvider, child) {
                if (productProvider.isLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                          color: Colors.blue.shade900));
                }

                final filteredProducts = productProvider.filteredProducts;

                if (filteredProducts.isEmpty) {
                  return Center(
                      child: Text("No products available",
                          style:
                              TextStyle(color: Colors.white, fontSize: 17.5)));
                }

                return ListView.builder(
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2.5),
                      child: ListTile(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        tileColor: Colors.white10,
                        title: Text(product.title,
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.5)),
                        leading: Image.network(product.thumbnail, width: 50),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetails(id: product.id, title: product.title),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          );
        });
  }
}