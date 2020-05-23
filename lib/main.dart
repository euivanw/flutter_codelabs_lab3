import 'package:flutter/material.dart';

void main() => runApp(LoginApp());

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => LoginTela(),
        '/bemvindo': (context) => BoasVindasTela(),
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

class BoasVindasTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Bem-vinda(o)!',
          style: Theme.of(context).textTheme.headline2,
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
      onChanged: () => _atualizaProgressoFormulario(),
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
            onPressed: _progressoFormulario == 1 ? _mostrarTelaBoasVindas : null,
            child: Text('Acessar'),
          ),
        ],
      ),
    );
  }

  void _mostrarTelaBoasVindas() {
    Navigator.of(context).pushNamed('/bemvindo');
  }

  void _atualizaProgressoFormulario() {
    var progresso = 0.0;
    var controles = [
      _primeiroNomeTextController,
      _sobrenomeTextController,
      _nomeDeUsuarioTextController,
    ];

    for (var controller in controles) {
      if (controller.value.text.isNotEmpty) {
        progresso += 1 / controles.length;
      }
    }

    setState(() {
      _progressoFormulario = progresso;
    });
  }
}
