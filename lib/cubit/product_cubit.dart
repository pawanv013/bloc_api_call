import 'package:bloc_api_call/model/product_model.dart';
import 'package:bloc_api_call/model/selected_product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  late List<ProductModel> productModel = [];
  late List<SelectedProductModel> selectedProduct = [];
  List<SelectedProductModel> get selected => selectedProduct;

  Future<List<ProductModel>> getPost() async {
    Uri url = Uri.parse('https://fakestoreapi.com/products');
    Response response = await http.get(url);
    // ignore: unnecessary_null_comparison
    if (response.body != null && response.body.isNotEmpty) {
      productModel = productModelFromJson(response.body);
      return productModel;
    } else {
      return productModel;
    }
  }

  void adToCard(int index, bool val, ProductModel product) {
    productModel[index].isAdded = val;
    if (productModel[index].isAdded!) {
      selectedProduct.add(SelectedProductModel(
        id: product.id,
        title: product.title,
        price: product.price,
        description: product.description,
        category: product.category,
        image: product.image,
        isAdded: product.isAdded,
      ));
      emit(ChackedState());
    }
    emit(UnChackedState());
    selectedProduct.removeWhere((item) => item.id == product.id);
  }

  Future<List<SelectedProductModel>> getSelectedPostData() async {
    selectedProduct = [];
    productModel.where((post) => post.isAdded == true).forEach(
      (selectedP) {
        selectedProduct.add(SelectedProductModel(
          id: selectedP.id,
          title: selectedP.title,
          price: selectedP.price,
          description: selectedP.description,
          category: selectedP.category,
          image: selectedP.image,
          isAdded: selectedP.isAdded,
        ));
      },
    );
    return selectedProduct;
  }
}
