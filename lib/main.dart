import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Pessoa {
  String nome;
  double peso;
  double altura;

  Pessoa(this.nome, this.peso, this.altura);

  double calcularIMC() {
    return peso / (altura * altura);
  }

  String interpretarIMC() {
    double imc = calcularIMC();
    if (imc < 18.5) {
      return 'Abaixo do peso';
    } else if (imc < 25.0) {
      return 'Peso normal (IMC bom)';
    } else if (imc < 30.0) {
      return 'Sobrepeso';
    } else if (imc < 35.0) {
      return 'Obesidade Grau I';
    } else if (imc < 40.0) {
      return 'Obesidade Grau II';
    } else {
      return 'Obesidade Grau III (grave)';
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
        ),
        body: IMCCalculator(),
      ),
    );
  }
}

class IMCCalculator extends StatefulWidget {
  @override
  _IMCCalculatorState createState() => _IMCCalculatorState();
}

class _IMCCalculatorState extends State<IMCCalculator> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  String resultado = '';
  String interpretacao = '';

  void calcularIMC() {
    String nome = nomeController.text;
    double peso = double.tryParse(pesoController.text) ?? 0;
    double altura = double.tryParse(alturaController.text) ?? 0;

    Pessoa pessoa = Pessoa(nome, peso, altura);
    double imc = pessoa.calcularIMC();
    String interpretacao = pessoa.interpretarIMC();

    setState(() {
      resultado = 'Dados da pessoa:\n'
          'Nome: $nome\n'
          'Peso: $peso kg\n'
          'Altura: $altura m\n'
          'IMC: ${imc.toStringAsFixed(2)}';
      this.interpretacao = 'Classificação: $interpretacao';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            controller: nomeController,
            decoration: InputDecoration(labelText: 'Nome da pessoa'),
          ),
          TextField(
            controller: pesoController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Peso (kg)'),
          ),
          TextField(
            controller: alturaController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Altura (m)'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: calcularIMC,
            child: Text('Calcular IMC'),
          ),
          SizedBox(height: 16.0),
          Text(
            resultado,
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            interpretacao,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
