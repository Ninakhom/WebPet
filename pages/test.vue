<template>
  <div class="page-container">
    <div class="page-header">
      <h1>🧪 Test Page</h1>
      <p>This is a test page to verify routing is working</p>
    </div>

    <v-card>
      <v-card-title>Navigation Test</v-card-title>
      <v-card-text>
        <v-row>
          <v-col cols="12" md="4">
            <v-btn 
              block 
              color="primary" 
              @click="navigateTo('/user')"
              class="mb-2"
            >
              Go to User Management
            </v-btn>
          </v-col>
          <v-col cols="12" md="4">
            <v-btn 
              block 
              color="success" 
              @click="navigateTo('/products')"
              class="mb-2"
            >
              Go to Products
            </v-btn>
          </v-col>
          <v-col cols="12" md="4">
            <v-btn 
              block 
              color="info" 
              @click="navigateTo('/orders')"
              class="mb-2"
            >
              Go to Orders
            </v-btn>
          </v-col>
        </v-row>

        <v-divider class="my-4"></v-divider>

        <div class="text-center">
          <h3>Test Page Loaded Successfully!</h3>
          <p>If you can see this page, routing is working!</p>
        </div>
      </v-card-text>
    </v-card>
  </div>
</template>

<script setup lang="ts">
definePageMeta({
  title: "Test Page",
  layout: "default",
});

const route = useRoute();

const navigateTo = (path: string) => {
  console.log("Navigating to:", path);
  // In Nuxt, we can use navigateTo or router.push
  window.location.href = path;
};
</script>

<style scoped>
.page-container {
  padding: 24px;
}

.page-header {
  margin-bottom: 24px;
}

.page-header h1 {
  font-size: 2rem;
  font-weight: 600;
  color: #1a1a1a;
  margin-bottom: 8px;
}

.page-header p {
  color: #666;
  font-size: 1rem;
}
</style> 