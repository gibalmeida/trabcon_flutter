// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

import '../pages/change_password/change_password_page.dart' as _i5;
import '../pages/forgot_password/forgot_pasword_page.dart' as _i4;
import '../pages/jobs/jobs_page.dart' as _i8;
import '../pages/my_data/my_data_page.dart' as _i6;
import '../pages/profile/profile.dart' as _i7;
import '../pages/sign-in/sign_in_page.dart' as _i2;
import '../pages/sign-up/sign_up_page.dart' as _i3;
import '../pages/splash/splash_page.dart' as _i1;

class AppRouter extends _i9.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    SplashPageRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashPage());
    },
    SignInPageRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.SignInPage());
    },
    SignUpPageRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.SignUpPage());
    },
    ForgotPasswordPageRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.ForgotPasswordPage());
    },
    ChangePasswordPageRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.ChangePasswordPage());
    },
    MyDataPageRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.MyDataPage());
    },
    ProfilePageRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.ProfilePage());
    },
    JobsPageRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.JobsPage());
    }
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig('/#redirect',
            path: '/', redirectTo: 'my-data', fullMatch: true),
        _i9.RouteConfig(SplashPageRoute.name, path: '/splash-page'),
        _i9.RouteConfig(SignInPageRoute.name, path: 'signin'),
        _i9.RouteConfig(SignUpPageRoute.name, path: 'sign-up'),
        _i9.RouteConfig(ForgotPasswordPageRoute.name, path: 'forgot-password'),
        _i9.RouteConfig(ChangePasswordPageRoute.name, path: 'change-password'),
        _i9.RouteConfig(MyDataPageRoute.name, path: 'my-data'),
        _i9.RouteConfig(ProfilePageRoute.name, path: 'profile'),
        _i9.RouteConfig(JobsPageRoute.name, path: 'jobs')
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashPageRoute extends _i9.PageRouteInfo<void> {
  const SplashPageRoute() : super(SplashPageRoute.name, path: '/splash-page');

  static const String name = 'SplashPageRoute';
}

/// generated route for
/// [_i2.SignInPage]
class SignInPageRoute extends _i9.PageRouteInfo<void> {
  const SignInPageRoute() : super(SignInPageRoute.name, path: 'signin');

  static const String name = 'SignInPageRoute';
}

/// generated route for
/// [_i3.SignUpPage]
class SignUpPageRoute extends _i9.PageRouteInfo<void> {
  const SignUpPageRoute() : super(SignUpPageRoute.name, path: 'sign-up');

  static const String name = 'SignUpPageRoute';
}

/// generated route for
/// [_i4.ForgotPasswordPage]
class ForgotPasswordPageRoute extends _i9.PageRouteInfo<void> {
  const ForgotPasswordPageRoute()
      : super(ForgotPasswordPageRoute.name, path: 'forgot-password');

  static const String name = 'ForgotPasswordPageRoute';
}

/// generated route for
/// [_i5.ChangePasswordPage]
class ChangePasswordPageRoute extends _i9.PageRouteInfo<void> {
  const ChangePasswordPageRoute()
      : super(ChangePasswordPageRoute.name, path: 'change-password');

  static const String name = 'ChangePasswordPageRoute';
}

/// generated route for
/// [_i6.MyDataPage]
class MyDataPageRoute extends _i9.PageRouteInfo<void> {
  const MyDataPageRoute() : super(MyDataPageRoute.name, path: 'my-data');

  static const String name = 'MyDataPageRoute';
}

/// generated route for
/// [_i7.ProfilePage]
class ProfilePageRoute extends _i9.PageRouteInfo<void> {
  const ProfilePageRoute() : super(ProfilePageRoute.name, path: 'profile');

  static const String name = 'ProfilePageRoute';
}

/// generated route for
/// [_i8.JobsPage]
class JobsPageRoute extends _i9.PageRouteInfo<void> {
  const JobsPageRoute() : super(JobsPageRoute.name, path: 'jobs');

  static const String name = 'JobsPageRoute';
}
