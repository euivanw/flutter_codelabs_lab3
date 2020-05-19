import 'package:flutter/material.dart';

void main() => runApp(LoginApp());

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => LoginTela(),
      },
    );
  }
}

class LoginTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: FormularioLogin(),
          ),
        ),
      ),
    );
  }
}

class FormularioLogin extends StatefulWidget {
  @override
  _FormularioLoginState createState() => _FormularioLoginState();
}

class _FormularioLoginState extends State<FormularioLogin> {
  final _primeiroNomeTextController = TextEditingController();
  final _sobrenomeTextController = TextEditingController();
  final _nomeDeUsuarioTextController = TextEditingController();

  double _progressoFormulario = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(
            value: _progressoFormulario,
          ),
          Text(
            'Acesso',
            style: Theme.of(context).textTheme.headline4,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _primeiroNomeTextController,
              decoration: InputDecoration(
                hintText: 'Primeiro nome',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _sobrenomeTextController,
              decoration: InputDecoration(
                hintText: 'Sobrenome',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nomeDeUsuarioTextController,
              decoration: InputDecoration(
                hintText: 'Nome de usuário',
              ),
            ),
          ),
          FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: null,
            child: Text('Acessar'),
          ),
        ],
      ),
    );
  }
}
