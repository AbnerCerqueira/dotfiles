import { $ } from 'bun';
import { join } from 'node:path';

const HOME_DIR = (await $`echo $HOME`.text()).trim();
const DOTFILES_DIR = join(HOME_DIR, 'dotfiles');

const HYPR_DIR = join(DOTFILES_DIR, '.config', 'hypr');

export const DIRS = {
  SCRIPTS: join(DOTFILES_DIR, 'scripts'),
  DOTFILES: DOTFILES_DIR,
  HOME: HOME_DIR,
  HYPR: HYPR_DIR,
};

export const PATHS = {
  WALLPAPERS: join(DOTFILES_DIR, 'wallpapers'),
  HYPR: {
    LOCK: join(HYPR_DIR, 'hyprlock.conf'),
    PAPER: join(HYPR_DIR, 'hyprpaper.conf'),
  },
  MATUGEN: join(DOTFILES_DIR, '.config', 'matugen', 'config.toml'),
};
