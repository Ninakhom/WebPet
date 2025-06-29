<template>
  <v-app>
    <Sidebar />

    <v-main class="main-content-area">
      <slot />
    </v-main>
  </v-app>
</template>

<script setup lang="ts">
// This part is already correct!
import Sidebar from "@/components/drawer.vue";
</script>

<style>
/* Applying the font to the Vuetify app for better consistency */
.v-application {
  font-family: "Noto Sans Lao", sans-serif !important;
}

/* You can set a default background for your main content area here */
.main-content-area {
  background-color: #f1f5f9; /* Light grey background */
}
</style>