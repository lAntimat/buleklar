import 'package:buleklar/authentication_bloc/bloc.dart';
import 'package:buleklar/common/color_constants.dart';
import 'package:buleklar/gifts_repository.dart';
import 'package:buleklar/home/bloc/bloc.dart';
import 'package:buleklar/home/bloc/home_bloc.dart';
import 'package:buleklar/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_form.dart';

class HomeScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final GiftsRepository _giftsRepository;

  HomeScreen(
      {Key key,
      @required UserRepository userRepository,
      @required GiftsRepository giftsRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _giftsRepository = giftsRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buleklar'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                LoggedOut(),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          elevation: 4.0,
          icon: const Icon(Icons.card_giftcard),
          label: const Text("Подобрать подарок"),
          onPressed: () {
            BlocProvider.of<HomeBloc>(context).add(
              FabClicked(),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.primaryColor,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {
                BlocProvider.of<HomeBloc>(context).add(
                  FabClicked(),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: HomeForm(
          name: "Name",
        ),
      ),
    );
  }
}
