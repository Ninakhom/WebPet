<template>
  <div class="page-container">
    <div class="page-header">
      <h1>ລາຍງານ</h1>
      <p>ລາຍງານທົ່ວໄປແລະການວິເຄາະຂໍ້ມູນ</p>
    </div>

    <v-row>
      <v-col cols="12" md="4">
        <v-card class="report-card" @click="navigateTo('/reports/sales')">
          <v-card-text class="text-center">
            <v-icon size="64" color="primary" class="mb-4">mdi-chart-line</v-icon>
            <h3 class="text-h5 mb-2">ລາຍງານການຂາຍ</h3>
            <p class="text-body-2 text-grey">ສະຖິຕິການຂາຍແລະການວິເຄາະຂໍ້ມູນ</p>
          </v-card-text>
        </v-card>
      </v-col>

      <v-col cols="12" md="4">
        <v-card class="report-card" @click="navigateTo('/reports/statistics')">
          <v-card-text class="text-center">
            <v-icon size="64" color="success" class="mb-4">mdi-poll</v-icon>
            <h3 class="text-h5 mb-2">ສະຖິຕິ</h3>
            <p class="text-body-2 text-grey">ສະຖິຕິທົ່ວໄປແລະການວິເຄາະຂໍ້ມູນ</p>
          </v-card-text>
        </v-card>
      </v-col>

      <v-col cols="12" md="4">
        <v-card class="report-card" @click="navigateTo('/reports/financial')">
          <v-card-text class="text-center">
            <v-icon size="64" color="warning" class="mb-4">mdi-currency-usd</v-icon>
            <h3 class="text-h5 mb-2">ລາຍງານການເງິນ</h3>
            <p class="text-body-2 text-grey">ລາຍງານການເງິນແລະການວິເຄາະທາງການເງິນ</p>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>

    <!-- Quick Stats -->
    <v-row class="mt-6">
      <v-col cols="12">
        <v-card>
          <v-card-title>ສະຖິຕິສະຫຼຸບ</v-card-title>
          <v-card-text>
            <v-row>
              <v-col cols="12" md="3" class="text-center">
                <div class="text-h4 text-primary">{{ summaryData.totalRevenue }}</div>
                <div class="text-subtitle-1">ລາຍໄດ້ທັງໝົດ</div>
              </v-col>
              <v-col cols="12" md="3" class="text-center">
                <div class="text-h4 text-success">{{ summaryData.totalOrders }}</div>
                <div class="text-subtitle-1">ຄໍາສັ່ງຊື້ທັງໝົດ</div>
              </v-col>
              <v-col cols="12" md="3" class="text-center">
                <div class="text-h4 text-info">{{ summaryData.totalCustomers }}</div>
                <div class="text-subtitle-1">ລູກຄ້າທັງໝົດ</div>
              </v-col>
              <v-col cols="12" md="3" class="text-center">
                <div class="text-h4 text-warning">{{ summaryData.avgRating }}</div>
                <div class="text-subtitle-1">ຄະແນນສະເລ່ຍ</div>
              </v-col>
            </v-row>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </div>
</template>

<script setup lang="ts">
import { ref } from "vue";

definePageMeta({
  title: "ລາຍງານ",
  layout: "default",
});

const summaryData = ref({
  totalRevenue: "45,000,000",
  totalOrders: 156,
  totalCustomers: 1247,
  avgRating: 4.6,
});

const navigateTo = (path: string) => {
  // In a real app, you'd use router.push(path)
  console.log("Navigate to:", path);
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

.report-card {
  cursor: pointer;
  transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
}

.report-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
}
</style>