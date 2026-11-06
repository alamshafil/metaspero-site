/**
 * Site configuration
 * Central configuration for metadata, navigation, external links, and versioning.
 */
export const SITE_CONFIG = {
  name: 'Metaspero',
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
    releases: 'https://github.com/alamshafil/metaspero/releases/latest',
    downloadMacos: 'https://github.com/alamshafil/metaspero/releases/latest/download/Metaspero-macOS-arm64.zip',
    downloadIos: 'https://github.com/alamshafil/metaspero/releases/latest/download/Metaspero-iOS-arm64.ipa',
    newIssue: 'https://github.com/alamshafil/metaspero/issues/new',
    reportTemplate: 'kytyps5-game-emulation.yaml',
    fexCoreDarwin: 'https://github.com/alamshafil/fexcore-darwin',
    websiteRepo: 'https://github.com/alamshafil/metaspero-site',
    kytyPS5Upstream: 'https://github.com/KytyPS5/KytyPS5',
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
