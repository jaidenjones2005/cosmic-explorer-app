
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

// Phase 4: Declarative GoRouter Configuration
final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MissionControl(),
    ),
    GoRoute(
      path: '/docking-bay',
      builder: (context, state) => const DockingBay(),
    ),
    GoRoute(
      path: '/planet/:id',
      builder: (context, state) {
        final id = int.tryParse(
          state.pathParameters['id'] ?? '',
        );

        if (id == null ||
            id < 0 ||
            id >= PlanetCatalog.planets.length) {
          return const InvalidPlanetScreen();
        }

        final planet = PlanetCatalog.planets[id];

        return PlanetDetail(planet: planet);
      },
    ),
  ],
);

// Main Application
class CosmicExplorerApp extends StatelessWidget {
  const CosmicExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Cosmic Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      routerConfig: appRouter,
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

      // Phase 4: Navigation Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text(
                'IEA Command Systems',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Mission Control'),
              onTap: () {
                Navigator.pop(context);
                context.go('/');
              },
            ),
            ListTile(
              leading: const Icon(Icons.rocket_launch),
              title: const Text('Docking Bay'),
              onTap: () {
                Navigator.pop(context);
                context.go('/docking-bay');
              },
            ),
          ],
        ),
      ),

      // Planet Catalog
      body: ListView.builder(
        itemCount: PlanetCatalog.planets.length,
        itemBuilder: (context, index) {
          final planet = PlanetCatalog.planets[index];

          return ListTile(
            title: Text(planet.name),
            subtitle: Text(planet.type),
            trailing: const Icon(Icons.arrow_forward_ios),

            // Phase 4: Navigate using URL path
            onTap: () async {
              final String? result =
              await context.push<String>(
                '/planet/$index',
              );

              if (!context.mounted) return;

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

            // Return confirmation to Mission Control
            ElevatedButton(
              onPressed: () {
                context.pop(
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
            context.go('/');
          },
          child: const Text('Return to Control'),
        ),
      ),
    );
  }
}

// Fallback for invalid planet IDs
class InvalidPlanetScreen extends StatelessWidget {
  const InvalidPlanetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planet Not Found'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Return to Mission Control'),
        ),
      ),
    );
  }
}
