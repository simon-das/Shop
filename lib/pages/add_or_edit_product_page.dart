import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product_model_provider.dart';
import 'package:shop/providers/product_provider.dart';

class AddOrEditProductPage extends StatefulWidget {
  static const String routeName = 'add_or_edit_product_page';

  @override
  _AddOrEditProductPageState createState() => _AddOrEditProductPageState();
}

class _AddOrEditProductPageState extends State<AddOrEditProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String title, description;
  double price;

  ProductModelProvider product;

  bool isInit = true;

  ValueNotifier<String> imageUrl = ValueNotifier<String>('');

  FocusNode imageUrlFocusNode = FocusNode(),
      priceFocusNode = FocusNode(),
      descriptionFocusNode = FocusNode();

  void save(BuildContext context) {
    final bool isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();

    //creating new product
    final ProductModelProvider newProduct = ProductModelProvider(
      title: title,
      description: description,
      imageUrl: imageUrl.value,
      price: price,
    );

    //add or update product
    if (product == null) {
      Provider.of<ProductProvider>(context, listen: false)
          .addProduct(newProduct);
    } else {
      Provider.of<ProductProvider>(context, listen: false)
          .updateProduct(newProduct);
    }

    //go to my products page
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    priceFocusNode.dispose();
    descriptionFocusNode.dispose();
    imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (isInit) {
      product = ModalRoute.of(context).settings.arguments;
      if (product != null) imageUrl.value = product.imageUrl;
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                save(context);
              })
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              //title
              TextFormField(
                initialValue: product == null ? null : product.title,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty) return 'Please enter a title';
                  return null;
                },
                onSaved: (value) {
                  title = value;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(priceFocusNode);
                },
              ),
              //price
              TextFormField(
                initialValue: product == null ? null : product.price.toString(),
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty)
                    return 'Please enter a price';
                  else if (double.tryParse(value) == null)
                    return 'Please enter a valid price';
                  else
                    return null;
                },
                onSaved: (value) {
                  price = double.parse(value);
                },
                focusNode: priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(descriptionFocusNode);
                },
              ),
              //description
              TextFormField(
                initialValue: product == null ? null : product.description,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                textInputAction: TextInputAction.next,
                maxLines: 3,
                minLines: 1,
                validator: (value) {
                  if (value.isEmpty)
                    return 'Please enter a description';
                  else if (value.length < 10)
                    return 'Please enter more than 10 letters';
                  return null;
                },
                focusNode: descriptionFocusNode,
                onSaved: (value) {
                  description = value;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(imageUrlFocusNode);
                },
              ),
              //image
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //image preview
                  ValueListenableBuilder<String>(
                    valueListenable: imageUrl,
                    builder: (context, value, _) {
                      return Container(
                        margin: const EdgeInsets.only(top: 16.0, right: 20),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(border: Border.all()),
                        child: value == ''
                            ? Text('Enter an image url')
                            : Image.network(
                                value,
                                fit: BoxFit.fill,
                              ),
                      );
                    },
                  ),
                  //image url
                  Expanded(
                    child: TextFormField(
                      initialValue: product == null ? null : product.imageUrl,
                      decoration: InputDecoration(labelText: 'Image URL'),
                      onSaved: (value) {
                        imageUrl.value = value;
                      },
                      focusNode: imageUrlFocusNode,
                      onFieldSubmitted: (value) {
                        imageUrl.value = value;
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
