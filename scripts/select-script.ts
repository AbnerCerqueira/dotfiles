#!/usr/bin/env bun

import { $ } from 'bun';
import { readdir } from 'node:fs/promises';
import { join } from 'node:path';
import { exit } from 'node:process';
import { DIRS } from './utils';

const scriptsDir = DIRS.SCRIPTS;
const acceptedFiles = /\.ts$/;

const files = (await readdir(scriptsDir)).filter(
  (file) =>
    acceptedFiles.test(file) &&
    file !== 'select-script.ts' &&
    file !== 'utils.ts',
);
if (!files.length) {
  exit(1);
}

const selectedScript = (
  await $`printf "%s\n" ${files} | rofi -dmenu -p "scripts"`.text()
).trim();

await $`${join(scriptsDir, selectedScript)}`;
