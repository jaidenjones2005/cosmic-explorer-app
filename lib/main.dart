
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
      description:
      'Kepler-186f is an exoplanet located in the habitable zone of its star.',
    ),
    Planet(
      name: 'Proxima Centauri b',
      type: 'Terrestrial',
      description:
      'Proxima Centauri b orbits the closest star to our Sun.',
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

            // Phase 3: Await a result from PlanetDetail
            onTap: () async {
              final String? result =
              await Navigator.push<String>(
                context,
                MaterialPageRoute(
                  builder: (context) => PlanetDetail(
                    planet: planet,
                  ),
                ),
              );

              // Check that the screen is still mounted
              if (!context.mounted) return;

              // Display the returned confirmation
              if (result != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(result),
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
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
            const SizedBox(height: 30),

            // Phase 3: Return a confirmation message
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  'You visited ${planet.name}!',
                );
              },
              child: const Text('Confirm Visit'),
            ),
          ],
        ),
      ),
    );
  }
}

// Docking Bay Screen
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
