import 'package:flutter/material.dart';
import '../widgets/custom_navbar.dart';

// Esta clase DEBE llamarse PerfilPage para que coincida con tu routes en main.dart
class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  // Datos del usuario (simulados para edición)
  String _userName = "Juan Pérez";
  String _userRole = "Administrador";
  String _userEmail = "juan.perez@gmail.com";
  String _userPhone = "+57 300 123 4567";

  @override
  Widget build(BuildContext context) {
    // Definición de colores fijos (Modo Claro de Luna Llena)
    const Color backgroundColor = Color(0xFFF8FAFC);
    const Color cardColor = Colors.white;
    const Color textColor = Color(0xFF1E293B);
    const Color subTextColor = Color(0xFF64748B);

    // Sombra suave para las tarjetas
    final List<BoxShadow> cardShadow = [
      BoxShadow(
        color: Colors.black.withOpacity(0.06),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🟠 HEADER NARANJA (Perfil)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 60, bottom: 40),
              decoration: const BoxDecoration(
                color: Color(0xFFFF6B00),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'Mi Perfil',
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),
                  // Foto de perfil limpia (Sin icono de cámara)
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 47,
                      backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    _userName,
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _userRole,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            // SECCIÓN ÚNICA: MI CUENTA
            _buildProfileSectionTitle('Mi Cuenta', subTextColor),
            _buildProfileItem(
              icon: Icons.person_outline,
              title: 'Información Personal',
              textColor: textColor,
              cardColor: cardColor,
              shadows: cardShadow,
              onTap: () => _showPersonalInfoModal(context),
            ),

            const SizedBox(height: 40),

            // BOTÓN CERRAR SESIÓN
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFEBEB),
                    foregroundColor: Colors.red,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout_rounded, size: 20),
                      SizedBox(width: 10),
                      Text('Cerrar Sesión', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavbar(
        currentIndex: 3, // Perfil
        onTap: (index) {
           if (index == 0) Navigator.pushReplacementNamed(context, '/inicio');
           if (index == 1) Navigator.pushReplacementNamed(context, '/maquinaria');
           if (index == 2) Navigator.pushReplacementNamed(context, '/pedidos');
        },
      ),
    );
  }

  Widget _buildProfileSectionTitle(String title, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color, letterSpacing: 1),
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required Color textColor,
    required Color cardColor,
    required List<BoxShadow> shadows,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: shadows,
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFFF6B00).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFFFF6B00), size: 20),
        ),
        title: Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
        trailing: trailing ?? Icon(Icons.chevron_right, color: Colors.grey.shade400),
      ),
    );
  }

  void _showPersonalInfoModal(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: _userName);
    TextEditingController emailController = TextEditingController(text: _userEmail);
    TextEditingController phoneController = TextEditingController(text: _userPhone);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Información Personal',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 8),
            const Text('Actualiza tus datos de contacto y perfil', style: TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 30),
            _buildEditField('Nombre Completo', nameController, Icons.person_outline),
            _buildEditField('Correo Electrónico', emailController, Icons.email_outlined),
            _buildEditField('Número de Teléfono', phoneController, Icons.phone_android_outlined),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _userName = nameController.text;
                    _userEmail = emailController.text;
                    _userPhone = phoneController.text;
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B00),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text('Guardar Cambios', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditField(String label, TextEditingController controller, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: const Color(0xFFFF6B00)),
              filled: true,
              fillColor: const Color(0xFFF1F5F9),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('¿Cerrar Sesión?', style: TextStyle(color: Colors.black)),
        content: const Text('¿Estás seguro de que deseas salir de tu cuenta?', style: TextStyle(color: Color.fromARGB(255, 92, 92, 92))),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar', style: TextStyle(color: Colors.grey))),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
            },
            child: const Text('Sí, salir', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}