# Metaspero Website

Source code for the official website, documentation, and game compatibility database for Metaspero.

## About the Website

This repository hosts the static site for Metaspero, an experimental PlayStation 5 emulator for Apple Silicon (iPhone, Mac, and iPad).

The website provides:

- Compatibility Database: A searchable list of tested games.
- Interactive Report Generator: A web tool at `/report` for generating formatted test submissions.
- and more.

## About the Emulator

Metaspero is an experimental emulator that enables PlayStation 5 software to run on Apple Silicon hardware (iPhone, iPad, and Mac).

Key technical components:

- Upstream Core: Forked directly from KytyPS5
- CPU Translation: Custom fork of FEXCore 
- iOS JIT Execution: Uses StikDebug with the universal.js script
- Graphics Subsystem: Using MoltenVK
- User Interface: Native SwiftUI application

## Tech Stack

- Framework: Astro (Static Site Generation)
- Styling: Tailwind CSS v4 with `@tailwindcss/vite`
- Typography: `@fontsource/dm-sans`
- Icons: `@lucide/astro`
- Package Manager: npm

## Project Structure

- `src/pages/`: Astro pages and routes (home, compatibility directory, individual report pages, report builder, guides, and FAQ).
- `src/content/compatibility/`: Individual Markdown files for each game report (validated via `src/content.config.ts`).
- `src/config/site.ts`: Central site configuration for project name, links, and navigation.
- `src/components/`: Reusable Astro components (navigation, footer, search table, badges).
- `src/styles/global.css`: Base styles and Tailwind CSS configuration.
- `public/`: Static assets and favicon.

## Local Development

```bash
# Install dependencies
npm install

# Start development server (http://localhost:4321)
npm run dev

# Build static site to /dist
npm run build

# Preview production build locally
npm run preview
```

## Adding Game Compatibility Reports

All game reports are managed using Astro Content Collections as individual Markdown files inside `src/content/compatibility/`.

### Via Pull Request

1. Fork this repository and create a new feature branch:
   ```bash
   git checkout -b report/game-title
   ```
2. Create a new markdown file in `src/content/compatibility/<game-slug>-<platform>.md` (e.g. `src/content/compatibility/astro-playroom-ios.md`).
3. Add the report details in the following format:

```markdown
---
title: "Game Title"
titleId: "PPSA01325"
platform: "iOS" # "iOS" | "macOS"
status: "In game" # "Playable" | "In game" | "Main menu" | "Logo" | "Doesn't boot"
testedDevice: "iPhone 18 Pro"
osVersion: "iOS 27"
fps: "30 FPS"
jitMethod: "StikDebug"
emulatorVersion: "v0.3.0-alpha"
dateReported: "2026-10-28"
reporter: "YourGitHubUsername"
summary: "Runs into gameplay. Memory usage stays within limits."
notes:
  - "Tested with StikDebug universal.js JIT attachment"
  - "Increased memory entitlement enabled for 3D"
knownIssues:
  - "None observed"
---

Optional detailed writeup, logs, and observations go here in standard markdown.
```

4. Run `npm run build` to verify Astro Zod schema validation passes without errors.
5. Commit and push your branch, then open a Pull Request with the title:
   `[Report] Game Title (PPSAXXXXX) - Status` (e.g. `[Report] Astro's Playroom (PPSA01325) - In game`).

### Via the Web Report Generator

1. Navigate to `/report` in the running site.
2. Fill out the report form fields.
3. Click Copy and paste the generated markdown into a new GitHub Issue or save it as a new `.md` file in `src/content/compatibility/`.

### Status Definitions

- Playable: Runs at stable frame rates without game-breaking issues. Can be completed from start to finish.
- In game: Loads into 3D gameplay, but suffers from performance drops, visual glitches, or crashes preventing completion.
- Main menu: Displays intro cutscenes or title menus, but does not enter interactive 3D gameplay.
- Logo: Displays publisher/engine logos or early intro output, but does not reach the main menu.
- Doesn't boot: Crashes on startup due to missing kernel syscalls or memory faults.

## Renaming the Project

The project name is configured centrally in `src/config/site.ts`. Updating `SITE_CONFIG.name` updates the branding across the navbar, footer, metadata, and all pages.

## Legal Disclaimer

Metaspero is an independent, non-commercial open-source research initiative and is not endorsed by, affiliated with, or associated with Sony Interactive Entertainment Inc. PlayStation, PS5, PS4, and DualSense are registered trademarks of Sony Interactive Entertainment Inc. No copyrighted game assets, BIOS files, firmware, or decryption keys are included in this repository.
