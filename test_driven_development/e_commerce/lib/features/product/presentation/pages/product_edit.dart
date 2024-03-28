import 'dart:io';

import 'package:e_commerce/core/util/pick_image.dart';
import 'package:e_commerce/features/product/data/models/product_model.dart';
import 'package:e_commerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:e_commerce/features/product/presentation/widgets/loading.dart';
import 'package:e_commerce/features/product/presentation/widgets/message_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProductEdit extends StatefulWidget {
  final String initialTitle;
  final String initialCategory;
  final double initialPrice;
  final String initialDescription;
  final String productId;
  final String? image;

  const ProductEdit({
    super.key,
    required this.productId,
    this.image,
    this.initialTitle = '',
    this.initialCategory = '',
    this.initialPrice = 0.0,
    this.initialDescription = '',
  });

  @override
  _ProductEditState createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  String? _image;
  // final _picker = ImagePicker();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _catagoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with initial values
    _image = widget.image;
    _titleController.text = widget.initialTitle;
    _catagoryController.text = widget.initialCategory;
    _priceController.text = widget.initialPrice.toString();
    _descriptionController.text = widget.initialDescription;
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile.path;
      });
    }
  }

  void UpdateProduct(BuildContext context) {
    final updatedProduct = ProductModel(
        id: widget.productId,
        image:"https://media.istockphoto.com/id/1136422297/photo/face-cream-serum-lotion-moisturizer-and-sea-salt-among-bamboo-leaves.jpg?s=612x612&w=0&k=20&c=mwzWVrDvJTkHlVf-8RL49Hs5xjuv1TrYcBW4DnWVt-0=",
        rating: 0,
        price: double.tryParse(_priceController.text) ?? 0,
        title: _titleController.text,
        category: _catagoryController.text,
        description: _descriptionController.text);

    context
        .read<ProductBloc>()
        .add(UpdateProductEvent(id: widget.productId, product: updatedProduct));
  }

  void reset() {
    setState(() {
      _titleController.text = widget.initialTitle;
      _priceController.text = widget.initialPrice.toString();
      _catagoryController.text = widget.initialCategory;
      _descriptionController.text = widget.initialDescription;
      _image = widget.image;
    });
  }

  final snackBar = const SnackBar(
    content: Text('Product successfully Updated!'),
    backgroundColor: Colors.green,
  );

 bool isValid() {
    if (_titleController.text == '' ||
        _catagoryController.text == '' ||
        _descriptionController.text == '' ||
        _priceController.text == '') {
      return false;
    }else{
       return true;
    }
  }

  
  InputDecoration inputDecoration() {
    return  InputDecoration(
      filled: true,
      fillColor: const Color.fromRGBO(243, 243, 243, 1),
      contentPadding: const EdgeInsets.all(8),
      border: OutlineInputBorder(
      borderSide: BorderSide.none,  
      borderRadius: BorderRadius.circular(10.0), // Adjust the value as needed
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: Colors.blue,
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              GoRouter.of(context).pushNamed('productDetail',
                  pathParameters: {"id": widget.productId});
            },
          ),
          title: const Text('Update Product'),
        ),
        body: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductActionSuccess) {
              // Handle success state
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              
              
              // Future.delayed(const Duration(seconds: 50));

              GoRouter.of(context).pushNamed('productDetail',
                  pathParameters: {"id": widget.productId});

            } else if (state is ProductActionFailer) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                      content: Text('Product update Failed!'),
                      backgroundColor: Colors.red,
                  )
               );
            }
          },
          builder: (context, state) {
            if (state is ProductActionInProgress) {
              // Show a loading indicator while the product is being uploaded
              return const Loading();
            } else {
              // Show the Edit if the state is not loading
              return _buildForm(context);
            }
          },
        ));
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(243, 243, 243, 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              height: 150,
              width: 180,
              child: GestureDetector(
                onTap: _pickImage,
                child: _image != null
                    ? Image.network(_image!, fit: BoxFit.fill)
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image),
                          SizedBox(
                            width: 24,
                          ),
                          Text('Upload image')
                        ],
                ),
              )),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('name: '),
              TextField(
                controller: _titleController,
                decoration:inputDecoration(),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Catagory: '),
              TextField(
                controller: _catagoryController,
                decoration: inputDecoration(),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Price: '),
              TextField(
                controller: _priceController,
                decoration:InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(243, 243, 243, 1),
                    contentPadding: const EdgeInsets.all(8),
                    suffixIcon: Icon(Icons.attach_money),
                    border: OutlineInputBorder(
                    borderSide: BorderSide.none,  
                    borderRadius: BorderRadius.circular(10.0)
                  ), // Adjust the value as needed
                  ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Description: '),
              TextField(
                controller: _descriptionController,
                decoration: inputDecoration(),
                maxLines: 5,
              ),
            ],
          ),
          const SizedBox(height: 4),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  foregroundColor: Colors.white,
                  backgroundColor:const Color.fromRGBO(63, 81, 243, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
              onPressed: () {
                if (isValid()){
                  UpdateProduct(context);
                }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all forms'),
                      backgroundColor: Colors.red,
                  ));
                }
               
              },
              child: const Text('UPDATE')),
          const SizedBox(height: 16),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  foregroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.red))),
              onPressed: () {
                reset();
              },
              child: const Text('RESET')),
        ],
      ),
    );
  }
}
