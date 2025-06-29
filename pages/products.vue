<template>
  <div class="page-container">
    <div class="page-header">
      <h1>ການຈັດການສິນຄ້າ</h1>
      <p>ຈັດການສິນຄ້າແລະສາງເກັບຂອງຮ້ານ</p>
    </div>

    <DataTable
      :items="products"
      :columns="productColumns"
      :loading="loading"
      title="ລາຍການສິນຄ້າ"
      subtitle="ຈັດການສິນຄ້າແລະສາງເກັບ"
      :striped="true"
      :dense="false"
      @edit="handleEditProduct"
      @delete="handleDeleteProduct"
      @cell-click="handleCellClick"
    >
      <!-- Custom header actions -->
      <template #header-actions>
        <v-btn
          color="success"
          variant="outlined"
          prepend-icon="mdi-file-excel"
          @click="exportProducts"
          class="mr-2"
        >
          ສົ່ງອອກ Excel
        </v-btn>
        <v-btn
          color="primary"
          variant="flat"
          prepend-icon="mdi-plus"
          @click="handleAddProduct"
        >
          ເພີ່ມສິນຄ້າ
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
  title: "ການຈັດການສິນຄ້າ",
  layout: "default",
});

// Reactive Data
const loading = ref(false);

// Sample Data
const products = ref([
  {
    id: 1,
    name: "ໂທລະສັບມືຖື iPhone 15",
    sku: "IPH15-001",
    price: 15000000,
    stock: 25,
    category: ["ອີເລັກໂຕຣນິກ", "ໂທລະສັບ"],
    status: "active",
    image: "https://via.placeholder.com/40/007AFF/FFFFFF?text=📱",
    rating: 4.5,
    progress: 85,
  },
  {
    id: 2,
    name: "ແລັບທັອບ MacBook Pro",
    sku: "MBP-001",
    price: 28000000,
    stock: 12,
    category: ["ຄອມພິວເຕີ", "ແລັບທັອບ"],
    status: "active",
    image: "https://via.placeholder.com/40/8E8E93/FFFFFF?text=💻",
    rating: 4.8,
    progress: 60,
  },
]);

const productColumns = ref([
  { key: "image", title: "ຮູບພາບ", type: "image" },
  { key: "name", title: "ຊື່ສິນຄ້າ", sortable: true },
  { key: "sku", title: "SKU", sortable: true },
  { key: "price", title: "ລາຄາ", type: "currency", sortable: true },
  { key: "stock", title: "ສິນຄ້າໃນສາງ", type: "number", sortable: true },
  { key: "category", title: "ໝວດໝູ່", type: "tags" },
  { key: "status", title: "ສະຖານະ", type: "status" },
  { key: "rating", title: "ຄະແນນ", type: "rating" },
]);

// Event Handlers
const handleAddProduct = () => {
  console.log("Add product clicked");
};

const handleEditProduct = (product: any) => {
  console.log("Edit product:", product);
};

const handleDeleteProduct = (product: any) => {
  console.log("Delete product:", product);
};

const handleCellClick = (item: any, column: any) => {
  console.log("Cell clicked:", item, column);
};

const exportProducts = () => {
  console.log("Export products to Excel");
};

onMounted(() => {
  // Load product data
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