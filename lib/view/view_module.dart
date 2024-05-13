import 'package:secure_note/view/auth/auth_module.dart';
import 'package:secure_note/view/home/home_module.dart';
import 'package:secure_note/view/note/note_module.dart';
import 'package:secure_note/view/register/register_module.dart';
import 'package:secure_note/view/splash/splash_module.dart';

class ViewModule {
  void configure() {
    SplashModule().configure();
    AuthModule().configure();
    HomeModule().configure();
    RegistesModule().configure();
    NoteModule().configure();
  }
}
