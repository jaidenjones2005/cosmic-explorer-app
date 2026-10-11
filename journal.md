# Cosmic Explorer App — Journal

## Phase 1: The Communications Link

**Prompt:** How does the navigation stack metaphor describe what happens in memory when a user navigates to DockingBay and then taps Return?

The navigation stack works like a stack of screens where the newest screen is placed on top. In my Cosmic Explorer App, MissionControl is the starting screen. When the user clicks Enter Docking Bay, Navigator.push() adds DockingBay to the top of the stack. MissionControl stays underneath it. When the user clicks Return to Control, Navigator.pop() removes DockingBay from the stack and brings MissionControl back into view. This makes navigating between screens easier without having to recreate the original screen every time.

## Phase 2: The Planetary Database

**Prompt:** Why is ListView.builder preferred over a basic ListView or Column? How is data transferred from PlanetCatalog to PlanetDetail?

ListView.builder is useful because it creates list items as they are needed instead of building every widget at once. This makes the application more efficient, especially when working with larger collections of data.

In my Cosmic Explorer App, PlanetCatalog stores five Planet objects. MissionControl accesses those objects and displays them using ListView.builder. When a user selects a planet, Navigator.push() opens PlanetDetail and passes the selected Planet object through its constructor. This allows the detail screen to display the correct planet information without needing to create another copy of the data.

## Phase 3: The Observation Log

**Journal Prompt:** Explain the flow of data in round-trip navigation. How does MissionControl know when the user has returned from PlanetDetail, and how is the return value captured?

In Phase 3, I added a Confirm Visit button that allows users to confirm when they have visited a planet. When a planet is selected, MissionControl uses Navigator.push() to open the PlanetDetail screen and awaits the result. Once the user clicks Confirm Visit, Navigator.pop() closes the detail screen and sends back a message containing the planet's name.

The await keyword allows MissionControl to wait until the user returns before continuing. I also used context.mounted to make sure the widget is still active before displaying the SnackBar. This helps prevent errors when dealing with asynchronous navigation. The SnackBar then displays a message confirming which planet was visited.

## Phase 4: Mission Command Center

**Journal Prompt:** Contrast imperative navigation with declarative routing. How does modeling routes as URLs make mobile applications more versatile?

In Phase 4, I upgraded my Cosmic Explorer App to use GoRouter instead of relying only on Navigator.push() and Navigator.pop(). Imperative navigation focuses on manually adding and removing screens from the navigation stack, while declarative routing uses defined URL paths to determine which screen should appear.

For example, my application uses /planet/:id to display a specific planet based on its index in the catalog. I also added a navigation drawer that allows users to move between Mission Control and Docking Bay using context.go(). For planet details, I used context.push() so the application can still return confirmation messages.

URL-based routing makes the application more flexible because it supports deep linking and makes navigation easier to manage when deploying to web or mobile platforms.

