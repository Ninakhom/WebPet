import { transformAssetUrls } from "vite-plugin-vuetify";
export default defineNuxtConfig({
  compatibilityDate: "2025-05-15",
  nitro: {
    debug: true,
    prerender: {},
  },
  ssr: false,
  devtools: { enabled: true },
  css: ["vuetify/styles", "@mdi/font/css/materialdesignicons.css"],

  build: {
    transpile: ["vuetify"],
  },

  modules: ["@nuxtjs/google-fonts", "@prisma/nuxt"],
  prisma: {
    generateClient: true,
  },
  googleFonts: {
    families: {
      "Noto+Sans+Lao": true,
    },
    display: "swap",
  },

  runtimeConfig: {
    public: {
      apiBase: "http://localhost:3000/api",
    },
  },
  vite: {
    resolve: {
      alias: {
        ".prisma/client/index-browser":
          "./node_modules/.prisma/client/index-browser.js",
      },
    },
    vue: {
      template: {
        transformAssetUrls,
      },
    },
  },
});
