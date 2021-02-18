import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'login_bloc.dart';

class LoginPage extends StatelessWidget {

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.blue[900], Colors.red[900]],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 238.0, 0.0));

  @override
  Widget build(BuildContext context) {
    LoginBloc bloc = Modular.get<LoginBloc>();
    bloc.getToken();

    TextEditingController _usernameCtrler = TextEditingController(
      text: bloc.txtUsername,
    );
    TextEditingController _passCtrler = TextEditingController(
      text: bloc.txtPass,
    );

    return Scaffold(
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white,
                    Colors.white,
                    Colors.blue[100].withOpacity(0.5)]),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 28.0, horizontal: 0.0),
                  padding: EdgeInsets.fromLTRB(20, 58, 0, 0),
                  alignment: Alignment.centerLeft,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Color(0xfffafafa).withOpacity(0.7),
                            BlendMode.dst),
                        image: AssetImage('assets/imgbin_blue-green-color.png'),
                        fit: BoxFit.fill),
                  ),
                  child: Text(
                    'Studioh21',
                    style: TextStyle(
                        fontFamily: 'Fredericka',
                        fontSize: 50,
                        //fontWeight: FontWeight.bold,
                        foreground: Paint()..shader = linearGradient),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  alignment: Alignment.center,
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  height: 48,
                  child: TextField(
                    controller: _usernameCtrler,
                    onChanged: bloc.setTxtUsername,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(9.0))),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  height: 48,
                  child: TextField(
                    controller: _passCtrler,
                    onChanged: bloc.setTxtPass,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(9.0))),
                    ),
                  ),
                ),
                RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 1.5),
                    splashColor: Colors.white70,
                    color: Colors.blue[500],
                    highlightColor: Colors.blue[300],
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Text(
                        'LOG IN',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      bloc.login();
                    }),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 18.0, horizontal: 0.0),
                  child: Text('OR'),
                ),
                RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 1.5),
                    splashColor: Colors.white70,
                    color: Colors.blue[500],
                    highlightColor: Colors.blue[300],
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () {}),
                //Text(bloc.tokenModel.requestToken)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
