# Healer Utilities (WoW Classic Addon)

**Healer Utilities** is a lightweight World of Warcraft Classic addon designed specifically for healers. It adds a draggable water button that shows the best available water, complete with a cooldown swipe, dynamic tooltip, and visibility toggle based on mana thresholds.

### Features

- Displays your best water automatically with a single-click use button.
- Only visible if your role is set to "Healer" and you use mana.
- Auto-hides when mana is above 75%.
- Cooldown swipe (GCD) after water is used.
- Mana percentage alerts in party chat at 75%, 50%, 25%, 10%, and 0%.
- Tooltips show correct drink item or fallback message.
- Role detection on login, world entry, and group changes.
- Draggable and saves button position.
- Slash command `/hutil debug` to toggle debug mode.

### Installation

1. Download and unzip the addon folder.
2. Move the entire `HealerUtils` folder into your `Interface/AddOns` directory
3. Restart WoW or reload your UI with `/reload`.

### Debug Mode

Use `/hutil debug` in-game to toggle debug logging.

---

### License

This project is open-source and released under the MIT License. See `LICENSE` for more details.
