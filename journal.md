# Cosmic Explorer App — Journal

## Phase 1: The Communications Link

**Prompt:** How does the navigation stack metaphor describe what happens in memory when a user navigates to DockingBay and then taps Return?

The navigation stack works like a stack of screens where the newest screen is placed on top. In my Cosmic Explorer App, MissionControl is the starting screen. When the user clicks Enter Docking Bay, Navigator.push() adds DockingBay to the top of the stack. MissionControl stays underneath it. When the user clicks Return to Control, Navigator.pop() removes DockingBay from the stack and brings MissionControl back into view. This makes navigating between screens easier without having to recreate the original screen every time.