<template>
  <div>
    <h1>Dashboard</h1>
    <v-card class="mt-4">
      <v-card-title>Welcome to Dashboard</v-card-title>
      <v-card-text>
        This is your dashboard. The navbar stays persistent and only this
        content changes.
      </v-card-text>
    </v-card>
  </div>
</template>

<script setup lang="ts">
// Check if user is logged in
onMounted(() => {});
</script>