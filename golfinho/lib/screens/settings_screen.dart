import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool blockchainEnabled = false;
  int frequency = 10;
  bool isNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            // Configuración de cuenta
            ListTile(
              title: Text('Change Username'),
              trailing: Icon(Icons.edit),
              onTap: () {
                // Acción para cambiar nombre de usuario
              },
            ),
            ListTile(
              title: Text('Change Email'),
              trailing: Icon(Icons.edit),
              onTap: () {
                // Acción para cambiar correo electrónico
              },
            ),
            ListTile(
              title: Text('Change Password'),
              trailing: Icon(Icons.lock),
              onTap: () {
                // Acción para cambiar contraseña
              },
            ),
            SizedBox(height: 20),

            // Configuración de notificaciones
            SwitchListTile(
              title: Text('Enable Notifications'),
              value: isNotificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  isNotificationsEnabled = value;
                });
              },
              activeColor: Colors.blue,
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
            ),
            SizedBox(height: 20),

            // Configuración de Blockchain
            SwitchListTile(
              title: Text('Enable Blockchain Logging'),
              value: blockchainEnabled,
              onChanged: (bool value) {
                setState(() {
                  blockchainEnabled = value;
                });
              },
              activeColor: Colors.blue,
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
            ),
            SizedBox(height: 20),

            // Configuración de la frecuencia de actualización
            ListTile(
              title: Text('Update Frequency (minutes)'),
              trailing: DropdownButton<int>(
                value: frequency,
                items: [5, 10, 15, 30]
                    .map((e) => DropdownMenuItem<int>(
                          value: e,
                          child: Text('$e min'),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    frequency = value!;
                  });
                },
                icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
              ),
            ),
            SizedBox(height: 30),

            // Botón para guardar los cambios (si es necesario)
            ElevatedButton(
              onPressed: () {
                // Aquí puedes implementar la lógica para guardar los cambios
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Settings saved successfully!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Save Settings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
