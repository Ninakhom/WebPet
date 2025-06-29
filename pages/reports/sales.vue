<template>
  <div class="page-container">
    <div class="page-header">
      <h1>ລາຍງານການຂາຍ</h1>
      <p>ສະຖິຕິການຂາຍແລະການວິເຄາະຂໍ້ມູນ</p>
    </div>

    <v-row>
      <!-- Sales Summary Cards -->
      <v-col cols="12" md="3">
        <v-card>
          <v-card-text class="text-center">
            <div class="text-h4 text-primary">{{ salesData.totalSales }}</div>
            <div class="text-subtitle-1">ລາຍໄດ້ທັງໝົດ</div>
          </v-card-text>
        </v-card>
      </v-col>
      
      <v-col cols="12" md="3">
        <v-card>
          <v-card-text class="text-center">
            <div class="text-h4 text-success">{{ salesData.totalOrders }}</div>
            <div class="text-subtitle-1">ຄໍາສັ່ງຊື້ທັງໝົດ</div>
          </v-card-text>
        </v-card>
      </v-col>
      
      <v-col cols="12" md="3">
        <v-card>
          <v-card-text class="text-center">
            <div class="text-h4 text-info">{{ salesData.avgOrderValue }}</div>
            <div class="text-subtitle-1">ມູນຄ່າສະເລ່ຍຕໍ່ຄໍາສັ່ງຊື້</div>
          </v-card-text>
        </v-card>
      </v-col>
      
      <v-col cols="12" md="3">
        <v-card>
          <v-card-text class="text-center">
            <div class="text-h4 text-warning">{{ salesData.growthRate }}%</div>
            <div class="text-subtitle-1">ອັດຕາການເຕີບໂຕ</div>
          </v-card-text>
        </v-card>
      </v-col>

      <!-- Sales Chart -->
      <v-col cols="12">
        <v-card>
          <v-card-title>ການຂາຍຕາມເວລາ</v-card-title>
          <v-card-text>
            <div class="chart-placeholder">
              <v-icon size="64" color="grey">mdi-chart-line</v-icon>
              <p>ກຣາຟການຂາຍຈະສະແດງຢູ່ທີ່ນີ້</p>
            </div>
          </v-card-text>
        </v-card>
      </v-col>

      <!-- Top Products -->
      <v-col cols="12" md="6">
        <v-card>
          <v-card-title>ສິນຄ້າຂາຍດີ</v-card-title>
          <v-card-text>
            <v-list>
              <v-list-item v-for="product in topProducts" :key="product.id">
                <template v-slot:prepend>
                  <v-avatar size="40">
                    <v-img :src="product.image"></v-img>
                  </v-avatar>
                </template>
                <v-list-item-title>{{ product.name }}</v-list-item-title>
                <v-list-item-subtitle>{{ product.sales }} ລາຍການ</v-list-item-subtitle>
                <template v-slot:append>
                  <v-chip color="success" size="small">{{ product.revenue }}</v-chip>
                </template>
              </v-list-item>
            </v-list>
          </v-card-text>
        </v-card>
      </v-col>

      <!-- Recent Sales -->
      <v-col cols="12" md="6">
        <v-card>
          <v-card-title>ການຂາຍລ່າສຸດ</v-card-title>
          <v-card-text>
            <v-list>
              <v-list-item v-for="sale in recentSales" :key="sale.id">
                <template v-slot:prepend>
                  <v-icon color="primary">mdi-receipt</v-icon>
                </template>
                <v-list-item-title>{{ sale.orderId }}</v-list-item-title>
                <v-list-item-subtitle>{{ sale.customer }} - {{ sale.date }}</v-list-item-subtitle>
                <template v-slot:append>
                  <v-chip color="primary" size="small">{{ sale.amount }}</v-chip>
                </template>
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
  title: "ລາຍງານການຂາຍ",
  layout: "default",
});

const salesData = ref({
  totalSales: "45,000,000",
  totalOrders: 156,
  avgOrderValue: "288,462",
  growthRate: 12.5,
});

const topProducts = ref([
  {
    id: 1,
    name: "ໂທລະສັບມືຖື iPhone 15",
    sales: 25,
    revenue: "375,000,000",
    image: "https://via.placeholder.com/40/007AFF/FFFFFF?text=📱",
  },
  {
    id: 2,
    name: "ແລັບທັອບ MacBook Pro",
    sales: 12,
    revenue: "336,000,000",
    image: "https://via.placeholder.com/40/8E8E93/FFFFFF?text=💻",
  },
  {
    id: 3,
    name: "ຫູຟັງ AirPods Pro",
    sales: 45,
    revenue: "382,500,000",
    image: "https://via.placeholder.com/40/34C759/FFFFFF?text=🎧",
  },
]);

const recentSales = ref([
  {
    id: 1,
    orderId: "ORD-001",
    customer: "ສົມຊາຍ ວົງດີ",
    amount: "4,500,000",
    date: "2024-01-15",
  },
  {
    id: 2,
    orderId: "ORD-002",
    customer: "ນາງສີ ພິມມະວົງ",
    amount: "2,800,000",
    date: "2024-01-14",
  },
  {
    id: 3,
    orderId: "ORD-003",
    customer: "ທອງແດງ ໄຊຍະວົງ",
    amount: "1,500,000",
    date: "2024-01-13",
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

.chart-placeholder {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 300px;
  color: #666;
}
</style> 