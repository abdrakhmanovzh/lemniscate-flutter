import 'package:flutter/material.dart';
import 'package:lemniscate_flutter/core/globals/custom_scroll_config.dart';
import 'package:lemniscate_flutter/core/navigation/custom_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito',
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      routerConfig: CustomRouter.router,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: CustomScrollConfig(),
          child: child!,
        );
      },
    );
  }
}
