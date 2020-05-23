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
          IndicadorProgressoAnimado(
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

class IndicadorProgressoAnimado extends StatefulWidget {
  final double value;

  IndicadorProgressoAnimado({
    @required this.value,
  });

  @override
  State<StatefulWidget> createState() {
    return _IndicadorProgressoAnimadoState();
  }
}

class _IndicadorProgressoAnimadoState extends State<IndicadorProgressoAnimado> with SingleTickerProviderStateMixin {
  AnimationController _controle;
  Animation<Color> _animacaoCor;
  Animation<double> _curvaAnimacao;

  void initState() {
    super.initState();
    _controle = AnimationController(duration: Duration(milliseconds: 1200), vsync: this);

    var trocaCor = TweenSequence([
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.red, end: Colors.orange),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.orange, end: Colors.yellow),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.yellow, end: Colors.green),
        weight: 1,
      ),
    ]);

    _animacaoCor = _controle.drive(trocaCor);
    _curvaAnimacao = _controle.drive(CurveTween(curve: Curves.easeIn));
  }

  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controle.animateTo(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controle,
      builder: (context, child) => LinearProgressIndicator(
        value: _curvaAnimacao.value,
        valueColor: _animacaoCor,
        backgroundColor: _animacaoCor.value.withOpacity(0.4),
      ),
    );
  }
}
