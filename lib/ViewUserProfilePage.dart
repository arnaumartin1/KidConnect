import 'package:flutter/material.dart';

class ViewUserProfilePage extends StatelessWidget {
  final Map<String, String> userInfo;
  final List<Map<String, String>> services;

  const ViewUserProfilePage({
    super.key,
    required this.userInfo,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Perfil del Usuario',
          style: TextStyle(
            color: Color(0xFF6B8C89),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF6B8C89)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: const Color(0xFF6B8C89),
                child: const Icon(Icons.person, size: 54, color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
            _buildInfoRow('Nombre', userInfo['name'] ?? ''),
            _buildInfoRow('Apellidos', userInfo['surname'] ?? ''),
            _buildInfoRow('Email', userInfo['email'] ?? ''),
            _buildInfoRow('Ciudad', userInfo['city'] ?? ''),
            const SizedBox(height: 32),
            const Text(
              'Todos sus servicios',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B8C89),
              ),
            ),
            const SizedBox(height: 12),
            services.isEmpty
                ? const Text(
                    'Este usuario no ofrece servicios actualmente.',
                    style: TextStyle(color: Color(0xFF6B8C89)),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: services.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final service = services[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        elevation: 2,
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xFF6B8C89),
                            child: Icon(Icons.work, color: Colors.white),
                          ),
                          title: Text(
                            service['title'] ?? '',
                            style: const TextStyle(
                              color: Color(0xFF6B8C89),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(service['description'] ?? ''),
                              Text(
                                '${service['price'] ?? ''} €/h',
                                style: const TextStyle(fontSize: 13, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF6B8C89),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFF6B8C89)),
          ),
          child: Text(value, style: const TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
