const js = require('@eslint/js');
const globals = require('globals');

module.exports = [
  {
    ignores: ['static/**', 'node_modules/**', 'build/**'],
  },
  js.configs.recommended,
  {
    files: ['js/**/*.js'],
    languageOptions: {
      ecmaVersion: 'latest',
      sourceType: 'module',
      globals: {
        ...globals.browser,
        micboard: 'writable',
        VERSION: 'readonly',
      },
    },
  },
  {
    files: ['*.js'],
    languageOptions: {
      sourceType: 'commonjs',
      globals: globals.node,
    },
  },
];
