import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/page/home/home.dart';
import 'package:test_app/page/landing/bloc/landing_bloc.dart';
import 'package:test_app/page/landing/bloc/landing_event.dart';
import 'package:test_app/page/landing/bloc/landing_state.dart';
import 'package:test_app/page/landing/landingpage_view.dart';
import 'package:test_app/utility/framework/application.dart';

class Landing extends StatefulWidget {
  static const String PATH = '/';
  
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  LandingBloc _landingBloc;
  Application application;

  @override
  void initState() { 
    super.initState();
    _landingBloc = LandingBloc();
  }

  @override
  void dispose() {
    super.dispose();
    application.onTerminate();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _landingBloc,
      listener: (BuildContext context, LandingState state){
        if (state is UninitializedState){
          _landingBloc.dispatch(InitializeLandingPage());
        } else if (state is InitializedState){
          application = state.application;
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
