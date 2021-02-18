import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/pages/login/repositories/login_repository.dart';
import 'package:studioh21/app/repositories/function_repo.dart';

import 'models/token_model.dart';

class LoginBloc extends Disposable {
  final LoginRepository loginRepository;

  LoginBloc(this.loginRepository);

  TokenModel _tokenModel;

  TokenModel get tokenModel => _tokenModel;

  set tokenModel(TokenModel val) {
    _tokenModel = val;
    notifyListeners();
  }

  Future getToken() async {
    tokenModel = await loginRepository.getToken();
    //print(tokenModel.requestToken);
  }

  String _txtUsername;

  String get txtUsername => _txtUsername;

  setTxtUsername(String val) {
    _txtUsername = val;
    notifyListeners();
  }

  String _txtPass;

  String get txtPass => _txtPass;

  setTxtPass(String val) {
    _txtPass = val;
    notifyListeners();
  }

  //athorized login and get session id

  String _sessionIdStr;

  String get sessionIdStr => _sessionIdStr;

  set sessionIdStr(String val) {
    _sessionIdStr = val;
    notifyListeners();
  }

  Future login() async{
    final loginModel = await loginRepository.isAuthenticUser(txtUsername, txtPass, tokenModel.requestToken);
    if(loginModel.success){
      final newSessionModel = await loginRepository.newSession(tokenModel.requestToken);
      //sessionIdStr = newSessionModel.sessionId;
      Modular.to.pushReplacementNamed('/home', arguments: newSessionModel.sessionId);
    } else {

    }
  }

  void notifyListeners() {}

  @override
  void dispose() {
  }

}
