import 'package:flutter/material.dart';

void main() => runApp(RomanMultiplierApp());

class RomanMultiplierApp extends StatelessWidget {
  const RomanMultiplierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiplicador Romano',
      home: RomanMultiplierPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RomanMultiplierPage extends StatefulWidget {
  const RomanMultiplierPage({super.key});

  @override
  _RomanMultiplierPageState createState() => _RomanMultiplierPageState();
}

class _RomanMultiplierPageState extends State<RomanMultiplierPage> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();

  String resultadoDecimal = '';
  String resultadoRomano = '';

  final Map<String, int> romanMap = {
    'I': 1,
    'V': 5,
    'X': 10,
    'L': 50,
    'C': 100,
    'D': 500,
    'M': 1000
  };

  int romanToInt(String s) {
    s = s.toUpperCase();
    int result = 0;
    for (int i = 0; i < s.length; i++) {
      int current = romanMap[s[i]]!;
      int next = (i + 1 < s.length) ? (romanMap[s[i + 1]] ?? 0).toInt() : 0;
      if (current < next) {
        result -= current;
      } else {
        result += current;
      }
    }
    return result;
  }

String intToRoman(int number) {
  List<List<dynamic>> romanList = [
    [1000, 'M'],
    [900, 'CM'],
    [500, 'D'],
    [400, 'CD'],
    [100, 'C'],
    [90, 'XC'],
    [50, 'L'],
    [40, 'XL'],
    [10, 'X'],
    [9, 'IX'],
    [5, 'V'],
    [4, 'IV'],
    [1, 'I'],
  ];

  String result = '';
  for (var pair in romanList) {
    while (number >= pair[0]) {
      result += pair[1];
      number -= pair[0] as int;
    }
  }
  return result;
}

  void calcularResultado() {
    try {
      int n1 = romanToInt(controller1.text);
      int n2 = romanToInt(controller2.text);
      int n3 = romanToInt(controller3.text);

      int producto = n1 * n2 * n3;
      if (producto > 3999) {
        setState(() {
          resultadoDecimal = 'Excede el límite (3999)';
          resultadoRomano = '-';
        });
        return;
      }

      setState(() {
        resultadoDecimal = '$producto';
        resultadoRomano = intToRoman(producto);
      });
    } catch (e) {
      setState(() {
        resultadoDecimal = 'Error de entrada';
        resultadoRomano = '-';
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiplicador de Romanos'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Ingrese tres números romanos (I(1) - MMMCMXCIX(3999))',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            TextField(
              controller: controller1,
              decoration: InputDecoration(labelText: 'Número Romano 1'),
            ),
            TextField(
              controller: controller2,
              decoration: InputDecoration(labelText: 'Número Romano 2'),
            ),
            TextField(
              controller: controller3,
              decoration: InputDecoration(labelText: 'Número Romano 3'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcularResultado,
              child: Text('Calcular Multiplicación'),
            ),
            SizedBox(height: 30),
            Text('Resultado Decimal: $resultadoDecimal',
                style: TextStyle(fontSize: 18)),
            Text('Resultado Romano: $resultadoRomano',
                style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
