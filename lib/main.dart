import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/bloc/bloc/auth_bloc.dart';
import 'package:flutter_assessment/bloc/pokemon/bloc/pokemon_bloc.dart';
import 'package:flutter_assessment/repo/auth_repo.dart';
import 'package:flutter_assessment/repo/pokemon_repo.dart';
import 'package:flutter_assessment/repo/store_userToken.dart';
import 'package:flutter_assessment/views/home_page.dart';
import 'package:flutter_assessment/views/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyANjQknXQC95nkmO6R467dWtsPZydEToEQ',
          appId: '',
          messagingSenderId: '',
          projectId: 'flutter-assessment-7f2b1'));
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final usertoken = await UserToken.getToken();
  runApp(
    MyApp(
        authRepo: AuthRepository(), prefs: sharedPreferences, token: usertoken),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepo;
  final SharedPreferences prefs;
  final String? token;
  const MyApp(
      {super.key, required this.authRepo, required this.prefs, this.token});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            authRepo,
          ),
        ),
        BlocProvider(
          create: (context) =>
              PokemonBloc(pokemonRepository: PokemonRepository()),
        ),
      ],
      child: MaterialApp(
        home: token == null ? LoginPage() : const HomePage(),
      ),
    );
  }
}
