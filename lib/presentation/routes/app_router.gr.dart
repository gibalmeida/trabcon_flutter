// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/foundation.dart' as _i7;
import 'package:flutter/material.dart' as _i5;

import '../pages/auth_gate/auth_gate.dart' as _i1;
import '../pages/jobs/jobs_page.dart' as _i3;
import '../pages/my_data/my_data_page.dart' as _i2;
import 'app_router.dart' as _i6;

class AppRouter extends _i4.RootStackRouter {
  AppRouter(
      {_i5.GlobalKey<_i5.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i6.AuthGuard authGuard;

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    AuthGateRoute.name: (routeData) {
      final args = routeData.argsAs<AuthGateRouteArgs>();
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i1.AuthGate(key: args.key, onResult: args.onResult));
    },
    MyDataPageRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.MyDataPage());
    },
    JobsPageRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.JobsPage());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig('/#redirect',
            path: '/', redirectTo: 'my-data', fullMatch: true),
        _i4.RouteConfig(AuthGateRoute.name, path: 'auth-gate'),
        _i4.RouteConfig(MyDataPageRoute.name,
            path: 'my-data', guards: [authGuard]),
        _i4.RouteConfig(JobsPageRoute.name, path: 'jobs')
      ];
}

/// generated route for
/// [_i1.AuthGate]
class AuthGateRoute extends _i4.PageRouteInfo<AuthGateRouteArgs> {
  AuthGateRoute({_i7.Key? key, required Function onResult})
      : super(AuthGateRoute.name,
            path: 'auth-gate',
            args: AuthGateRouteArgs(key: key, onResult: onResult));

  static const String name = 'AuthGateRoute';
}

class AuthGateRouteArgs {
  const AuthGateRouteArgs({this.key, required this.onResult});

  final _i7.Key? key;

  final Function onResult;

  @override
  String toString() {
    return 'AuthGateRouteArgs{key: $key, onResult: $onResult}';
  }
}

/// generated route for
/// [_i2.MyDataPage]
class MyDataPageRoute extends _i4.PageRouteInfo<void> {
  const MyDataPageRoute() : super(MyDataPageRoute.name, path: 'my-data');

  static const String name = 'MyDataPageRoute';
}

/// generated route for
/// [_i3.JobsPage]
class JobsPageRoute extends _i4.PageRouteInfo<void> {
  const JobsPageRoute() : super(JobsPageRoute.name, path: 'jobs');

  static const String name = 'JobsPageRoute';
}
