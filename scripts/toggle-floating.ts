#!/usr/bin/env bun

import { $ } from 'bun';
import { exit } from 'node:process';

const activeWindow = await $`hyprctl activewindow -j`.json();
const isFloating = activeWindow?.floating;

if (isFloating) {
  await $`hyprctl dispatch settiled`;
  exit(0);
}

const windowW = 1600;
const windowH = 900;

await $`hyprctl dispatch togglefloating`;
await $`hyprctl dispatch resizeactive exact ${windowW} ${windowH}`;
await $`hyprctl dispatch centerwindow`;
