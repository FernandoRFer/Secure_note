import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

class _SplashViewState extends State<SplashView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      widget.bloc.load();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangePlatformBrightness() async {
    widget.bloc.setTheme();
    super.didChangePlatformBrightness();
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
              return const Icon(
                Icons.lock,
                size: 100,
              )
                  .animate(onPlay: (animationController) {
                    animationController.repeat();
                  })
                  .scaleXY(
                      begin: 0.9,
                      end: 1,
                      curve: Curves.bounceInOut,
                      duration: const Duration(milliseconds: 500))
                  .then()
                  .scaleXY(
                      begin: 1,
                      end: 0.9,
                      curve: Curves.bounceInOut,
                      duration: const Duration(milliseconds: 500));
            },
          ),
        ),
      ),
    );
  }
}
