import 'package:app/models/book_model.dart';
import 'package:app/models/validation_model.dart';
import 'package:app/pages/home_final_user.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/pages/register_validation_help.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app/models/user_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../configs/app_settings.dart';
import '../pages/home_ca.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? usuario;
  // String? nickname;
  late bool isAdm;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  registrar(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está cadastrado');
      } else {
        AuthException('e.code');
      }
    }
  }

  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente');
      } else {
        AuthException('e.code');
      }
    }
  }

  logout(context) async {
    await _auth
        .signOut()
        .then((value) => {
              Fluttertoast.showToast(msg: "Deslogado com sucesso"),
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              ),
            })
        .catchError((error) {
      Fluttertoast.showToast(msg: error!.message);
      return error;
    });
    _getUser();
    removeSaveLogin(context);
  }

  // other wat ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss

  updateValidate(Map<String, dynamic> rV, String readerRegistration, String? userRegistration) async {
    // TODO Fiz uma solução não legal, atualizar quando tiver tempo
    DateFormat date = DateFormat('dd/MM/yyyy HH:mm');

    await firebaseFirestore
        .collection('validation')
        .where('userReaderId', isEqualTo: readerRegistration)
        .get()
        .then((value) async {
      await firebaseFirestore.collection("validation").doc(value.docs.first.id).update(
        {
          "status": true,
          "userAllowingId": userRegistration,
          "dateValidation": date.format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch))
        },
      );
    });
  }

  confirmValidation(String registration, Map<String, dynamic> requestValidate) async {
    await firebaseFirestore.collection('user').where('matriculaSIAPE', isEqualTo: registration).get().then(
      (value) async {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: 'Matrícula não encontrada');
          return false;
        }
        for (var docSnapshot in value.docs) {
          var usermap = docSnapshot.data();
          usermap['validated'] = true;
          firebaseFirestore.collection("user").doc(usermap['uId']).update({"validated": true});
        }
        Fluttertoast.showToast(msg: 'Validado com Sucesso');
      },
    ).catchError(
      (e) {
        Fluttertoast.showToast(msg: e!.message);
        return false;
      },
    );
    updateValidate(requestValidate, registration, usuario?.uid);
  }

  sendValidationRequest(String registration) async {
    DateFormat date = DateFormat('dd/MM/yyyy HH:mm');
    ValidationModel validationRequest = ValidationModel(
        dateRequest: date.format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch)),
        dateValidation: date.format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch)),
        status: false,
        userAllowingId: null,
        userReaderId: registration);
    await firebaseFirestore.collection("validation").add(validationRequest.toMap());
  }

  saveLogin(BuildContext context, String registration, String password) async {
    // Salvar
    await context.read<AppSettings>().setData(registration, password);
  }

  removeSaveLogin(BuildContext context) async {
    await context.read<AppSettings>().setData('', '');
  }

  void signInWithRegistration(
    BuildContext context,
    String registration,
    String password,
    bool rememberPass,
  ) async {
    bool succesSignIn = false;
    await firebaseFirestore.collection('user').where('matriculaSIAPE', isEqualTo: registration).get().then(
      (value) async {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: 'Matrícula não encontrada');
          return false;
        }
        for (var docSnapshot in value.docs) {
          if (docSnapshot.data()['validated']) {
            String email = docSnapshot.data()['email'];
            succesSignIn = await signIn(
              context,
              email,
              password,
              docSnapshot.data()['typeAdmin'],
            );
          } else {
            Fluttertoast.showToast(msg: 'Matrícula não validada');
          }

          // nickname = docSnapshot.data()['nickname']; // Provavelmente não é a melhor prática
        }
        _getUser();
      },
    ).catchError(
      (e) {
        Fluttertoast.showToast(msg: e!.message);
        _getUser();
        return false;
      },
    );
    _getUser();
    if (rememberPass && succesSignIn) {
      saveLogin(context, registration, password);
    }
  }

  Future<bool> signIn(
    BuildContext context,
    String email,
    String senha,
    bool isAdm,
  ) async {
    bool resp = false;
    await _auth.signInWithEmailAndPassword(email: email, password: senha).then((uid) {
      Fluttertoast.showToast(msg: "Logado com sucesso");
      if (isAdm) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeCa(),
          ),
        );
        this.isAdm = true;
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeFinalUse(),
          ),
        );
        this.isAdm = false;
      }
      resp = true; // sucesso ao logar
    }).catchError(
      (e) {
        if (e!.message == 'The password is invalid or the user does not have a password.') {
          Fluttertoast.showToast(msg: 'Senha inválida');
        }
        _getUser();
      },
    );
    _getUser();
    return resp; // sucesso ao logar
  }

  signUp(
    BuildContext context,
    String email,
    String senha,
    GlobalKey<FormState> formKey,
    TextEditingController? texMatriculaController,
    TextEditingController? texEmailController,
    TextEditingController? texSenhaController,
    TextEditingController? texConfSenhaController,
  ) async {
    if (formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: senha)
          .then((value) => {
                postDetailsToFirestore(
                  context,
                  texMatriculaController,
                  texEmailController,
                  texSenhaController,
                  texConfSenhaController,
                ),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
        return e;
      });
      _getUser();
    }
  }

  postDetailsToFirestore(
    BuildContext context,
    TextEditingController? texMatriculaController,
    TextEditingController? texEmailController,
    TextEditingController? texSenhaController,
    TextEditingController? texConfSenhaController,
  ) async {
    // * Calling Firestore
    // * Calling User Model
    // * Sending these values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel(
      uId: user!.uid,
      matriculaSIAPE: texMatriculaController!.text,
      email: texEmailController!.text,
      pass: texSenhaController!.text,
      typeAdmin: true,
      validated: false,
    );

    // * Writing all the values

    await firebaseFirestore.collection("user").doc(user.uid).set(userModel.toMap());
    Fluttertoast.showToast(msg: "Conta criada com sucesso");
    sendValidationRequest(texMatriculaController.text);

    // Não sei corrigir
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => const RegisterValidationHelpPageWidget()),
      (route) => false,
    );
  }

  Future<bool> checkIfExist(String nome, String autor, String edicao) async {
    // TODO: Fazer uma função de retorno do _value_
    // depois trocar pra chave de identificação
    bool resp = false;
    await firebaseFirestore
        .collection('book')
        .where('nome', isEqualTo: nome)
        .where('autor', isEqualTo: autor)
        .where('edicao', isEqualTo: int.tryParse(edicao))
        .get()
        .then(
      (value) {
        if (value.docs.isEmpty || value.docs[0].data()['isDeleted'].toString() == 'true') {
          resp = false;
        } else {
          resp = true;
        }
      },
    );
    return resp;
  }

  postBookDetailsToFirestore(
    // separar em 2 funções
    TextEditingController? nomeController,
    TextEditingController? autorController,
    TextEditingController? anoController,
    TextEditingController? edicaoController,
    String? tipo,
    String? genero,
    TextEditingController? editoraController,
    bool isUpdating,
    //TextEditingController? fotoController, Por enquanto não vou colocar foto
  ) async {
    if (!await checkIfExist(nomeController!.text, autorController!.text, edicaoController!.text) || isUpdating) {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      DateFormat date = DateFormat('dd/MM/yyyy HH:mm');

      BookModel bookModel = BookModel(
        // tem como otimizar a edição
        nome: nomeController.text,
        autor: autorController.text,
        ano: int.tryParse(anoController!.text),
        edicao: int.tryParse(edicaoController.text),
        tipoMidia: tipo,
        genero: genero,
        foto: 'Colocar',
        dataCadastro: date.format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch)),
        editora: editoraController!.text,
        dataDisponibilidade: date.format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch)),
        isDeleted: false,
        userloan: null,
        admRecorder: usuario?.uid,
      );

      (!isUpdating) ? await firebaseFirestore.collection("book").add(bookModel.toMap()) : null;
      Fluttertoast.showToast(msg: "Obra salva no sistema!");
      if (isUpdating) {
        // edição
        await firebaseFirestore
            .collection('book')
            .where('nome', isEqualTo: bookModel.nome)
            .where('autor', isEqualTo: bookModel.autor)
            .where('edicao', isEqualTo: bookModel.edicao)
            .get()
            .then(
          (value) {
            firebaseFirestore.collection("book").doc(value.docs.first.id).set(bookModel.toMap());
          },
        );
      }
    } else {
      Fluttertoast.showToast(msg: 'Livro já Cadastrado');
    }
  }

  deleteBook(
    // reduzir pedindo o id pra fazer a mudança
    Map<String, dynamic> obra,
  ) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    obra['isDeleted'] = true;
    await firebaseFirestore
        .collection('book')
        .where('nome', isEqualTo: obra['nome'])
        .where('autor', isEqualTo: obra['autor'])
        .where('edicao', isEqualTo: int.tryParse(obra['nome']))
        .get()
        .then(
      (value) async {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Obra não existe no sistema");
        } else {
          await firebaseFirestore.collection("book").doc(value.docs.first.id).set(obra);
          Fluttertoast.showToast(msg: "Obra Deleta do sistema!");
        }
      },
    );
  }
}
