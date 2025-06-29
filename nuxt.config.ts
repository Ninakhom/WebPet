export default defineNuxtConfig({
  compatibilityDate: "2025-05-15",
  nitro: { debug: true, prerender: {} },
  ssr: false,
  devtools: { enabled: true },
  css: ["vuetify/styles", "@mdi/font/css/materialdesignicons.css"],

  build: {
    transpile: ["vuetify"],
  },

  modules: ["@nuxtjs/google-fonts"],
  googleFonts: {
    families: {
      "Noto+Sans+Lao": true,
    },
    display: "swap", // แนะนำให้ใส่ เพื่อให้ฟอนต์โหลดลื่นขึ้น
  },
});
