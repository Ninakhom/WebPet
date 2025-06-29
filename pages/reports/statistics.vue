<template>
  <div class="page-container">
    <div class="page-header">
      <h1>ສະຖິຕິ</h1>
      <p>ສະຖິຕິທົ່ວໄປແລະການວິເຄາະຂໍ້ມູນ</p>
    </div>

    <v-row>
      <!-- Key Metrics -->
      <v-col cols="12" md="3">
        <v-card>
          <v-card-text class="text-center">
            <div class="text-h4 text-primary">{{ stats.totalCustomers }}</div>
            <div class="text-subtitle-1">ລູກຄ້າທັງໝົດ</div>
          </v-card-text>
        </v-card>
      </v-col>
      
      <v-col cols="12" md="3">
        <v-card>
          <v-card-text class="text-center">
            <div class="text-h4 text-success">{{ stats.totalProducts }}</div>
            <div class="text-subtitle-1">ສິນຄ້າທັງໝົດ</div>
          </v-card-text>
        </v-card>
      </v-col>
      
      <v-col cols="12" md="3">
        <v-card>
          <v-card-text class="text-center">
            <div class="text-h4 text-info">{{ stats.monthlyRevenue }}</div>
            <div class="text-subtitle-1">ລາຍໄດ້ປະຈຳເດືອນ</div>
          </v-card-text>
        </v-card>
      </v-col>
      
      <v-col cols="12" md="3">
        <v-card>
          <v-card-text class="text-center">
            <div class="text-h4 text-warning">{{ stats.avgRating }}</div>
            <div class="text-subtitle-1">ຄະແນນສະເລ່ຍ</div>
          </v-card-text>
        </v-card>
      </v-col>

      <!-- Charts -->
      <v-col cols="12" md="6">
        <v-card>
          <v-card-title>ການຂາຍຕາມໝວດໝູ່</v-card-title>
          <v-card-text>
            <div class="chart-placeholder">
              <v-icon size="64" color="grey">mdi-chart-pie</v-icon>
              <p>ກຣາຟວົງຈະສະແດງຢູ່ທີ່ນີ້</p>
            </div>
          </v-card-text>
        </v-card>
      </v-col>

      <v-col cols="12" md="6">
        <v-card>
          <v-card-title>ການເຂົ້າເບິ່ງລະບົບ</v-card-title>
          <v-card-text>
            <div class="chart-placeholder">
              <v-icon size="64" color="grey">mdi-chart-bar</v-icon>
              <p>ກຣາຟແຖບຈະສະແດງຢູ່ທີ່ນີ້</p>
            </div>
          </v-card-text>
        </v-card>
      </v-col>

      <!-- Customer Demographics -->
      <v-col cols="12" md="6">
        <v-card>
          <v-card-title>ຂໍ້ມູນລູກຄ້າ</v-card-title>
          <v-card-text>
            <v-list>
              <v-list-item v-for="demo in demographics" :key="demo.id">
                <template v-slot:prepend>
                  <v-icon :color="demo.color">{{ demo.icon }}</v-icon>
                </template>
                <v-list-item-title>{{ demo.category }}</v-list-item-title>
                <v-list-item-subtitle>{{ demo.count }} ຄົນ ({{ demo.percentage }}%)</v-list-item-subtitle>
                <template v-slot:append>
                  <v-progress-linear
                    :model-value="demo.percentage"
                    :color="demo.color"
                    height="8"
                    rounded
                  ></v-progress-linear>
                </template>
              </v-list-item>
            </v-list>
          </v-card-text>
        </v-card>
      </v-col>

      <!-- Recent Activity -->
      <v-col cols="12" md="6">
        <v-card>
          <v-card-title>ການເຄື່ອນໄຫວລ່າສຸດ</v-card-title>
          <v-card-text>
            <v-timeline>
              <v-timeline-item
                v-for="activity in recentActivity"
                :key="activity.id"
                :dot-color="activity.color"
                size="small"
              >
                <div class="text-caption">{{ activity.time }}</div>
                <div class="text-body-2">{{ activity.description }}</div>
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
  title: "ສະຖິຕິ",
  layout: "default",
});

const stats = ref({
  totalCustomers: 1247,
  totalProducts: 89,
  monthlyRevenue: "45,000,000",
  avgRating: 4.6,
});

const demographics = ref([
  {
    id: 1,
    category: "ອາຍຸ 18-25",
    count: 456,
    percentage: 36.5,
    icon: "mdi-account-group",
    color: "primary",
  },
  {
    id: 2,
    category: "ອາຍຸ 26-35",
    count: 389,
    percentage: 31.2,
    icon: "mdi-account-group",
    color: "success",
  },
  {
    id: 3,
    category: "ອາຍຸ 36-45",
    count: 234,
    percentage: 18.8,
    icon: "mdi-account-group",
    color: "warning",
  },
  {
    id: 4,
    category: "ອາຍຸ 46+",
    count: 168,
    percentage: 13.5,
    icon: "mdi-account-group",
    color: "info",
  },
]);

const recentActivity = ref([
  {
    id: 1,
    description: "ລູກຄ້າໃໝ່ລົງທະບຽນ",
    time: "2 ນາທີກ່ອນ",
    color: "success",
  },
  {
    id: 2,
    description: "ສັ່ງຊື້ສິນຄ້າໃໝ່",
    time: "5 ນາທີກ່ອນ",
    color: "primary",
  },
  {
    id: 3,
    description: "ການຊໍາລະເງິນສໍາເລັດ",
    time: "10 ນາທີກ່ອນ",
    color: "success",
  },
  {
    id: 4,
    description: "ອັບເດດສິນຄ້າໃນສາງ",
    time: "15 ນາທີກ່ອນ",
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

.chart-placeholder {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 250px;
  color: #666;
}
</style> 