import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:shop_owner_app/core/models/category_model.dart';
import 'package:shop_owner_app/core/models/product_model.dart';
import 'package:shop_owner_app/core/view_models/products_provider.dart';
import 'package:shop_owner_app/core/view_models/product_provider.dart';
import 'package:shop_owner_app/core/view_models/picture_provider.dart';
import 'package:shop_owner_app/ui/utils/ui_tools/my_alert_dialog.dart';
import 'package:shop_owner_app/ui/utils/ui_tools/my_border.dart';
import 'package:shop_owner_app/ui/utils/ui_tools/my_snackbar.dart';
import 'package:shop_owner_app/ui/widgets/authenticate.dart';
import 'package:shop_owner_app/ui/widgets/image_preview.dart';
import 'package:uuid/uuid.dart';

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({super.key});

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final _categories = CategoryModel().getCategories();
  final FocusNode _brandFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _quantityFocusNode = FocusNode();
  final FocusNode _categoryFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final ProductModel _productModel = ProductModel();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _productModel.category = _categories[0].title;
  }

  @override
  void dispose() {
    super.dispose();
    _brandFocusNode.dispose();
    _priceFocusNode.dispose();
    _quantityFocusNode.dispose();
    _categoryFocusNode.dispose();
    _descriptionFocusNode.dispose();
  }

  void _submitForm() async {
    final uploadingPictureProvider =
        Provider.of<PicturesProvider>(context, listen: false);
    final isValid = _formKey.currentState!.validate();

    if (imageList.length == 1) {
      MySnackBar().showSnackBar('Please select at least one image', context,
          duration: const Duration(seconds: 2));
    } else if (isValid) {
      setState(() => _isLoading = true);

      for (int i = 1; i < imageList.length; i++) {
        imageChosenForASingleProduct.add(imageList[i]);
        setState(() {});
      }

      var listOfImageUrlLinks = await uploadingPictureProvider.uploadPictures(
          picturesList: imageChosenForASingleProduct,
          productsName: _productModel.name);

      setState(() {
        _productModel.imageUrls = listOfImageUrlLinks;
        _productModel.isPopular = _isPopular;
        imageList.clear();
        imageList = [
          "",
        ];
      });

      _formKey.currentState!.save();
      _productModel.id = const Uuid().v4();
      final productProvider =
          Provider.of<ProductsProvider>(context, listen: false);
      await productProvider.addProduct(_productModel).then((_) {
        MySnackBar().showSnackBar('Success', context);
        setState(() {
          _productModel.imageUrls?.clear();
          imageChosenForASingleProduct.clear();
          _formKey.currentState?.reset();
        });
      }).catchError((error) {
        MyAlertDialog.error(context, error.message);
      }).whenComplete(() => setState(() => _isLoading = false));
    }
  }

  List<String> imageList = [
    "",
  ];
  List<String> imageChosenForASingleProduct = [];

  bool _isPopular = false;

  @override
  Widget build(BuildContext context) {
    return Authenticate(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ModalProgressHUD(
          inAsyncCall: _isLoading,
          dismissible: false,
          progressIndicator: SpinKitFadingCircle(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.white : Colors.green,
                ),
              );
            },
          ),
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Upload New Product"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: imageList.length,
                                itemBuilder: (context, index) {
                                  return index == 0
                                      ? Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Stack(
                                              children: [
                                                ImagePreview(
                                                  imagePath: imageList[index],
                                                  height: 190,
                                                  width: 190,
                                                ),
                                                Positioned(
                                                  top: 80,
                                                  left: 75,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      final pickedImagePath =
                                                          await MyAlertDialog
                                                              .imagePicker(
                                                                  context);
                                                      setState(() {
                                                        pickedImagePath != null
                                                            ? imageList.add(
                                                                pickedImagePath)
                                                            : null;
                                                        MySnackBar().showSnackBar(
                                                            'New picture of the product is added',
                                                            context,
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        300));
                                                      });
                                                      //  _productModel.imageUrl = _pickedImagePath;
                                                    },
                                                    child: const Icon(
                                                      Icons.add_circle,
                                                      size: 30,
                                                      color: Colors.black45,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Stack(
                                            children: [
                                              ImagePreview(
                                                imagePath: imageList[index],
                                                height: 190,
                                                width: 190,
                                              ),
                                              Positioned(
                                                top: 15,
                                                right: 5,
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      imageList.remove(
                                                          imageList[index]);
                                                      MySnackBar().showSnackBar(
                                                          'Picture of the product is removed',
                                                          context,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 2));
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 25,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                        color: Colors.black45,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: const Center(
                                                        child: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                    )),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 80,
                                                left: 75,
                                                child: InkWell(
                                                  onTap: () async {
                                                    final pickedImagePath =
                                                        await MyAlertDialog
                                                            .imagePicker(
                                                                context);
                                                    setState(() {
                                                      if (pickedImagePath !=
                                                          null) {
                                                        imageList.remove(
                                                            imageList[index]);
                                                        imageList.add(
                                                            pickedImagePath);
                                                        MySnackBar().showSnackBar(
                                                            'Picture of the product is replaced',
                                                            context,
                                                            duration:
                                                                const Duration(
                                                                    seconds:
                                                                        2));
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 25,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                        color: Colors.black45,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: const Center(
                                                        child: Icon(
                                                      Icons
                                                          .image_search_rounded,
                                                      color: Colors.white,
                                                    )),
                                                  ),
                                                ),
                                              ),
                                              index == 1
                                                  ? Positioned(
                                                      top: 20,
                                                      left: 09,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          final pickedImagePath =
                                                              await MyAlertDialog
                                                                  .imagePicker(
                                                                      context);
                                                          setState(() {
                                                            if (pickedImagePath !=
                                                                null) {
                                                              imageList.remove(
                                                                  imageList[
                                                                      index]);
                                                              imageList.add(
                                                                  pickedImagePath);
                                                            }
                                                          });
                                                        },
                                                        child: Container(
                                                          height: 6.3.h,
                                                          width: 18.w,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7)),
                                                          child: const Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text("ThumbNail"),
                                                              Center(
                                                                  child: Icon(
                                                                Icons
                                                                    .thumb_up_alt_outlined,
                                                                color:
                                                                    Colors.blue,
                                                              )),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        );
                                }),
                          ),

                          // Name Section
                          _sectionTitle('Name'),
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                            validator: (value) =>
                                value!.isEmpty ? 'Required' : null,
                            decoration: InputDecoration(
                              hintText: 'Add product name...',
                              enabledBorder:
                                  MyBorder.underlineInputBorder(context),
                            ),
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_brandFocusNode),
                            onSaved: (value) => _productModel.name = value!,
                          ),

                          // Brand Section
                          _sectionTitle('Brand'),
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                            focusNode: _brandFocusNode,
                            validator: (value) =>
                                value!.isEmpty ? 'Requiered' : null,
                            decoration: InputDecoration(
                              hintText: 'Add product brand...',
                              enabledBorder:
                                  MyBorder.underlineInputBorder(context),
                            ),
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_priceFocusNode),
                            onSaved: (value) => _productModel.brand = value!,
                          ),

                          // Price Section
                          _sectionTitle('Price'),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            focusNode: _priceFocusNode,
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            // ],
                            validator: (value) =>
                                value!.isEmpty ? 'Required' : null,
                            decoration: InputDecoration(
                              hintText: 'Add product price...',
                              enabledBorder:
                                  MyBorder.underlineInputBorder(context),
                            ),
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_quantityFocusNode),
                            onSaved: (value) =>
                                _productModel.price = double.parse(value!),
                          ),

                          // Quantity Section
                          _sectionTitle('Quantity'),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            focusNode: _quantityFocusNode,
                            validator: (value) =>
                                value!.isEmpty ? 'Requiered' : null,
                            decoration: InputDecoration(
                              hintText: 'Add product quantity...',
                              enabledBorder:
                                  MyBorder.underlineInputBorder(context),
                            ),
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_categoryFocusNode),
                            onSaved: (value) =>
                                _productModel.quantity = int.parse(value!),
                          ),

                          // Category section
                          _sectionTitle('Category'),
                          DropdownButtonFormField(
                            focusNode: _categoryFocusNode,
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(_descriptionFocusNode);
                            },
                            items: _categories
                                .map(
                                  (category) => DropdownMenuItem<String>(
                                    value: category.title,
                                    child: Text(category.title),
                                  ),
                                )
                                .toList(),
                            value: _productModel.category,
                            onChanged: (String? value) {
                              setState(() {
                                _productModel.category = value.toString();
                              });
                            },
                            decoration: InputDecoration(
                              enabledBorder:
                                  MyBorder.underlineInputBorder(context),
                            ),
                          ),

                          // Description Section
                          _sectionTitle('Description'),
                          const SizedBox(height: 10),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 10,
                            validator: (value) =>
                                value!.isEmpty ? 'Required' : null,
                            textCapitalization: TextCapitalization.sentences,
                            textInputAction: TextInputAction.done,
                            focusNode: _descriptionFocusNode,
                            decoration: InputDecoration(
                              hintText: 'Add product description...',
                              border: const OutlineInputBorder(),
                              enabledBorder:
                                  MyBorder.outlineInputBorder(context),
                            ),
                            onSaved: (value) =>
                                _productModel.description = value!,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Is Popular section Section

                  Card(
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: const Text(
                            'Is popular',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          value: _isPopular,
                          onChanged: (bool value) {
                            setState(() {
                              _isPopular = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  // Upload Product Button
                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Material(
                      color: Theme.of(context).primaryColor,
                      child: InkWell(
                        onTap: _submitForm,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Upload',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(width: 8),
                              _isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Icon(
                                      Icons.cloud_upload_outlined,
                                      color: Colors.white,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 14),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
