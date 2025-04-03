import 'package:flutter/material.dart';
import 'package:products/service/api_service.dart';
import 'package:products/model/product.dart';

class ProductDetails extends StatelessWidget {
  final int id;
  final String title;

  const ProductDetails({Key? key, required this.id, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_outlined,
              size: 25, color: Colors.indigo),
        ),
        title: Text(title,
            style: TextStyle(
                fontSize: 22.5,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Product>(
          future: ApiService.fetchProductDetails(id), // Use ApiService
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child:
                      CircularProgressIndicator(color: Colors.blue.shade900));
            } else if (snapshot.hasError) {
              return Center(
                  child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.white, fontSize: 17.5),
              ));
            } else {
              final product = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Image.network(product.thumbnail)),
                    SizedBox(height: 25),
                    Text(product.title,
                        style: TextStyle(
                            fontSize: 22.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    SizedBox(height: 25),
                    Text(product.description,
                        style: TextStyle(fontSize: 17.5, color: Colors.white)),
                    SizedBox(height: 25),
                    Text('Price: \$${product.price}',
                        style: TextStyle(fontSize: 17.5, color: Colors.white)),
                    SizedBox(height: 25),
                    Text('Discount Percentage: ${product.discountPercentage}%',
                        style: TextStyle(fontSize: 17.5, color: Colors.white)),
                    SizedBox(height: 25),
                    Text('Rating: ${product.rating}',
                        style: TextStyle(fontSize: 17.5, color: Colors.white)),
                    SizedBox(height: 25),
                    Text('Stock: ${product.stock}',
                        style: TextStyle(fontSize: 17.5, color: Colors.white)),
                    SizedBox(height: 25),
                    Text('Brand: ${product.brand}',
                        style: TextStyle(fontSize: 17.5, color: Colors.white)),
                    SizedBox(height: 25),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}