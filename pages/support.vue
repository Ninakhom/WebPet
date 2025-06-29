<template>
  <div class="page-container">
    <div class="page-header">
      <h1>ຊ່ວຍເຫຼືອ</h1>
      <p>ສູນຊ່ວຍເຫຼືອແລະຄູ່ມືການໃຊ້ງານ</p>
    </div>

    <v-row>
      <v-col cols="12" md="6">
        <v-card>
          <v-card-title>ຄູ່ມືການໃຊ້ງານ</v-card-title>
          <v-card-text>
            <v-list>
              <v-list-item v-for="guide in guides" :key="guide.id">
                <template v-slot:prepend>
                  <v-icon :color="guide.color">{{ guide.icon }}</v-icon>
                </template>
                <v-list-item-title>{{ guide.title }}</v-list-item-title>
                <v-list-item-subtitle>{{ guide.description }}</v-list-item-subtitle>
              </v-list-item>
            </v-list>
          </v-card-text>
        </v-card>
      </v-col>

      <v-col cols="12" md="6">
        <v-card>
          <v-card-title>ຕິດຕໍ່ພວກເຮົາ</v-card-title>
          <v-card-text>
            <v-list>
              <v-list-item>
                <template v-slot:prepend>
                  <v-icon color="primary">mdi-phone</v-icon>
                </template>
                <v-list-item-title>ໂທລະສັບ: 020-1234-5678</v-list-item-title>
              </v-list-item>
              <v-list-item>
                <template v-slot:prepend>
                  <v-icon color="primary">mdi-email</v-icon>
                </template>
                <v-list-item-title>ອີເມວ: support@petshop.la</v-list-item-title>
              </v-list-item>
              <v-list-item>
                <template v-slot:prepend>
                  <v-icon color="primary">mdi-clock</v-icon>
                </template>
                <v-list-item-title>ເວລາເປີດ: 8:00 - 18:00</v-list-item-title>
              </v-list-item>
            </v-list>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </div>
</template>

<script setup lang="ts">
import { ref } from "vue";

definePageMeta({
  title: "ຊ່ວຍເຫຼືອ",
  layout: "default",
});

const guides = ref([
  {
    id: 1,
    title: "ວິທີການສັ່ງຊື້ສິນຄ້າ",
    description: "ຄູ່ມືການສັ່ງຊື້ສິນຄ້າຜ່ານລະບົບ",
    icon: "mdi-shopping",
    color: "primary",
  },
  {
    id: 2,
    title: "ການຊໍາລະເງິນ",
    description: "ວິທີການຊໍາລະເງິນທີ່ມີໃຫ້",
    icon: "mdi-credit-card",
    color: "success",
  },
  {
    id: 3,
    title: "ການຈັດສົ່ງ",
    description: "ຂໍ້ມູນການຈັດສົ່ງສິນຄ້າ",
    icon: "mdi-truck",
    color: "info",
  },
]);
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