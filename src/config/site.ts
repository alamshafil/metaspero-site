/**
 * Site configuration
 * Central configuration for metadata, navigation, external links, and versioning.
 */
export const SITE_CONFIG = {
  name: 'Metaspero',
  shortName: 'Metaspero',
  tagline: 'PS5 Emulator for iOS & macOS',
  description: 'An open-source PlayStation 5 emulator forked from KytyPS5. Uses FEXCore for CPU translation, MoltenVK for graphics, and a native Swift app for iOS and macOS.',
  url: 'https://alamshafil.github.io/metaspero-site',
  themeColor: '#f5f5f7',
  author: {
    name: 'Shafil Alam',
    url: 'https://shafilalam.com',
  },
  links: {
    github: 'https://github.com/alamshafil/metaspero',
    issues: 'https://github.com/alamshafil/metaspero/issues',
    reportIssue: 'https://github.com/alamshafil/metaspero/issues/new?template=game_report.yml',
    fexCoreDarwin: 'https://github.com/alamshafil/fexcore-darwin',
    websiteRepo: 'https://github.com/alamshafil/metaspero-site',
    kytyPS5Upstream: 'https://github.com/KytyPS5/KytyPS5',
    fexEmu: 'https://github.com/FEX-Emu/FEX',
    moltenVk: 'https://github.com/KhronosGroup/MoltenVK',
  },
  platforms: {
    ios: 'iOS 18 to iOS 27 (ARM64 with JIT)',
    macos: 'macOS 26 (Apple Silicon)',
    recommendedIos: 'iPhone 16-18 Pro or newer / iPad Pro (M5)',
  },
  versions: {
    appVersion: '0.1.0',
  },
  nav: [
    { label: 'Compatibility', href: '/metaspero-site/compatibility' },
    { label: 'Submit Report', href: '/metaspero-site/report' },
    { label: 'Compile Guide', href: '/metaspero-site/docs/compile' },
    { label: 'FAQ', href: '/metaspero-site/faq' },
  ],
};
