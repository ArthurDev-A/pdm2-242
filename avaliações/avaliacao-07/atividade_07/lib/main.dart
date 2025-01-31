// Còdigo feito por Arthur e Vitória Pereira

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Atividade-07';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _indexSelecionado = 0;
  static final List<Widget> _opcoeswidget = <Widget>[
    const TelaInicio(),
    const TelaConfiguracao(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _indexSelecionado = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: _opcoeswidget[_indexSelecionado],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Atividade-07 - Dupla: Arthur e Vitória Pereira'),
            ),
            ListTile(
                title: const Text('Início'),
                selected: _indexSelecionado == 0,
                onTap: () {
                  _onItemTapped(0);
                  Navigator.pop(context);
                }),
            ListTile(
              title: const Text('Configurações'),
              selected: _indexSelecionado == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TelaInicio extends StatelessWidget {
  const TelaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 100, color: Colors.blue),
          SizedBox(height: 20),
          Text(
            'Tela Inicial',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class TelaConfiguracao extends StatefulWidget {
  const TelaConfiguracao({super.key});

  @override
  TelaConfiguracaoState createState() => TelaConfiguracaoState();
}

class TelaConfiguracaoState extends State<TelaConfiguracao> {
  bool _isDarkMode = false;
  double _slideVolumeValue = 50;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SwitchListTile(
          title: const Text("Modo Escuro"),
          value: _isDarkMode,
          onChanged: (bool value) {
            setState(() {
              _isDarkMode = value;
            });
          },
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              "Volume",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Slider(
          value: _slideVolumeValue,
          min: 0,
          max: 100,
          divisions: 100,
          label: _slideVolumeValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _slideVolumeValue = value;
            });
          },
        )
      ],
    );
  }
}
