import 'package:buleklar/IUserRepository.dart';
import 'package:buleklar/gifts_repository.dart';
import 'package:buleklar/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';
import 'product_detail_form.dart';

class ProductDetailScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final GiftsRepository _giftsRepository;
  final String _id;

  ProductDetailScreen(
      {Key key,
      @required String id,
      @required IUserRepository userRepository,
      @required GiftsRepository giftsRepository})
      : assert(userRepository != null),
        assert(giftsRepository != null),
        assert(id != null),
        _userRepository = userRepository,
        _giftsRepository = giftsRepository,
        _id = id,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Название товара')),
      body: BlocProvider<ProductDetailBloc>(
        create: (context) => ProductDetailBloc(
            userRepository: _userRepository, giftsRepository: _giftsRepository),
        child: ProductDetailForm(id: _id),
      ),
    );
  }
}
