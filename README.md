# Roblox Lua Learning Resources

This repository contains resources to help you learn Lua programming specifically for the Roblox platform, starting from the basics and progressing through tutorials to a small example game.

## Core Concepts

Get started with the fundamental building blocks.

*   **Introduction to Lua:** Covers the fundamentals of the Lua programming language itself.
    *   See: [`lua.md`](./lua.md)
*   **Roblox 101:** An overview of core Roblox development concepts, the Roblox Studio interface, and key Roblox-specific terminology.
    *   See: [`101.md`](./101.md)

## Roblox Tutorials

These hands-on tutorials guide you through specific Roblox scripting tasks. All tutorials are contained within a single Roblox place file.

*   **Tutorial File:** [`roblox_tutorial.rbxl`](./roblox_tutorial.rbxl)
    *   Open this file in Roblox Studio. The scripts and examples for each numbered tutorial step are likely organized within this place (e.g., in ServerScriptService, StarterGui, Workspace).

### Tutorial Topics:

0.  **Setup:** Understanding folder structure and using the `print` function for debugging.
1.  **Basic Parts:** Placing a simple part into the game's Workspace.
2.  **Modules & Movement:** Creating reusable code with ModuleScripts and scripting basic part movement.
3.  **Scripting Parts:** Creating parts via script, using `wait` (or `task.wait`), and stacking objects.
4.  **Events & GUI:** Responding to part events (like `.Touched`) and interacting with basic Graphical User Interface (GUI) elements.
5.  **Damage Mechanics:** Implementing a simple system for Humanoids taking damage.
6.  **AI Behavior:** Creating a basic non-player character (NPC) or part that chases players.
7.  *(This tutorial step is skipped/marked as ignore).*
8.  **Lighting:** Adjusting and manipulating the game's visual atmosphere using the Lighting service.
9.  **Leaderboards:** Creating and managing player stats displayed on the in-game leaderboard (using leaderstats).
10. **CFrames:** Understanding and utilizing Coordinate Frames (CFrames) for precise positioning and rotation of objects.
11. **Remote Events:** Enabling communication between server-side scripts and client-side LocalScripts using RemoteEvents and RemoteFunctions.

## Example Project: Tag Game

A simple, playable Tag game demonstrating how various concepts can be combined.

*   **Project File:** [`tag.rbxl`](./tag.rbxl)
    *   Open this file in Roblox Studio to explore the code, structure, and play the game.

---

**How to Use:**

*   `.md` files: Open with any text editor or Markdown viewer.
*   `.rbxl` files: Require Roblox Studio to be installed. Open them via the File -> Open menu in Studio or by double-clicking if file associations are set up.




