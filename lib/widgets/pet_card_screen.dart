import 'package:flutter/material.dart';
import 'package:pet_adopt/model/pet_model.dart';
import 'package:pet_adopt/view/pet_desc_screen.dart';
// ignore: unused_import
import 'package:pet_adopt/view/pets_screen.dart';

class PetCardScreen extends StatelessWidget {
  const PetCardScreen({
    super.key,
    required this.dog, // Passando o pet corretamente
  });

  final PetModel dog; // Usando PetModel

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 300,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0.5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                dog.images.isNotEmpty
                    ? dog.images[0]
                    : "https://github.com/kawanwagnner/Pet-s_Day/blob/main/assets/img/default_image.png?raw=true",
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "${dog.name}, ${dog.age} anos", // Exibindo nome e idade
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(bottom: 1.0),
            child: SizedBox(
              height: 30,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PetDescScreen(
                          dog: dog), // Passando o dog para a tela de detalhes
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  "Ver",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
