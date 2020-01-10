import 'package:buleklar/authentication_bloc/bloc.dart';
import 'package:buleklar/login/login.dart';
import 'package:buleklar/models/ProductItem.dart';
import 'package:buleklar/user_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';

class AddProductForm extends StatefulWidget {
  final UserRepository _userRepository;

  AddProductForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imgUrlController = TextEditingController();

  AddProductBloc _addProductBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _nameController.text.isNotEmpty && _descriptionController.text.isNotEmpty;

  bool isAddProductButtonEnabled(AddProductState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _addProductBloc = BlocProvider.of<AddProductBloc>(context);
    _nameController.addListener(_onNameChanged);
    _descriptionController.addListener(_onDescriptionChanged);
    _priceController.addListener(_onPriceChanged);
    _imgUrlController.addListener(_onImgUrlChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddProductBloc, AddProductState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('AddProduct Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Добавляем товар, ёпта'),
                  ],
                ),
              ),
            );
        }

        if (state.isSuccess) {
          Scaffold.of(context)
            ..hideCurrentSnackBar();
        }
      },
      child: BlocBuilder<AddProductBloc, AddProductState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              child: ListView(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: getImage(state)),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Название',
                    ),
                    keyboardType: TextInputType.text,
                    autovalidate: true,
                    autocorrect: false,
                  ),
                  Container(height: 8),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Описание',
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 2,
                    maxLines: 20,
                    autovalidate: true,
                    autocorrect: false,
                  ),
                  Container(height: 8),
                  TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Цена',
                    ),
                    keyboardType: TextInputType.number,
                    autovalidate: true,
                    autocorrect: false,
                  ),
                  Container(height: 8),
                  TextFormField(
                    controller: _imgUrlController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ссылка на фото',
                    ),
                    keyboardType: TextInputType.url,
                    autovalidate: true,
                    autocorrect: false,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        FlatButton(
                          onPressed: _onFormSubmitted,
                          child: Text("Добавить"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onNameChanged() {
    _addProductBloc.add(
      NameChanged(name: _nameController.text),
    );
  }

  void _onDescriptionChanged() {
    _addProductBloc.add(
      DescriptionChanged(description: _descriptionController.text),
    );
  }

  void _onPriceChanged() {
    _addProductBloc.add(
      PriceChanged(price: _priceController.text),
    );
  }

  void _onImgUrlChanged() {
    _addProductBloc.add(
      ImgUrlChanged(imgUrl: _imgUrlController.text),
    );
  }

  void _onFormSubmitted() {
    _addProductBloc.add(
      AddProductPressed(
          productItem: ProductItem(
              _nameController.text,
              _descriptionController.text,
              int.parse(_priceController.text),
              null)),
    );
  }

  Widget getImage(AddProductState state) {
    if(state.image == null) {
      return Image.asset('assets/flutter_logo.png', height: 200);
    } else {
      if(state.image.medium.length > 5)return  CachedNetworkImage(imageUrl: state.image.medium ?? "", height: 200);
      else return CircularProgressIndicator();
    }
  }
}
