// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../pages/jobs/jobs_page.dart' as _i2;
import '../pages/my_data/my_data_page.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    MyDataPageRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.MyDataPage());
    },
    JobsPageRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.JobsPage());
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig('/#redirect',
            path: '/', redirectTo: 'my-data', fullMatch: true),
        _i3.RouteConfig(MyDataPageRoute.name, path: 'my-data'),
        _i3.RouteConfig(JobsPageRoute.name, path: 'jobs')
      ];
}

/// generated route for
/// [_i1.MyDataPage]
class MyDataPageRoute extends _i3.PageRouteInfo<void> {
  const MyDataPageRoute() : super(MyDataPageRoute.name, path: 'my-data');

  static const String name = 'MyDataPageRoute';
}

/// generated route for
/// [_i2.JobsPage]
class JobsPageRoute extends _i3.PageRouteInfo<void> {
  const JobsPageRoute() : super(JobsPageRoute.name, path: 'jobs');

  static const String name = 'JobsPageRoute';
}
