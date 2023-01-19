import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import '../../../business/business.dart';
import '../../../data/data.dart';
import '../screens.dart';

import 'splash_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late ThemeStyle _themeStyle;

  @override
  void initState() {
    BlocProvider.of<CardItemBloc>(context).add(ListCardItem());
    // FirebaseAccess().populateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _themeStyle = context.watch<CurrentThemeBloc>().state;
    context.read<SplashScreenBloc>().add(
          const AuthenticateUser(accessRequest: 'passed'),
        );
    return BlocConsumer<SplashScreenBloc, SplashScreenState>(
      listener: (context, state) {
        if (state is AuthenticationSuccessful) {
          if (!HiveDB.accessedApp()) {
            //app just installed, take to on boarding or something similar logic
            Navigator.pushAndRemoveUntil(
              context,
              Navigation.getRoute(const HomeScreen()),
              (route) => false,
            );
          } else {
            //if user exist... go to home screen
            if (HiveDB.isLoggedIn()) {
              Navigator.pushAndRemoveUntil(
                context,
                Navigation.getRoute(const HomeScreen()),
                (route) => false,
              );
            } else {
              //take user like to fore example to create account screen....
              Navigator.pushAndRemoveUntil(
                context,
                Navigation.getRoute(const HomeScreen()),
                (route) => false,
              );
            }
          }
        } else if (state is AuthenticationFailed) {
          Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          body: Container(
            color: _themeStyle.evenLightColor,
            child: CustomPaint(
              painter: SplashBackground(),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(ImageAssets.iconLogo),
                        SizedBox(width: 2.w),
                        AutoSizeText(
                          LocalStrings.localString(
                              string: "appTitle", context: context),
                          style: TextStyle(
                            color: _themeStyle.evenDarkColor,
                            fontWeight: FontWeight.bold,
                          ),
                          maxFontSize: 17.sp.floorToDouble(),
                          minFontSize: 10.sp.floorToDouble(),
                        )
                        // SvgPicture.asset(ImageAssets.textLogo),;;
                      ],
                    ),
                    if (state is AuthenticationLoading)
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(),
                      ),
                    if (state is AuthenticationFailed)
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextButton(
                          child: const Text('Retry'),
                          onPressed: () {
                            context.read<SplashScreenBloc>().add(
                                  const AuthenticateUser(
                                      accessRequest: 'passed'),
                                );
                          },
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
