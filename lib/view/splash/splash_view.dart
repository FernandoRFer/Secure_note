// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:secure_note/view/splash/splash_bloc.dart';

class SplashView extends StatefulWidget {
  final ISplashBloc bloc;
  const SplashView(
    this.bloc, {
    Key? key,
  }) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  ValueNotifier<bool> isAuth = ValueNotifier(false);
  late AnimationController _animation;

  @override
  void initState() {
    // _animation = AnimationController(vsync: this , duration: const Duration(milliseconds: 400 ) )
    Future.delayed(Duration.zero, widget.bloc.load);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          height: 200,
          child: StreamBuilder<SplashModel>(
              stream: widget.bloc.onFetchingData,
              builder: (context, snapshot) {
                return ValueListenableBuilder(
                  valueListenable: isAuth,
                  builder: (context, value, Widget? child) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 1000),
                      child: snapshot.data?.iconData ?? true
                          ? const Icon(
                              Icons.lock,
                              size: 100,
                              key: ValueKey('Icon a'),
                            )
                          : const CircularProgressIndicator(),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                      // const Icon(
                      //     Icons.lock_open,
                      //     size: 100,
                      //     key: ValueKey('Icon b'),
                      //   ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
