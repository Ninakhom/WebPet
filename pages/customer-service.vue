<template>
  <div class="page-container">
    <div class="page-header">
      <h1>ບໍລິການລູກຄ້າ</h1>
      <p>ຈັດການການບໍລິການລູກຄ້າແລະການສະໜັບສະໜູນ</p>
    </div>

    <v-row>
      <!-- Customer Support Tickets -->
      <v-col cols="12" lg="8">
        <v-card>
          <v-card-title class="d-flex justify-space-between align-center">
            <div>
              <h3>ຕິດເກັດການສະໜັບສະໜູນ</h3>
              <p class="text-subtitle-2 text-grey">ຈັດການຄຳຮ້ອງຂໍຂອງລູກຄ້າ</p>
            </div>
            <v-btn color="primary" prepend-icon="mdi-plus">
              ຕິດເກັດໃໝ່
            </v-btn>
          </v-card-title>
          
          <v-card-text>
            <v-table>
              <thead>
                <tr>
                  <th>ເລກຕິດເກັດ</th>
                  <th>ລູກຄ້າ</th>
                  <th>ປະເພດ</th>
                  <th>ສະຖານະ</th>
                  <th>ວັນທີ</th>
                  <th>ການດຳເນີນການ</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="ticket in supportTickets" :key="ticket.id">
                  <td>{{ ticket.id }}</td>
                  <td>{{ ticket.customer }}</td>
                  <td>
                    <v-chip :color="getTicketTypeColor(ticket.type)" size="small">
                      {{ ticket.type }}
                    </v-chip>
                  </td>
                  <td>
                    <v-chip :color="getStatusColor(ticket.status)" size="small">
                      {{ ticket.status }}
                    </v-chip>
                  </td>
                  <td>{{ formatDate(ticket.date) }}</td>
                  <td>
                    <v-btn size="small" variant="text" color="primary">
                      ເບິ່ງ
                    </v-btn>
                  </td>
                </tr>
              </tbody>
            </v-table>
          </v-card-text>
        </v-card>
      </v-col>

      <!-- Quick Stats -->
      <v-col cols="12" lg="4">
        <v-card>
          <v-card-title>ສະຖິຕິການບໍລິການ</v-card-title>
          <v-card-text>
            <div class="d-flex flex-column gap-4">
              <div class="d-flex justify-space-between align-center">
                <div>
                  <div class="text-h6 text-primary">{{ stats.openTickets }}</div>
                  <div class="text-caption">ຕິດເກັດໃໝ່</div>
                </div>
                <v-icon color="primary" size="32">mdi-ticket</v-icon>
              </div>
              
              <div class="d-flex justify-space-between align-center">
                <div>
                  <div class="text-h6 text-success">{{ stats.resolvedTickets }}</div>
                  <div class="text-caption">ແກ້ໄຂແລ້ວ</div>
                </div>
                <v-icon color="success" size="32">mdi-check-circle</v-icon>
              </div>
              
              <div class="d-flex justify-space-between align-center">
                <div>
                  <div class="text-h6 text-warning">{{ stats.avgResponseTime }}</div>
                  <div class="text-caption">ເວລາຕອບສະໜອງສະເລ່ຍ (ຊົ່ວໂມງ)</div>
                </div>
                <v-icon color="warning" size="32">mdi-clock</v-icon>
              </div>
            </div>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </div>
</template>

<script setup lang="ts">
import { ref } from "vue";

// Page Setup
definePageMeta({
  title: "ບໍລິການລູກຄ້າ",
  layout: "default",
});

// Sample Data
const supportTickets = ref([
  {
    id: "TKT-001",
    customer: "ສົມຊາຍ ວົງດີ",
    type: "ບັນຫາສິນຄ້າ",
    status: "ໃໝ່",
    date: "2024-01-15T10:30:00",
  },
  {
    id: "TKT-002",
    customer: "ນາງສີ ພິມມະວົງ",
    type: "ການຊໍາລະ",
    status: "ກໍາລັງດໍາເນີນການ",
    date: "2024-01-14T16:45:00",
  },
  {
    id: "TKT-003",
    customer: "ທອງແດງ ໄຊຍະວົງ",
    type: "ການຈັດສົ່ງ",
    status: "ແກ້ໄຂແລ້ວ",
    date: "2024-01-13T11:20:00",
  },
]);

const stats = ref({
  openTickets: 5,
  resolvedTickets: 12,
  avgResponseTime: 2.5,
});

// Helper Functions
const getTicketTypeColor = (type: string) => {
  const colors: { [key: string]: string } = {
    "ບັນຫາສິນຄ້າ": "error",
    "ການຊໍາລະ": "warning",
    "ການຈັດສົ່ງ": "info",
  };
  return colors[type] || "grey";
};

const getStatusColor = (status: string) => {
  const colors: { [key: string]: string } = {
    "ໃໝ່": "error",
    "ກໍາລັງດໍາເນີນການ": "warning",
    "ແກ້ໄຂແລ້ວ": "success",
  };
  return colors[status] || "grey";
};

const formatDate = (dateString: string) => {
  return new Date(dateString).toLocaleDateString("lo-LA");
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

.gap-4 {
  gap: 16px;
}
</style> 