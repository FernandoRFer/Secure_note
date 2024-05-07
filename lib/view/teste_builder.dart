// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

import 'package:secure_note/core/theme/preferencies_user.dart';

class Configure extends StatefulWidget {
  final IUserTheme _userTheme;
  Widget child;
  Configure(
    this._userTheme, {
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<Configure> createState() => _ConfigureState();
}

class _ConfigureState extends State<Configure> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    widget._userTheme.setColor();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangePlatformBrightness() async {
    // UserTheme().setTheme();
    super.didChangePlatformBrightness();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        UserTheme().setTheme();
      default:
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
