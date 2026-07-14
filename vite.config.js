import { defineConfig } from 'vite';
import { resolve } from 'path';

export default defineConfig({
  build: {
    rollupOptions: {
      input: {
        main: resolve(__dirname, 'index.html'),
        about: resolve(__dirname, 'about/index.html'),
        thoughts: resolve(__dirname, 'thoughts/index.html'),
        anthropic: resolve(__dirname, 'thoughts/anthropic-is-a-cartel/index.html'),
        reading: resolve(__dirname, 'reading/index.html'),
        listening: resolve(__dirname, 'listening/index.html'),
        photos: resolve(__dirname, 'photos/index.html'),
        experiments: resolve(__dirname, 'experiments/index.html'),
        research: resolve(__dirname, 'research/index.html')
      }
    }
  }
});
