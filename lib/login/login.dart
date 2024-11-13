import 'package:daar_daar/login/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

// Définition des utilisateurs avec leurs mots de passe
const users = {
  'tanorfall@gmail.com': '12345',
};

// Classe LoginScreen définie comme StatefulWidget pour la gestion de l'état
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// Classe d'état de LoginScreen
class _LoginScreenState extends State<LoginScreen> {
  // Durée de la simulation de temps de chargement pour l'authentification
  Duration get loginTime => const Duration(milliseconds: 2250);

  // Méthode d'authentification utilisateur
  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User does not exist'; // Retourne une erreur si l'utilisateur n'existe pas
      }
      if (users[data.name] != data.password) {
        return 'Password does not match'; // Retourne une erreur si le mot de passe est incorrect
      }
      return null; // Authentification réussie
    });
  }

  // Méthode de création de compte
  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null; // Succès de l'inscription (aucune validation réelle ici)
    });
  }

  // Méthode de récupération de mot de passe
  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User does not exist'; // Erreur si l'utilisateur n'existe pas
      }
      return 'success'; // Succès de la récupération
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Darr Darr',
      logo: const AssetImage('assets/images/logo.png'),
      onLogin: _authUser, // Fonction d'authentification à appeler lors de la connexion
      onSignup: _signupUser, // Fonction d'inscription à appeler lors de la création d'un compte
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const MyHomePage(title: 'Acceuil',), // Redirection après connexion
        ));
      },
      onRecoverPassword: _recoverPassword, // Fonction de récupération de mot de passe
      // Personnalisation de l'apparence du formulaire de connexion
      theme: LoginTheme(
        primaryColor: Colors.blue,  // Couleur principale pour les éléments
        accentColor: Colors.blueAccent, // Couleur d'accentuation
        errorColor: const Color.fromARGB(176, 231, 167, 39), // Couleur pour les messages d'erreur
        titleStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        pageColorLight: Colors.white, // Couleur d'arrière-plan claire
        pageColorDark: Colors.white, // Couleur d'arrière-plan sombre
        cardTheme: const CardTheme(
          color: Color.fromARGB(255, 218, 68, 41), // Arrière-plan du formulaire en orange
          elevation: 5, // Ombre autour de la carte pour la mettre en relief
          margin: EdgeInsets.symmetric(horizontal: 20),
        ),
        bodyStyle: const TextStyle(
          color: Colors.black, // Couleur du texte pour le corps
        ),
        textFieldStyle: const TextStyle(
          color: Colors.black, // Couleur du texte pour les champs de texte
        ),
        buttonStyle: const TextStyle(
          color: Colors.white, // Couleur du texte pour les boutons
        ),
      ),
    );
  }
}
