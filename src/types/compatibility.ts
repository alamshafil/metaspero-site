export type CompatibilityStatus = 'In game' | 'Main menu' | 'Logo' | "Doesn't boot";
export type Platform = 'iOS' | 'macOS';

export interface GameReport {
  id: string;
  title: string;
  titleId: string; // PPSA only
  platform: Platform;
  status: CompatibilityStatus;
  testedDevice: string;
  osVersion: string;
  fps: string;
  jitMethod: string;
  emulatorVersion: string;
  dateReported: string;
  reporter: string;
  notes: string[];
  screenshot?: string;
}

export const STATUS_DEFINITIONS: Record<
  CompatibilityStatus,
  { label: string; description: string; dotClass: string; textClass: string; barClass: string }
> = {
  'In game': {
    label: 'In game',
    description: 'Enters 3D gameplay and playable with frame rates.',
    dotClass: 'bg-emerald-500',
    textClass: 'text-emerald-700',
    barClass: 'bg-emerald-500',
  },
  'Main menu': {
    label: 'Main menu',
    description: 'Displays intro screens or main menu, but hangs or crashes before gameplay.',
    dotClass: 'bg-amber-500',
    textClass: 'text-amber-700',
    barClass: 'bg-amber-500',
  },
  Logo: {
    label: 'Logo',
    description: 'Displays publisher/engine logos or early intro output, but does not reach the main menu.',
    dotClass: 'bg-orange-500',
    textClass: 'text-orange-700',
    barClass: 'bg-orange-500',
  },
  "Doesn't boot": {
    label: "Doesn't boot",
    description: 'Crashes on startup due to missing kernel syscalls, memory allocation failures, or CPU faults.',
    dotClass: 'bg-zinc-400',
    textClass: 'text-zinc-600',
    barClass: 'bg-zinc-400',
  },
};
