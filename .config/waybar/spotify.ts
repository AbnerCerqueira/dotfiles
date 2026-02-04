#!/usr/bin/env bun

/**
 * Spotify Waybar Module
 *
 * Usage:
 *   bun spotify.ts                    # Get current status (for display)
 *   bun spotify.ts --action toggle    # Play/Pause
 *   bun spotify.ts --action next      # Next track
 *   bun spotify.ts --action previous  # Previous track
 */

const PLAYER = 'spotify';

interface WaybarOutput {
  text: string;
  tooltip?: string;
  class?: string;
  alt?: string;
}

async function runCommand(cmd: string[]): Promise<string> {
  const proc = Bun.spawn(cmd, {
    stdout: 'pipe',
    stderr: 'pipe',
  });

  const output = await new Response(proc.stdout).text();
  const error = await new Response(proc.stderr).text();

  if (proc.exitCode !== 0 && error) {
    throw new Error(error.trim());
  }

  return output.trim();
}

async function isPlayerRunning(): Promise<boolean> {
  try {
    const players = await runCommand(['playerctl', '-l']);
    return players.includes(PLAYER);
  } catch {
    return false;
  }
}

async function getMetadata(): Promise<{
  title: string;
  artist: string;
  album: string;
  status: 'Playing' | 'Paused' | 'Stopped';
}> {
  const [title, artist, album, status] = await Promise.all([
    runCommand(['playerctl', '-p', PLAYER, 'metadata', 'title']).catch(
      () => '',
    ),
    runCommand(['playerctl', '-p', PLAYER, 'metadata', 'artist']).catch(
      () => '',
    ),
    runCommand(['playerctl', '-p', PLAYER, 'metadata', 'album']).catch(
      () => '',
    ),
    runCommand(['playerctl', '-p', PLAYER, 'status']).catch(() => 'Stopped'),
  ]);

  return {
    title,
    artist,
    album,
    status: status as 'Playing' | 'Paused' | 'Stopped',
  };
}

async function executeAction(action: string): Promise<void> {
  if (!(await isPlayerRunning())) {
    return;
  }

  switch (action) {
    case 'toggle':
      await runCommand(['playerctl', '-p', PLAYER, 'play-pause']);
      break;
    case 'next':
      await runCommand(['playerctl', '-p', PLAYER, 'next']);
      break;
    case 'previous':
      await runCommand(['playerctl', '-p', PLAYER, 'previous']);
      break;
  }
}

function truncateText(text: string, maxLength: number): string {
  if (text.length <= maxLength) return text;
  return text.slice(0, maxLength - 3) + '...';
}

async function getStatusOutput(): Promise<WaybarOutput> {
  if (!(await isPlayerRunning())) {
    return { text: '' };
  }

  const { title, artist, album, status } = await getMetadata();

  if (!title) {
    return { text: '' };
  }

  const isPlaying = status === 'Playing';
  const statusIndicator = isPlaying ? '⏸' : '▶';
  const displayText = truncateText(
    `${statusIndicator} ${title} - ${artist}`,
    35,
  );
  const tooltip = `Música: ${title}\nArtista: ${artist}${album ? `\nÁlbum: ${album}` : ''}\nStatus: ${status}`;

  return {
    text: displayText,
    tooltip,
    class: isPlaying ? 'playing' : 'paused',
    alt: status.toLowerCase(),
  };
}

async function main() {
  const args = process.argv.slice(2);
  const actionIndex = args.indexOf('--action');

  if (actionIndex !== -1 && args[actionIndex + 1]) {
    await executeAction(args[actionIndex + 1]);
    return;
  }

  const output = await getStatusOutput();
  console.log(JSON.stringify(output));
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
