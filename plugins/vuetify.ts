import { defineNuxtPlugin } from "#app";
import { createVuetify } from "vuetify";
import * as components from "vuetify/components";
import * as directives from "vuetify/directives";
import "vuetify/styles";
import "@mdi/font/css/materialdesignicons.css";

export default defineNuxtPlugin((nuxtApp) => {
  const vuetify = createVuetify({
    components,
    directives,
    ssr: true,
    defaults: {
      global: {
        style: {
          fontFamily: "Noto Sans Lao",
        },
      },
    },
  });

  nuxtApp.vueApp.use(vuetify);
});
