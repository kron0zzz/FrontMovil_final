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
  String _userRole = "Administrador de Equipos";
  String _userEmail = "juan.perez@empresa.com";
  String _userPhone = "+57 300 123 4567";

  // Estado local temporal para que el switch funcione visualmente
  // Nota: Para que afecte a toda la app, esto debe moverse al main.dart con Provider
  bool _isDarkModeLocal = false;

  @override
  Widget build(BuildContext context) {
    // Usamos el estado local para definir los colores en esta pantalla
    final bool isDarkMode = _isDarkModeLocal;

    final Color backgroundColor = isDarkMode ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC);
    final Color cardColor = isDarkMode ? const Color(0xFF1E293B) : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : const Color(0xFF1E293B);
    final Color subTextColor = isDarkMode ? Colors.white70 : const Color(0xFF64748B);

    // Sombra adaptativa
    final List<BoxShadow> cardShadow = [
      BoxShadow(
        color: isDarkMode ? Colors.black26 : Colors.black.withOpacity(0.06),
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
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 47,
                          backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: const Icon(Icons.camera_alt, color: Color(0xFFFF6B00), size: 18),
                      ),
                    ],
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

            // SECCIÓN: MI CUENTA
            _buildProfileSectionTitle('Mi Cuenta', subTextColor),
            _buildProfileItem(
              icon: Icons.person_outline,
              title: 'Información Personal',
              textColor: textColor,
              cardColor: cardColor,
              shadows: cardShadow,
              onTap: () => _showPersonalInfoModal(context, isDarkMode),
            ),

            // SECCIÓN: PREFERENCIAS
            _buildProfileSectionTitle('Preferencias', subTextColor),
            _buildProfileItem(
              icon: Icons.dark_mode_outlined,
              title: 'Modo Oscuro',
              textColor: textColor,
              cardColor: cardColor,
              shadows: cardShadow,
              trailing: Switch(
                value: _isDarkModeLocal,
                activeColor: const Color(0xFFFF6B00),
                onChanged: (value) {
                  setState(() {
                    _isDarkModeLocal = value;
                  });
                  // Aquí es donde en el futuro llamarás a tu función global:
                  // themeProvider.toggleTheme();
                },
              ),
            ),

            const SizedBox(height: 20),

            // BOTÓN CERRAR SESIÓN
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showLogoutDialog(context, isDarkMode);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode ? Colors.red.withOpacity(0.1) : const Color(0xFFFFEBEB),
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
        currentIndex: 3, // Indice de perfil
        onTap: (index) {
           if (index == 0) Navigator.pushReplacementNamed(context, '/inicio');
           if (index == 1) Navigator.pushReplacementNamed(context, '/maquinaria');
           if (index == 2) Navigator.pushReplacementNamed(context, '/pedidos');
        },
      ),
    );
  }

  // Títulos de sección del perfil
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

  // Items de la lista del perfil
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

  // MODAL: INFORMACIÓN PERSONAL (Editable)
  void _showPersonalInfoModal(BuildContext context, bool isDarkMode) {
    TextEditingController nameController = TextEditingController(text: _userName);
    TextEditingController emailController = TextEditingController(text: _userEmail);
    TextEditingController phoneController = TextEditingController(text: _userPhone);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
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
            Text(
              'Información Personal',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 8),
            const Text('Actualiza tus datos de contacto y perfil', style: TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 30),
            _buildEditField('Nombre Completo', nameController, Icons.person_outline, isDarkMode),
            _buildEditField('Correo Electrónico', emailController, Icons.email_outlined, isDarkMode),
            _buildEditField('Número de Teléfono', phoneController, Icons.phone_android_outlined, isDarkMode),
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

  Widget _buildEditField(String label, TextEditingController controller, IconData icon, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: const Color(0xFFFF6B00)),
              filled: true,
              fillColor: isDarkMode ? Colors.white.withOpacity(0.05) : const Color(0xFFF1F5F9),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ],
      ),
    );
  }

  // DIÁLOGO: CERRAR SESIÓN
  void _showLogoutDialog(BuildContext context, bool isDarkMode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('¿Cerrar Sesión?', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
        content: Text('¿Estás seguro de que deseas salir de tu cuenta?', style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.grey)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar', style: TextStyle(color: Colors.grey))),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/maquinaria', (route) => false);
            },
            child: const Text('Sí, salir', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}