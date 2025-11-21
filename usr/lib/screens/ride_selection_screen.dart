import 'package:flutter/material.dart';

class RideSelectionScreen extends StatefulWidget {
  const RideSelectionScreen({super.key});

  @override
  State<RideSelectionScreen> createState() => _RideSelectionScreenState();
}

class _RideSelectionScreenState extends State<RideSelectionScreen> {
  int _selectedRideIndex = 0;

  final List<Map<String, dynamic>> _rideOptions = [
    {
      'name': 'Moto Standard',
      'price': '500 FCFA',
      'time': '3 min',
      'icon': Icons.two_wheeler,
      'desc': 'Rapide et économique',
    },
    {
      'name': 'Moto Confort',
      'price': '800 FCFA',
      'time': '5 min',
      'icon': Icons.sports_motorsports,
      'desc': 'Moto plus récente, casque fourni',
    },
    {
      'name': 'Livraison Colis',
      'price': '600 FCFA',
      'time': '4 min',
      'icon': Icons.local_shipping,
      'desc': 'Envoi de petits colis',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choisir un trajet'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Simulation de l'itinéraire sur la carte
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[200],
              width: double.infinity,
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.route, size: 64, color: Colors.blue),
                        const SizedBox(height: 8),
                        const Text('Aperçu du trajet'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Liste des options
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Adresses
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.my_location, color: Colors.blue, size: 20),
                          const SizedBox(width: 12),
                          const Text('Position actuelle', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 9),
                        height: 20,
                        decoration: const BoxDecoration(
                          border: Border(left: BorderSide(color: Colors.grey)),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.red, size: 20),
                          const SizedBox(width: 12),
                          const Text('Marché Dantokpa', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                
                // Liste des véhicules
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _rideOptions.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final option = _rideOptions[index];
                    final isSelected = _selectedRideIndex == index;
                    
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedRideIndex = index;
                        });
                      },
                      child: Container(
                        color: isSelected ? const Color(0xFFFFF8E1) : Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            // Image/Icone
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(option['icon'], size: 32, color: Colors.black87),
                            ),
                            const SizedBox(width: 16),
                            // Détails
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    option['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    option['desc'],
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    option['time'],
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Prix
                            Text(
                              option['price'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                
                // Bouton de confirmation
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Recherche de chauffeur en cours...')),
                            );
                          },
                          child: Text(
                            'Commander ${_rideOptions[_selectedRideIndex]['name']}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
