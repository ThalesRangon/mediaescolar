import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const MediaEscolarPage(),
    );
  }
}

class MediaEscolarPage extends StatefulWidget {
  const MediaEscolarPage({super.key});

  @override
  State<MediaEscolarPage> createState() => _MediaEscolarPageState();
}

class _MediaEscolarPageState extends State<MediaEscolarPage> {

  // Controladores dos campos
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController nota1Controller = TextEditingController();
  final TextEditingController nota2Controller = TextEditingController();
  final TextEditingController nota3Controller = TextEditingController();
  final TextEditingController nota4Controller = TextEditingController();
  final TextEditingController frequenciaController =
      TextEditingController();

  // Variáveis para mostrar os resultados
  String nomeAluno = '';
  String situacao = '';

  double media = 0;
  double maiorNota = 0;
  double menorNota = 0;
  double pontosFaltantes = 0;
  double frequencia = 0;

  void calcularMedia() {

    // Nome do aluno
    String nome = nomeController.text.trim();

    // Conversão das notas
    double? nota1 = double.tryParse(
      nota1Controller.text.replaceAll(",", "."),
    );

    double? nota2 = double.tryParse(
      nota2Controller.text.replaceAll(",", "."),
    );

    double? nota3 = double.tryParse(
      nota3Controller.text.replaceAll(",", "."),
    );

    double? nota4 = double.tryParse(
      nota4Controller.text.replaceAll(",", "."),
    );

    // Conversão da frequência
    double? frequenciaAluno = double.tryParse(
      frequenciaController.text.replaceAll(",", "."),
    );

    // Verifica se todos os campos foram preenchidos
    if (nome.isEmpty ||
        nota1 == null ||
        nota2 == null ||
        nota3 == null ||
        nota4 == null ||
        frequenciaAluno == null) {

      mostrarMensagem(
        'Preencha todos os campos corretamente.',
      );

      return;
    }

    // Validação das notas
    if (nota1 < 0 ||
        nota1 > 10 ||
        nota2 < 0 ||
        nota2 > 10 ||
        nota3 < 0 ||
        nota3 > 10 ||
        nota4 < 0 ||
        nota4 > 10) {

      mostrarMensagem(
        'As notas devem estar entre 0 e 10.',
      );

      return;
    }

    // Validação da frequência
    if (frequenciaAluno < 0 ||
        frequenciaAluno > 100) {

      mostrarMensagem(
        'A frequência deve estar entre 0% e 100%.',
      );

      return;
    }

    // Lista com as quatro notas
    List<double> notas = [
      nota1,
      nota2,
      nota3,
      nota4,
    ];

    // Calcula a média
    double mediaCalculada =
        (nota1 + nota2 + nota3 + nota4) / 4;

    // Descobre a maior nota
    double maior = notas.reduce(
      (a, b) => a > b ? a : b,
    );

    // Descobre a menor nota
    double menor = notas.reduce(
      (a, b) => a < b ? a : b,
    );

    // Calcula quantos pontos faltaram para chegar a 7
    double pontosNecessarios =
        mediaCalculada >= 7
            ? 0
            : 7 - mediaCalculada;

    // Verifica a situação do aluno
    String situacaoCalculada;

    if (frequenciaAluno < 75) {

      situacaoCalculada = 'REPROVADO POR FALTA';

    } else if (mediaCalculada >= 7) {

      situacaoCalculada = 'APROVADO';

    } else if (mediaCalculada >= 5) {

      situacaoCalculada = 'RECUPERAÇÃO';

    } else {

      situacaoCalculada = 'REPROVADO';
    }

    // Atualiza a tela
    setState(() {
      nomeAluno = nome;
      media = mediaCalculada;
      maiorNota = maior;
      menorNota = menor;
      pontosFaltantes = pontosNecessarios;
      frequencia = frequenciaAluno;
      situacao = situacaoCalculada;
    });
  }

  // Mostra mensagem na tela
  void mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
      ),
    );
  }

  // Limpa todos os campos
  void resetarCampos() {

    nomeController.clear();
    nota1Controller.clear();
    nota2Controller.clear();
    nota3Controller.clear();
    nota4Controller.clear();
    frequenciaController.clear();

    setState(() {
      nomeAluno = '';
      media = 0;
      maiorNota = 0;
      menorNota = 0;
      pontosFaltantes = 0;
      frequencia = 0;
      situacao = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Calculadora de Média",
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch,

          children: [

            const Icon(
              Icons.school,
              size: 80,
            ),

            const SizedBox(height: 10),

            const Text(
              'Média Escolar',
              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Digite o nome, as quatro notas e a frequência',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 25),

            // NOME
            TextField(
              controller: nomeController,

              decoration: const InputDecoration(
                labelText: 'Nome do aluno',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
                hintText: 'Exemplo: Henry',
              ),
            ),

            const SizedBox(height: 15),

            // NOTA 1
            TextField(
              controller: nota1Controller,

              decoration: const InputDecoration(
                labelText: 'Nota 1',
                hintText: 'Digite uma nota de 0 a 10',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),

              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),

            const SizedBox(height: 15),

            // NOTA 2
            TextField(
              controller: nota2Controller,

              decoration: const InputDecoration(
                labelText: 'Nota 2',
                hintText: 'Digite uma nota de 0 a 10',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),

              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),

            const SizedBox(height: 15),

            // NOTA 3
            TextField(
              controller: nota3Controller,

              decoration: const InputDecoration(
                labelText: 'Nota 3',
                hintText: 'Digite uma nota de 0 a 10',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),

              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),

            const SizedBox(height: 15),

            // NOTA 4
            TextField(
              controller: nota4Controller,

              decoration: const InputDecoration(
                labelText: 'Nota 4',
                hintText: 'Digite uma nota de 0 a 10',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),

              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),

            const SizedBox(height: 15),

            // FREQUÊNCIA
            TextField(
              controller: frequenciaController,

              decoration: const InputDecoration(
                labelText: 'Frequência (%)',
                hintText: 'Digite de 0 a 100',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.percent),
              ),

              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),

            const SizedBox(height: 20),

            // BOTÃO CALCULAR
            ElevatedButton.icon(
              onPressed: calcularMedia,

              icon: const Icon(
                Icons.calculate,
              ),

              label: const Text(
                'Calcular média',
              ),
            ),

            const SizedBox(height: 10),

            // BOTÃO RESETAR
            OutlinedButton.icon(
              onPressed: resetarCampos,

              icon: const Icon(
                Icons.refresh,
              ),

              label: const Text(
                'Resetar campos',
              ),
            ),

            const SizedBox(height: 20),

            // RESULTADO
            if (situacao.isNotEmpty)

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    children: [

                      Text(
                        nomeAluno,

                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        'Média: ${media.toStringAsFixed(1)}',

                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Maior nota: ${maiorNota.toStringAsFixed(1)}',

                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Menor nota: ${menorNota.toStringAsFixed(1)}',

                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Frequência: ${frequencia.toStringAsFixed(1)}%',

                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        pontosFaltantes > 0
                            ? 'Faltaram ${pontosFaltantes.toStringAsFixed(1)} pontos para atingir 7,0'
                            : 'Nota mínima para aprovação atingida',

                        textAlign: TextAlign.center,

                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        situacao,

                        textAlign: TextAlign.center,

                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}