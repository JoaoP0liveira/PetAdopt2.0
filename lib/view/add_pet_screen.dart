// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pet_adopt/controller/pet_controller.dart';

class AddPetScreen extends StatelessWidget {
  AddPetScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController storyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final PetController petController = PetController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFDF7F2), // Fundo aconchegante
        appBar: AppBar(
          backgroundColor: const Color(0xFF4682B4), // Azul pastel
          title: const Text(
            "Adicionar Pet para Adoção",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const Spacer(flex: 1),

              // Ícone e Header
              const Column(
                children: [
                  Icon(
                    Icons.pest_control_rodent_rounded,
                    size: 80,
                    color: Color(0xFF4682B4),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Adicione um novo pet!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 1),

              // Campos de entrada
              _buildTextField(
                nameController,
                "Nome do Pet",
                prefixIcon: Icons.edit,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                ageController,
                "Idade do Pet",
                keyboardType: TextInputType.number,
                prefixIcon: Icons.cake,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                weightController,
                "Peso do Pet (kg)",
                keyboardType: TextInputType.number,
                prefixIcon: Icons.line_weight,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                colorController,
                "Cor do Pet",
                prefixIcon: Icons.color_lens,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                storyController,
                "História do Pet",
                prefixIcon: Icons.color_lens,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                imageController,
                "URL da Imagem do Pet",
                prefixIcon: Icons.link,
              ),
              const Spacer(),

              // Botão de Adicionar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await petController.addPet(
                        name: nameController.text,
                        age: int.parse(ageController.text),
                        weight: double.parse(weightController.text),
                        color: colorController.text,
                        story: storyController.text,
                        images: [imageController.text],
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Pet cadastrado com sucesso!'),
                        ),
                      );
                      Navigator.of(context).pop();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Erro: $e')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4682B4),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Adicionar Pet",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    TextInputType? keyboardType,
    IconData? prefixIcon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: const Color(0xFF4682B4)),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFFE8F1F6), // Fundo suave para o campo
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }
}
