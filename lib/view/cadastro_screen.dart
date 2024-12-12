import 'package:flutter/material.dart';
import 'package:pet_adopt/view/login_screen.dart';
import '../controller/user_controller.dart';
import '../model/user_model.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _userController = UserController();
  final _formKey = GlobalKey<FormState>();
  final _user = UserModel();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_passwordController.text.trim() !=
          _confirmpasswordController.text.trim()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("As senhas não coincidem!")),
        );
        return;
      }

      _user.password = _passwordController.text;
      _user.confirmpassword = _confirmpasswordController.text;

      final message = await _userController.registerUser(_user);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );

      if (message == 'Usuário cadastrado com sucesso!') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
        ),
        backgroundColor: Colors.blue[50], // Fundo azul claro
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const Spacer(flex: 1),
              // Header com ícone estilizado
              const Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Cadastro",
                    style: TextStyle(fontSize: 36, color: Colors.black54),
                  ),
                ],
              ),
              const Spacer(flex: 1),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person, color: Colors.blue[800]),
                        hintText: "Digite seu nome",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSaved: (value) => _user.name = value!,
                      validator: (value) =>
                          value!.isEmpty ? "Nome é obrigatório" : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: Colors.blue[800]),
                        hintText: "Digite seu email",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSaved: (value) => _user.email = value!,
                      validator: (value) =>
                          value!.isEmpty ? "Email é obrigatório" : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone, color: Colors.blue[800]),
                        hintText: "Digite seu telefone",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSaved: (value) => _user.phone = value!,
                      validator: (value) =>
                          value!.isEmpty ? "Telefone é obrigatório" : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Colors.blue[800]),
                        hintText: "Digite sua senha",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Senha é obrigatória" : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _confirmpasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Colors.blue[800]),
                        hintText: "Confirme sua senha",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Confirmação de senha é obrigatória";
                        }
                        if (value.trim() != _passwordController.text.trim()) {
                          return "As senhas não coincidem";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // Botão de Cadastro
              ElevatedButton(
                onPressed: _registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Cadastrar",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
