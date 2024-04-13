import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final messages = [
      'Cargando peliculas',
      'Comprando palomitas de maiz',
      'Llamando a mi pareja',
      'Ya mero...',
      'Esto esta tardando mas de lo esperado :c',
    ];

    Stream<String> getLoadingMessages() {
      return Stream.periodic(const Duration(milliseconds: 2000), (step) {
        return messages[step];
      }).take(messages.length);
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere por favor'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text('Cargando...');
              }

              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}
