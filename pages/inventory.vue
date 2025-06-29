<template>
  <div class="page-container">
    <div class="page-header">
      <h1>ການຈັດການສາງເກັບ</h1>
      <p>ຈັດການສິນຄ້າໃນສາງແລະການເຄື່ອນໄຫວສິນຄ້າ</p>
    </div>

    <DataTable
      :items="inventory"
      :columns="inventoryColumns"
      :loading="loading"
      title="ສິນຄ້າໃນສາງ"
      subtitle="ຈັດການສິນຄ້າໃນສາງແລະການເຄື່ອນໄຫວ"
      :show-header="true"
      :show-search="true"
      :show-add-button="true"
      add-button-text="ເພີ່ມສິນຄ້າໃໝ່"
      @add="handleAddItem"
      @edit="handleEditItem"
      @delete="handleDeleteItem"
    >
      <!-- Custom filters -->
      <template #filters>
        <v-select
          v-model="categoryFilter"
          :items="categoryOptions"
          label="ໝວດໝູ່"
          variant="outlined"
          density="compact"
          clearable
          style="width: 200px"
        />
        <v-select
          v-model="stockFilter"
          :items="stockOptions"
          label="ສະຖານະສິນຄ້າ"
          variant="outlined"
          density="compact"
          clearable
          style="width: 200px"
        />
      </template>

      <!-- Custom header actions -->
      <template #header-actions>
        <v-btn
          color="warning"
          variant="outlined"
          prepend-icon="mdi-alert"
          @click="handleLowStock"
          class="mr-2"
        >
          ສິນຄ້າໃກ້ໝົດ
        </v-btn>
        <v-btn
          color="success"
          variant="outlined"
          prepend-icon="mdi-file-excel"
          @click="exportInventory"
          class="mr-2"
        >
          ສົ່ງອອກ Excel
        </v-btn>
      </template>
    </DataTable>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from "vue";
import DataTable from "@/components/datatable.vue";

// Page Setup
definePageMeta({
  title: "ການຈັດການສາງເກັບ",
  layout: "default",
});

// Reactive Data
const loading = ref(false);
const categoryFilter = ref("");
const stockFilter = ref("");

// Sample Data
const inventory = ref([
  {
    id: 1,
    name: "ໂທລະສັບມືຖື iPhone 15",
    sku: "IPH15-001",
    category: "ອີເລັກໂຕຣນິກ",
    currentStock: 25,
    minStock: 10,
    maxStock: 100,
    unitPrice: 15000000,
    totalValue: 375000000,
    lastUpdated: "2024-01-15T10:30:00",
    status: "in_stock",
  },
  {
    id: 2,
    name: "ແລັບທັອບ MacBook Pro",
    sku: "MBP-001",
    category: "ຄອມພິວເຕີ",
    currentStock: 5,
    minStock: 5,
    maxStock: 50,
    unitPrice: 28000000,
    totalValue: 140000000,
    lastUpdated: "2024-01-14T16:45:00",
    status: "low_stock",
  },
  {
    id: 3,
    name: "ຫູຟັງ AirPods Pro",
    sku: "APP-001",
    category: "ອີເລັກໂຕຣນິກ",
    currentStock: 0,
    minStock: 15,
    maxStock: 200,
    unitPrice: 8500000,
    totalValue: 0,
    lastUpdated: "2024-01-13T11:20:00",
    status: "out_of_stock",
  },
]);

const inventoryColumns = ref([
  { key: "name", title: "ຊື່ສິນຄ້າ", sortable: true },
  { key: "sku", title: "SKU", sortable: true },
  { key: "category", title: "ໝວດໝູ່", type: "badge" },
  { key: "currentStock", title: "ສິນຄ້າໃນສາງ", type: "number", sortable: true },
  { key: "minStock", title: "ສິນຄ້າຕ່ຳສຸດ", type: "number" },
  { key: "maxStock", title: "ສິນຄ້າສູງສຸດ", type: "number" },
  { key: "unitPrice", title: "ລາຄາຕໍ່ໜ່ວຍ", type: "currency", sortable: true },
  { key: "totalValue", title: "ມູນຄ່າທັງໝົດ", type: "currency", sortable: true },
  { key: "status", title: "ສະຖານະ", type: "status" },
  { key: "lastUpdated", title: "ອັບເດດຄັ້ງສຸດທ້າຍ", type: "date", sortable: true },
]);

const categoryOptions = ref([
  { title: "ອີເລັກໂຕຣນິກ", value: "ອີເລັກໂຕຣນິກ" },
  { title: "ຄອມພິວເຕີ", value: "ຄອມພິວເຕີ" },
  { title: "ເຄື່ອງນຸ່ງ", value: "ເຄື່ອງນຸ່ງ" },
]);

const stockOptions = ref([
  { title: "ມີສິນຄ້າ", value: "in_stock" },
  { title: "ໃກ້ໝົດ", value: "low_stock" },
  { title: "ໝົດສິນຄ້າ", value: "out_of_stock" },
]);

// Event Handlers
const handleAddItem = () => {
  console.log("Add inventory item clicked");
};

const handleEditItem = (item: any) => {
  console.log("Edit inventory item:", item);
};

const handleDeleteItem = (item: any) => {
  console.log("Delete inventory item:", item);
};

const handleLowStock = () => {
  console.log("Show low stock items");
};

const exportInventory = () => {
  console.log("Export inventory to Excel");
};

onMounted(() => {
  // Load inventory data
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