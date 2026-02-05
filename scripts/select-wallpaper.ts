#!/usr/bin/env bun

import { $ } from 'bun';
import { readdir, stat } from 'node:fs/promises';
import { join } from 'node:path';
import { exit } from 'node:process';
import { PATHS } from './utils.ts';

const hyprlockPath = PATHS.HYPR.LOCK;
const hyprpaperPath = PATHS.HYPR.PAPER;
const wallpaperPath = PATHS.WALLPAPERS;
const acceptedExtensions = /\.(jpg|jpeg|png)$/i;

const files = await getAvailableWallpapers();

const selectedFile = (
  await $`printf "%s\n" ${files} | rofi -dmenu -p "wallpapers"`.text()
).trim();

if (!selectedFile) {
  exit(0);
}
const selectedFilePath = join(wallpaperPath, selectedFile);

Promise.all([
  updateHyprpaper(selectedFilePath),
  updateHyprlock(selectedFilePath),
  updateThemes(selectedFilePath),
]);

async function getAvailableWallpapers() {
  const foundPath = await stat(wallpaperPath);
  if (!foundPath.isDirectory()) {
    exit(1);
  }

  const files = (await readdir(wallpaperPath)).filter((file) =>
    acceptedExtensions.test(file),
  );
  if (!files.length) {
    exit(1);
  }

  return files;
}

async function updateHyprpaper(selectedFilePath: string) {
  await $`hyprctl hyprpaper wallpaper ', ${selectedFilePath}'`;

  await updateConfigFile(hyprpaperPath, selectedFilePath, 'wallpaper');
}

async function updateHyprlock(selectedFilePath: string) {
  await updateConfigFile(hyprlockPath, selectedFilePath, 'background');
}

async function updateConfigFile(
  configFilePath: string,
  selectedFilePath: string,
  parentKey: string,
) {
  const lines = (await Bun.file(configFilePath).text()).split('\n');

  const backgroundLine = lines.indexOf(`${parentKey} {`);

  if (backgroundLine === -1) {
    exit(0);
  }

  const pathIndex = findPathKey(backgroundLine, lines);

  lines[pathIndex] = `    path = ${selectedFilePath}`;

  Bun.write(configFilePath, lines.join('\n'));
}

function findPathKey(parentKeyIndex: number, lines: string[]) {
  let pathIndex = -1;
  for (let i = parentKeyIndex + 1; i < lines.length; i++) {
    if (lines[i] === '}') {
      break;
    }

    if (lines[i].includes('path')) {
      pathIndex = i;
      break;
    }
  }

  if (pathIndex === -1) {
    exit(1);
  }

  return pathIndex;
}

async function updateThemes(selectedFilePath: string) {
  await $`matugen --config ${PATHS.MATUGEN} image ${selectedFilePath}`;
}
