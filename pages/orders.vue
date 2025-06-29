<template>
  <div class="page-container">
    <div class="page-header">
      <h1>ການຈັດການຄໍາສັ່ງຊື້</h1>
      <p>ຈັດການຄໍາສັ່ງຊື້ແລະການຂາຍຂອງຮ້ານ</p>
    </div>

    <DataTable
      :items="orders"
      :columns="orderColumns"
      :loading="loading"
      title="ຄໍາສັ່ງຊື້ລ່າສຸດ"
      subtitle="ຈັດການຄໍາສັ່ງຊື້ທັງໝົດ"
      :show-header="true"
      :show-search="true"
      :show-add-button="false"
      :items-per-page="10"
      @edit="handleViewOrder"
      @delete="handleDeleteOrder"
    >
      <!-- Custom filters -->
      <template #filters>
        <v-select
          v-model="statusFilter"
          :items="statusOptions"
          label="ສະຖານະຄໍາສັ່ງຊື້"
          variant="outlined"
          density="compact"
          clearable
          style="width: 200px"
        />
        <v-select
          v-model="paymentFilter"
          :items="paymentOptions"
          label="ວິທີການຊໍາລະ"
          variant="outlined"
          density="compact"
          clearable
          style="width: 200px"
        />
      </template>
    </DataTable>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from "vue";
import DataTable from "@/components/datatable.vue";

// Page Setup
definePageMeta({
  title: "ການຈັດການຄໍາສັ່ງຊື້",
  layout: "default",
});

// Reactive Data
const loading = ref(false);
const statusFilter = ref("");
const paymentFilter = ref("");

// Sample Data
const orders = ref([
  {
    id: "ORD-001",
    customer: "ສົມຊາຍ ວົງດີ",
    items: 3,
    total: 4500000,
    status: "pending",
    paymentMethod: "credit_card",
    orderDate: "2024-01-15T10:30:00",
    deliveryDate: "2024-01-20T14:00:00",
  },
  {
    id: "ORD-002",
    customer: "ນາງສີ ພິມມະວົງ",
    items: 2,
    total: 2800000,
    status: "completed",
    paymentMethod: "cash",
    orderDate: "2024-01-14T16:45:00",
    deliveryDate: "2024-01-16T09:30:00",
  },
  {
    id: "ORD-003",
    customer: "ທອງແດງ ໄຊຍະວົງ",
    items: 1,
    total: 1500000,
    status: "processing",
    paymentMethod: "bank_transfer",
    orderDate: "2024-01-13T11:20:00",
    deliveryDate: "2024-01-18T13:15:00",
  },
]);

const orderColumns = ref([
  { key: "id", title: "ເລກຄໍາສັ່ງຊື້", sortable: true },
  { key: "customer", title: "ລູກຄ້າ", sortable: true },
  { key: "items", title: "ຈໍານວນລາຍການ", type: "number" },
  { key: "total", title: "ລວມ", type: "currency", sortable: true },
  { key: "status", title: "ສະຖານະ", type: "status" },
  { key: "paymentMethod", title: "ວິທີການຊໍາລະ", type: "badge" },
  { key: "orderDate", title: "ວັນທີສັ່ງຊື້", type: "date", sortable: true },
  { key: "deliveryDate", title: "ວັນທີຈັດສົ່ງ", type: "date" },
]);

const statusOptions = ref([
  { title: "ລໍຖ້າ", value: "pending" },
  { title: "ກໍາລັງດໍາເນີນການ", value: "processing" },
  { title: "ສໍາເລັດ", value: "completed" },
  { title: "ຍົກເລີກ", value: "cancelled" },
]);

const paymentOptions = ref([
  { title: "ເງິນສົດ", value: "cash" },
  { title: "ບັດເຄຣດິດ", value: "credit_card" },
  { title: "ໂອນເງິນ", value: "bank_transfer" },
]);

// Event Handlers
const handleViewOrder = (order: any) => {
  console.log("View order:", order);
};

const handleDeleteOrder = (order: any) => {
  console.log("Delete order:", order);
};

onMounted(() => {
  // Load order data
  loading.value = true;
  setTimeout(() => {
    loading.value = false;
  }, 1000);
});
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