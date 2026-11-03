import { z } from 'astro/zod';
import { defineCollection } from 'astro:content';
import { glob } from 'astro/loaders';

const compatibility = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/compatibility' }),
  schema: z.object({
    title: z.string(),
    titleId: z.string().regex(/^PPSA\d{5}$/, 'Title ID must be a valid PS5 PPSA ID (e.g. PPSA01325)'),
    platform: z.enum(['iOS', 'macOS']),
    status: z.enum(['In game', 'Main menu', 'Logo', "Doesn't boot"]),
    testedDevice: z.string(),
    osVersion: z.string(),
    fps: z.string(),
    jitMethod: z.string(),
    emulatorVersion: z.string().default('0.1.0'),
    dateReported: z.string(),
    reporter: z.string(),
    notes: z.array(z.string()).default([]),
    screenshot: z.string().optional(),
  }),
});

export const collections = { compatibility };
