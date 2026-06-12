#!/usr/bin/env bun

import { $ } from 'bun';
import { exit } from 'node:process';

const activeWindow = await $`hyprctl activewindow -j`.json();
const isFloating = activeWindow?.floating;

if (isFloating) {
  await $`hyprctl eval 'hl.dispatch(hl.dsp.window.float())'`;
  exit(0);
}

const windowW = 1600;
const windowH = 900;

await $`hyprctl eval 'hl.dispatch(hl.dsp.window.float())'`;

await $`hyprctl eval 'hl.dispatch(hl.dsp.window.resize({
    x = ${windowW},
    y = ${windowH}
}))'`;
await $`hyprctl eval 'hl.dispatch(hl.dsp.window.center())'`;
