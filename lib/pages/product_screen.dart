import 'package:bloc_api_call/cubit/product_cubit.dart';
import 'package:bloc_api_call/model/product_model.dart';
import 'package:bloc_api_call/pages/card_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'Open shopping cart',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CardScreen()));
            },
          ),
        ],
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: BlocProvider.of<ProductCubit>(context).getPost(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return BlocConsumer<ProductCubit, ProductState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    var product = snapshot.data![index];
                    return Card(
                      child: GridTile(
                        footer: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${product.price}'),
                            IconButton(
                              onPressed: () {
                                bool val = product.isAdded! ? false : true;
                                BlocProvider.of<ProductCubit>(context)
                                    .adToCard(index, val, product);
                              },
                              icon: Icon(
                                Icons.shopify,
                                size: 40,
                                color: product.isAdded! == true
                                    ? Colors.amber
                                    : Colors.grey,
                              ),
                            )
                          ],
                        ),
                        child: Image.network(product
                            .image!), //just for testing, will fill with image later
                      ),
                    );
                  },
                );
              },
              itemCount: snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
            );
          } else {
            return const SizedBox(
              height: 0,
              width: 0,
            );
          }
        },
      ),
    );
  }
}
