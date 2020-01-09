import 'package:buleklar/IUserRepository.dart';
import 'package:buleklar/addproduct/add_product_form.dart';
import 'package:buleklar/gifts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buleklar/user_repository.dart';
import 'package:buleklar/login/login.dart';

import 'bloc.dart';

class AddProductScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final GiftsRepository _giftsRepository;

  AddProductScreen({Key key, @required IUserRepository userRepository, @required GiftsRepository giftsRepository})
      : assert(userRepository != null), assert(giftsRepository != null),
        _userRepository = userRepository,
        _giftsRepository = giftsRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Добавить товар')),
      body: BlocProvider<AddProductBloc>(
        create: (context) => AddProductBloc(userRepository: _userRepository, giftsRepository: _giftsRepository),
        child: AddProductForm(userRepository: _userRepository),
      ),
    );
  }
}
