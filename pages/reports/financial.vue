<template>
  <div class="page-container">
    <div class="page-header">
      <h1>ລາຍງານການເງິນ</h1>
      <p>ລາຍງານການເງິນແລະການວິເຄາະທາງການເງິນ</p>
    </div>

    <v-row>
      <!-- Financial Summary -->
      <v-col cols="12" md="3">
        <v-card>
          <v-card-text class="text-center">
            <div class="text-h4 text-success">{{ financialData.revenue }}</div>
            <div class="text-subtitle-1">ລາຍໄດ້ທັງໝົດ</div>
          </v-card-text>
        </v-card>
      </v-col>
      
      <v-col cols="12" md="3">
        <v-card>
          <v-card-text class="text-center">
            <div class="text-h4 text-error">{{ financialData.expenses }}</div>
            <div class="text-subtitle-1">ລາຍຈ່າຍທັງໝົດ</div>
          </v-card-text>
        </v-card>
      </v-col>
      
      <v-col cols="12" md="3">
        <v-card>
          <v-card-text class="text-center">
            <div class="text-h4 text-primary">{{ financialData.profit }}</div>
            <div class="text-subtitle-1">ກຳໄລທັງໝົດ</div>
          </v-card-text>
        </v-card>
      </v-col>
      
      <v-col cols="12" md="3">
        <v-card>
          <v-card-text class="text-center">
            <div class="text-h4 text-info">{{ financialData.profitMargin }}%</div>
            <div class="text-subtitle-1">ອັດຕາກຳໄລ</div>
          </v-card-text>
        </v-card>
      </v-col>

      <!-- Financial Chart -->
      <v-col cols="12">
        <v-card>
          <v-card-title>ການເງິນຕາມເວລາ</v-card-title>
          <v-card-text>
            <div class="chart-placeholder">
              <v-icon size="64" color="grey">mdi-chart-line</v-icon>
              <p>ກຣາຟການເງິນຈະສະແດງຢູ່ທີ່ນີ້</p>
            </div>
          </v-card-text>
        </v-card>
      </v-col>

      <!-- Expense Breakdown -->
      <v-col cols="12" md="6">
        <v-card>
          <v-card-title>ການແບ່ງປັນລາຍຈ່າຍ</v-card-title>
          <v-card-text>
            <v-list>
              <v-list-item v-for="expense in expenses" :key="expense.id">
                <template v-slot:prepend>
                  <v-icon :color="expense.color">{{ expense.icon }}</v-icon>
                </template>
                <v-list-item-title>{{ expense.category }}</v-list-item-title>
                <v-list-item-subtitle>{{ expense.amount }} ({{ expense.percentage }}%)</v-list-item-subtitle>
                <template v-slot:append>
                  <v-progress-linear
                    :model-value="expense.percentage"
                    :color="expense.color"
                    height="8"
                    rounded
                  ></v-progress-linear>
                </template>
              </v-list-item>
            </v-list>
          </v-card-text>
        </v-card>
      </v-col>

      <!-- Cash Flow -->
      <v-col cols="12" md="6">
        <v-card>
          <v-card-title>ການເຄື່ອນໄຫວເງິນສົດ</v-card-title>
          <v-card-text>
            <v-list>
              <v-list-item v-for="flow in cashFlow" :key="flow.id">
                <template v-slot:prepend>
                  <v-icon :color="flow.type === 'in' ? 'success' : 'error'">
                    {{ flow.type === 'in' ? 'mdi-arrow-up' : 'mdi-arrow-down' }}
                  </v-icon>
                </template>
                <v-list-item-title>{{ flow.description }}</v-list-item-title>
                <v-list-item-subtitle>{{ flow.date }}</v-list-item-subtitle>
                <template v-slot:append>
                  <v-chip 
                    :color="flow.type === 'in' ? 'success' : 'error'" 
                    size="small"
                  >
                    {{ flow.type === 'in' ? '+' : '-' }}{{ flow.amount }}
                  </v-chip>
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
  title: "ລາຍງານການເງິນ",
  layout: "default",
});

const financialData = ref({
  revenue: "45,000,000",
  expenses: "32,000,000",
  profit: "13,000,000",
  profitMargin: 28.9,
});

const expenses = ref([
  {
    id: 1,
    category: "ຕົ້ນທຶນສິນຄ້າ",
    amount: "25,000,000",
    percentage: 78.1,
    icon: "mdi-package-variant",
    color: "primary",
  },
  {
    id: 2,
    category: "ຄ່າຈ້າງ",
    amount: "4,500,000",
    percentage: 14.1,
    icon: "mdi-account-group",
    color: "success",
  },
  {
    id: 3,
    category: "ຄ່າສິ່ງເສດເຫຼືອ",
    amount: "2,000,000",
    percentage: 6.3,
    icon: "mdi-office-building",
    color: "warning",
  },
  {
    id: 4,
    category: "ຄ່າອື່ນໆ",
    amount: "500,000",
    percentage: 1.5,
    icon: "mdi-cog",
    color: "info",
  },
]);

const cashFlow = ref([
  {
    id: 1,
    description: "ການຂາຍສິນຄ້າ",
    amount: "4,500,000",
    type: "in",
    date: "2024-01-15",
  },
  {
    id: 2,
    description: "ຊື້ສິນຄ້າໃໝ່",
    amount: "2,800,000",
    type: "out",
    date: "2024-01-14",
  },
  {
    id: 3,
    description: "ຄ່າຈ້າງພະນັກງານ",
    amount: "1,200,000",
    type: "out",
    date: "2024-01-13",
  },
  {
    id: 4,
    description: "ການຂາຍອອນລາຍ",
    amount: "3,200,000",
    type: "in",
    date: "2024-01-12",
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