
import 'package:flutter/material.dart';

void main() {
  runApp(const CosmicExplorerApp());
}

// Planet Data Model
class Planet {
  final String name;
  final String type;
  final String description;

  const Planet({
    required this.name,
    required this.type,
    required this.description,
  });
}

// Planet Catalog
class PlanetCatalog {
  static const List<Planet> planets = [
    Planet(
      name: 'Mercury',
      type: 'Terrestrial',
      description: 'Mercury is the closest planet to the Sun.',
    ),
    Planet(
      name: 'Mars',
      type: 'Terrestrial',
      description: 'Mars is known as the Red Planet.',
    ),
    Planet(
      name: 'Jupiter',
      type: 'Gas Giant',
      description: 'Jupiter is the largest planet in our solar system.',
    ),
    Planet(
      name: 'Kepler-186f',
      type: 'Terrestrial',
      description: 'Kepler-186f is an exoplanet located in the habitable zone of its star.',
    ),
    Planet(
      name: 'Proxima Centauri b',
      type: 'Terrestrial',
      description: 'Proxima Centauri b orbits the closest star to our Sun.',
    ),
  ];
}

// Main Application
class CosmicExplorerApp extends StatelessWidget {
  const CosmicExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cosmic Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: const MissionControl(),
    );
  }
}

// Mission Control Screen
class MissionControl extends StatelessWidget {
  const MissionControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cosmic Explorer - Mission Control',
        ),
      ),
      body: ListView.builder(
        itemCount: PlanetCatalog.planets.length,
        itemBuilder: (context, index) {
          final planet = PlanetCatalog.planets[index];

          return ListTile(
            title: Text(planet.name),
            subtitle: Text(planet.type),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlanetDetail(
                    planet: planet,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Planet Detail Screen
class PlanetDetail extends StatelessWidget {
  final Planet planet;

  const PlanetDetail({
    super.key,
    required this.planet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(planet.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Planet Type: ${planet.type}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              planet.description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// Docking Bay Screen (Retained from Phase 1)
class DockingBay extends StatelessWidget {
  const DockingBay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Docking Bay Telemetry'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Return to Control'),
        ),
      ),
    );
  }
}
