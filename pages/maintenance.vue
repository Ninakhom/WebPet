<template>
  <div class="page-container">
    <div class="page-header">
      <h1>ບໍາລຸງຮັກສາ</h1>
      <p>ການບໍາລຸງຮັກສາລະບົບແລະການອັບເດດ</p>
    </div>

    <v-row>
      <v-col cols="12" md="8">
        <v-card>
          <v-card-title>ສະຖານະລະບົບ</v-card-title>
          <v-card-text>
            <v-list>
              <v-list-item v-for="status in systemStatus" :key="status.id">
                <template v-slot:prepend>
                  <v-icon :color="status.color">{{ status.icon }}</v-icon>
                </template>
                <v-list-item-title>{{ status.name }}</v-list-item-title>
                <v-list-item-subtitle>{{ status.description }}</v-list-item-subtitle>
                <template v-slot:append>
                  <v-chip :color="status.statusColor" size="small">
                    {{ status.status }}
                  </v-chip>
                </template>
              </v-list-item>
            </v-list>
          </v-card-text>
        </v-card>
      </v-col>

      <v-col cols="12" md="4">
        <v-card>
          <v-card-title>ການອັບເດດລ່າສຸດ</v-card-title>
          <v-card-text>
            <v-timeline>
              <v-timeline-item
                v-for="update in updates"
                :key="update.id"
                :dot-color="update.color"
                size="small"
              >
                <div class="text-caption">{{ update.date }}</div>
                <div class="text-body-2">{{ update.title }}</div>
              </v-timeline-item>
            </v-timeline>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </div>
</template>

<script setup lang="ts">
import { ref } from "vue";

definePageMeta({
  title: "ບໍາລຸງຮັກສາ",
  layout: "default",
});

const systemStatus = ref([
  {
    id: 1,
    name: "ເຊີເວີຫຼັກ",
    description: "ສະຖານະເຊີເວີຫຼັກ",
    status: "ປົກກະຕິ",
    icon: "mdi-server",
    color: "primary",
    statusColor: "success",
  },
  {
    id: 2,
    name: "ຖານຂໍ້ມູນ",
    description: "ການເຊື່ອມຕໍ່ຖານຂໍ້ມູນ",
    status: "ປົກກະຕິ",
    icon: "mdi-database",
    color: "info",
    statusColor: "success",
  },
  {
    id: 3,
    name: "ການສຳຮອງຂໍ້ມູນ",
    description: "ການສຳຮອງຂໍ້ມູນອັດຕະໂນມັດ",
    status: "ກໍາລັງດໍາເນີນການ",
    icon: "mdi-backup-restore",
    color: "warning",
    statusColor: "warning",
  },
]);

const updates = ref([
  {
    id: 1,
    title: "ອັບເດດລະບົບເປັນວົງຈອນ",
    date: "2024-01-15",
    color: "success",
  },
  {
    id: 2,
    title: "ແກ້ໄຂບັນຫາການເຂົ້າສູ່ລະບົບ",
    date: "2024-01-14",
    color: "info",
  },
  {
    id: 3,
    title: "ອັບເດດຄຸນສົມບັດໃໝ່",
    date: "2024-01-13",
    color: "primary",
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