import 'package:flutter/material.dart';

// Função principal que inicia o aplicativo
void main() => runApp(const MyApp());

// Definição da classe MyApp, que representa a raiz do aplicativo
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Título da aplicação
  static const appTitle = 'Atividade-07';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle), // Define a tela inicial do app
    );
  }
}

// Classe da página inicial, que pode ter estado dinâmico
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Estado da página inicial
class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0; // Índice para controlar a tela selecionada

  // Lista de telas
  static final List<Widget> _widgetOptions = <Widget>[
    const InicioScreen(),
    const Pagina2Screen(),
    const ConfigScreen(),
    PerfilScreen(),
  ];

  // Método que atualiza a tela selecionada
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // Define o título do AppBar
        backgroundColor: Colors.blue, // Define a cor do AppBar
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu), // Ícone do menu
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Abre o menu lateral
              },
            );
          },
        ),
      ),
      body: _widgetOptions[_selectedIndex], // Exibe a tela selecionada
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Atividade-07 - Dupla: Arthur & Vitória Pereira'), // Identificação da dupla
            ),
            ListTile(
              title: const Text('Início'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0); // Define a tela inicial como ativa
                Navigator.pop(context); // Fecha o Drawer
              },
            ),
            ListTile(
              title: const Text('Página 2'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Configurações'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Perfil'),
              selected: _selectedIndex == 3,
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Tela inicial
class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
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

// Segunda tela
class Pagina2Screen extends StatelessWidget {
  const Pagina2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.pageview, size: 100, color: Colors.green),
          SizedBox(height: 20),
          Text(
            'Página 2',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// Tela de Configurações
class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  bool _isDarkMode = false;
  double _sliderValue = 50;

  @override
  Widget build(BuildContext context) {
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
        Slider(
          value: _sliderValue,
          min: 0,
          max: 100,
          divisions: 10,
          label: _sliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _sliderValue = value;
            });
          },
        ),
      ],
    );
  }
}

// Tela de Perfil
class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  String _nome = "Usuário";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Nome: $_nome", style: const TextStyle(fontSize: 24)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(labelText: "Digite seu nome"),
              onChanged: (valor) {
                setState(() {
                  _nome = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}