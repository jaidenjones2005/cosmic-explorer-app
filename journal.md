# Cosmic Explorer App — Journal

## Phase 1: The Communications Link

**Prompt:** How does the navigation stack metaphor describe what happens in memory when a user navigates to DockingBay and then taps Return?

The navigation stack works like a stack of screens where the newest screen is placed on top. In my Cosmic Explorer App, MissionControl is the starting screen. When the user clicks Enter Docking Bay, Navigator.push() adds DockingBay to the top of the stack. MissionControl stays underneath it. When the user clicks Return to Control, Navigator.pop() removes DockingBay from the stack and brings MissionControl back into view. This makes navigating between screens easier without having to recreate the original screen every time.

## Phase 2: The Planetary Database

**Prompt:** Why is ListView.builder preferred over a basic ListView or Column? How is data transferred from PlanetCatalog to PlanetDetail?

ListView.builder is useful because it creates list items as they are needed instead of building every widget at once. This makes the application more efficient, especially when working with larger collections of data.

In my Cosmic Explorer App, PlanetCatalog stores five Planet objects. MissionControl accesses those objects and displays them using ListView.builder. When a user selects a planet, Navigator.push() opens PlanetDetail and passes the selected Planet object through its constructor. This allows the detail screen to display the correct planet information without needing to create another copy of the data.