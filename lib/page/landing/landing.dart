import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/page/home/home.dart';
import 'package:test_app/page/landing/bloc/landing_bloc.dart';
import 'package:test_app/page/landing/bloc/landing_event.dart';
import 'package:test_app/page/landing/bloc/landing_state.dart';
import 'package:test_app/page/landing/landingpage_view.dart';

class Landing extends StatefulWidget {
  static const String PATH = '/';
  
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  LandingBloc _landingBloc;

  @override
  void initState() { 
    super.initState();
    _landingBloc = LandingBloc();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _landingBloc,
      listener: (BuildContext context, LandingState state){
        if (state is UninitializedState){
          _landingBloc.dispatch(InitializeLandingPage());
        }
      },
      child: BlocBuilder(
        bloc: _landingBloc,
        builder: (BuildContext context, LandingState state) {
          if (state is InitializedState){
            return HomePage();
          }
          return LandingPageView();
        },
      ),
    );
  }
}
