import 'package:bloc/bloc.dart';
import 'package:buleklar/IUserRepository.dart';
import 'package:buleklar/authentication_bloc/bloc.dart';
import 'package:buleklar/common/color_constants.dart';
import 'package:buleklar/gifts_repository.dart';
import 'package:buleklar/home/home_screen.dart';
import 'package:buleklar/login/login.dart';
import 'package:buleklar/simple_bloc_delegate.dart';
import 'package:buleklar/splash_screen.dart';
import 'package:buleklar/user_repository.dart';
import 'package:buleklar/user_repository_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io' show Platform;

import 'home/bloc/bloc.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  //final UserRepositoryWeb userRepositoryWeb = UserRepositoryWeb();
  final GiftsRepository giftsRepository = GiftsRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) =>
          AuthenticationBloc(
            userRepository: userRepository
          )
            ..add(AppStarted()),
        ),
        BlocProvider<HomeBloc>(
          create: (context) =>
          HomeBloc(
              userRepository: userRepository,
              giftsRepository: giftsRepository)
            ..add(LoadData()),
        ),
      ],
      child:
      App(userRepository: userRepository, giftsRepository: giftsRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;
  final GiftsRepository _giftsRepository;

  App({Key key,
    @required IUserRepository userRepository,
    @required GiftsRepository giftsRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _giftsRepository = giftsRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          backgroundColor: AppColors.primaryColor,
          textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Montserrat',
              bodyColor: AppColors.mainBackground,
              displayColor: AppColors.primaryColor)),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated) {
            return LoginScreen(userRepository: _userRepository);
          }
          if (state is Authenticated) {
            return HomeScreen(
              userRepository: _userRepository,
              giftsRepository: _giftsRepository,
            );
          }
          return SplashScreen();
        },
      ),
    );
  }
}
