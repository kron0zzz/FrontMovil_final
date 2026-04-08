import 'package:flutter/material.dart';
import '../dashboard/dashboard_mobile.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String errorMessage = "";

  // 🔐 Credenciales "seguras" (sí, en duro... no me mires así)
  final String correctEmail = "admin@makandsmr.com";
  final String correctPassword = "admin123";

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email == correctEmail && password == correctPassword) {
      // ✅ Login correcto
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardMobile(),
        ),
      );
    } else {
      // ❌ Error
      setState(() {
        errorMessage = "Credenciales incorrectas, intenta nuevamente";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 240, 220),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 40),

                // 🔥 Logo
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 115, 0),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      "M",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  "MakandSMR",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                const Text(
                  "Sistema Móvil de Gestión de Alquiler",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),

                const SizedBox(height: 30),

                // 🔥 Card Login
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "Iniciar Sesión",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text("Usuario"),
                      const SizedBox(height: 6),

                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "tu-email@makandsmr.com",
                          prefixIcon: const Icon(Icons.email_outlined),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Text("Contraseña"),
                      const SizedBox(height: 6),

                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "••••••••",
                          prefixIcon: const Icon(Icons.lock_outline),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      // ❌ Mensaje de error
                      if (errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            errorMessage,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),

                      const SizedBox(height: 20),

                      // 🔥 Botón
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 115, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: login,
                          child: const Text(
                            "Iniciar Sesión",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Center(
                        child: Text(
                          "Recuperar contraseña vía Administrador",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "© 2024 MakandSMR. Todos los derechos reservados.",
                  style: TextStyle(fontSize: 10, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}