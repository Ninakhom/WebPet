<template>
  <div class="page-container">
    <div class="page-header">
      <h1>ການຈັດການຜູ້ໃຊ້ງານ</h1>
      <p>ຈັດການຂໍ້ມູນຜູ້ໃຊ້ງານທັງໝົດຂອງລະບົບ</p>
    </div>

    <!-- Example 1: Basic Users Table -->
    <DataTable
      :items="users"
      :columns="userColumns"
      :loading="loading"
      title="ລາຍຊື່ຜູ້ໃຊ້ງານ"
      subtitle="ຈັດການຂໍ້ມູນຜູ້ໃຊ້ງານທັງໝົດ"
      :show-select="true"
      :show-add-button="true"
      :show-edit-button="true"
      :show-delete-button="true"
      add-button-text="ເພີ່ມຜູ້ໃຊ້ໃໝ່"
      search-placeholder="ຄົ້ນຫາຜູ້ໃຊ້ງານ..."
      @add="handleAddUser"
      @edit="handleEditUser"
      @delete="handleDeleteUser"
      @bulk-delete="handleBulkDelete"
    >
      <!-- Custom filters -->
      <template #filters>
        <v-select
          v-model="statusFilter"
          :items="statusOptions"
          label="ສະຖານະ"
          variant="outlined"
          density="compact"
          clearable
          style="width: 200px"
        />
        <v-select
          v-model="roleFilter"
          :items="roleOptions"
          label="ບົດບາດ"
          variant="outlined"
          density="compact"
          clearable
          style="width: 200px"
        />
      </template>

      <!-- Custom bulk actions -->
      <template #bulk-actions="{ selected }">
        <v-btn
          variant="outlined"
          color="warning"
          prepend-icon="mdi-account-off"
          @click="handleBulkDeactivate(selected)"
          class="mr-2"
        >
          ປິດໃຊ້ງານ
        </v-btn>
        <v-btn
          variant="outlined"
          color="error"
          prepend-icon="mdi-delete"
          @click="handleBulkDelete(selected)"
        >
          ລຶບທີ່ເລືອກ
        </v-btn>
      </template>
    </DataTable>

    <!-- Example 2: Products Table with Different Cell Types -->
    <div class="mt-8">
      <DataTable
        :items="products"
        :columns="productColumns"
        :loading="productLoading"
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

    <!-- Example 3: Simple Orders Table -->
    <div class="mt-8">
      <DataTable
        :items="orders"
        :columns="orderColumns"
        :loading="orderLoading"
        title="ຄໍາສັ່ງຊື້ລ່າສຸດ"
        :show-header="true"
        :show-search="false"
        :show-add-button="false"
        :items-per-page="5"
        @edit="handleViewOrder"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, computed } from "vue";
import DataTable from "@/components/datatable.vue";

// Page Setup
definePageMeta({
  title: "ການຈັດການຜູ້ໃຊ້ງານ",
  layout: "default",
});

// Reactive Data
const loading = ref(false);
const productLoading = ref(false);
const orderLoading = ref(false);
const statusFilter = ref("");
const roleFilter = ref("");

// Sample Data
const users = ref([
  {
    id: 1,
    name: "ສົມຊາຍ ວົງດີ",
    email: "somchai@example.com",
    role: "admin",
    status: "active",
    avatar: "https://via.placeholder.com/40/4A90E2/FFFFFF?text=S",
    lastLogin: "2024-01-15T10:30:00",
    createdAt: "2023-06-01T08:00:00",
  },
  {
    id: 2,
    name: "ນາງສີ ພິມມະວົງ",
    email: "nagsee@example.com",
    role: "user",
    status: "inactive",
    avatar: "https://via.placeholder.com/40/E91E63/FFFFFF?text=N",
    lastLogin: "2024-01-10T14:20:00",
    createdAt: "2023-08-15T09:30:00",
  },
  {
    id: 3,
    name: "ທອງແດງ ໄຊຍະວົງ",
    email: "thongdeng@example.com",
    role: "moderator",
    status: "pending",
    avatar: "https://via.placeholder.com/40/FF9800/FFFFFF?text=T",
    lastLogin: "2024-01-12T16:45:00",
    createdAt: "2023-09-20T11:15:00",
  },
]);

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
  {
    id: 3,
    name: "ຫູຟັງ AirPods Pro",
    sku: "APP-001",
    price: 3500000,
    stock: 0,
    category: ["ອຸປະກອນ", "ສຽງ"],
    status: "inactive",
    image: "https://via.placeholder.com/40/1D1D1F/FFFFFF?text=🎧",
    rating: 4.2,
    progress: 0,
  },
]);

const orders = ref([
  {
    id: "ORD-001",
    customer: "ສົມຊາຍ ວົງດີ",
    total: 15000000,
    status: "completed",
    date: "2024-01-15T10:30:00",
    items: 2,
  },
  {
    id: "ORD-002",
    customer: "ນາງສີ ພິມມະວົງ",
    total: 28000000,
    status: "pending",
    date: "2024-01-14T15:20:00",
    items: 1,
  },
  {
    id: "ORD-003",
    customer: "ທອງແດງ ໄຊຍະວົງ",
    total: 7000000,
    status: "cancelled",
    date: "2024-01-13T09:15:00",
    items: 3,
  },
]);

// Column Definitions
const userColumns = computed(() => [
  {
    key: "avatar",
    title: "ຮູບ",
    type: "image" as const,
    sortable: false,
    width: 80,
    options: {
      size: 40,
      placeholder: "https://via.placeholder.com/40/94A3B8/FFFFFF?text=U",
    },
  },
  {
    key: "name",
    title: "ຊື່ຜູ້ໃຊ້",
    type: "text" as const,
    sortable: true,
  },
  {
    key: "email",
    title: "ອີເມວ",
    type: "link" as const,
    sortable: true,
    options: {
      urlTemplate: "mailto:{value}",
      icon: "mdi-email",
    },
  },
  {
    key: "role",
    title: "ບົດບາດ",
    type: "chip" as const,
    sortable: true,
    options: {
      colorMap: {
        admin: "error",
        moderator: "warning",
        user: "primary",
      },
    },
  },
  {
    key: "status",
    title: "ສະຖານະ",
    type: "status" as const,
    sortable: true,
    options: {
      statusConfig: {
        active: {
          color: "success",
          text: "ເປີດໃຊ້ງານ",
          icon: "mdi-check-circle",
        },
        inactive: {
          color: "error",
          text: "ປິດໃຊ້ງານ",
          icon: "mdi-close-circle",
        },
        pending: {
          color: "warning",
          text: "ລໍຖ້າອະນຸມັດ",
          icon: "mdi-clock-outline",
        },
      },
    },
  },
  {
    key: "lastLogin",
    title: "ເຂົ້າໃຊ້ຄັ້ງສຸດທ້າຍ",
    type: "date" as const,
    format: "relative",
    sortable: true,
  },
]);

const productColumns = computed(() => [
  {
    key: "image",
    title: "ຮູບ",
    type: "image" as const,
    sortable: false,
    width: 60,
  },
  {
    key: "name",
    title: "ຊື່ສິນຄ້າ",
    type: "text" as const,
    sortable: true,
  },
  {
    key: "sku",
    title: "SKU",
    type: "text" as const,
    sortable: true,
  },
  {
    key: "category",
    title: "ປະເພດ",
    type: "chip" as const,
    sortable: false,
  },
  {
    key: "price",
    title: "ລາຄາ",
    type: "currency" as const,
    sortable: true,
    align: "end" as const,
    options: {
      currency: "LAK",
      locale: "lo-LA",
    },
  },
  {
    key: "stock",
    title: "ສາງເກັບ",
    type: "number" as const,
    sortable: true,
    align: "center" as const,
  },
  {
    key: "rating",
    title: "ຄະແນນ",
    type: "number" as const,
    sortable: true,
    align: "center" as const,
    options: {
      max: 5,
      color: "amber",
      showValue: true,
    },
  },
  {
    key: "progress",
    title: "ຍອດຂາຍ",
    type: "number" as const,
    sortable: true,
    align: "center" as const,
  },
  {
    key: "status",
    title: "ສະຖານະ",
    type: "status" as const,
    sortable: true,
  },
]);

const orderColumns = computed(() => [
  {
    key: "id",
    title: "ລະຫັດ",
    type: "link" as const,
    sortable: true,
    options: {
      urlTemplate: "/orders/{value}",
      icon: "mdi-open-in-new",
    },
  },
  {
    key: "customer",
    title: "ລູກຄ້າ",
    type: "text" as const,
    sortable: true,
  },
  {
    key: "total",
    title: "ຍອດລວມ",
    type: "currency" as const,
    sortable: true,
    align: "end" as const,
  },
  {
    key: "status",
    title: "ສະຖານະ",
    type: "status" as const,
    sortable: true,
  },
  {
    key: "date",
    title: "ວັນທີ",
    type: "date" as const,
    format: "relative",
    sortable: true,
  },
]);

// Filter Options
const statusOptions = [
  { title: "ເປີດໃຊ້ງານ", value: "active" },
  { title: "ປິດໃຊ້ງານ", value: "inactive" },
  { title: "ລໍຖ້າອະນຸມັດ", value: "pending" },
];

const roleOptions = [
  { title: "ຜູ້ຄວບຄຸມລະບົບ", value: "admin" },
  { title: "ຜູ້ດູແລ", value: "moderator" },
  { title: "ຜູ້ໃຊ້ທົ່ວໄປ", value: "user" },
];

// Event Handlers
const handleAddUser = () => {
  console.log("Add new user");
  // Navigate to add user page or open modal
  navigateTo("/users/add");
};

const handleEditUser = (user: any) => {
  console.log("Edit user:", user);
  // Navigate to edit page or open modal
  navigateTo(`/users/${user.id}/edit`);
};

const handleDeleteUser = (user: any) => {
  console.log("Delete user:", user);
  // Show confirmation dialog and delete
  if (confirm(`ທ່ານຕ້ອງການລຶບຜູ້ໃຊ້ ${user.name} ບໍ?`)) {
    // Call API to delete user
    const index = users.value.findIndex((u) => u.id === user.id);
    if (index > -1) {
      users.value.splice(index, 1);
    }
  }
};

const handleBulkDelete = (selectedUsers: any[]) => {
  console.log("Bulk delete users:", selectedUsers);
  if (confirm(`ທ່ານຕ້ອງການລຶບຜູ້ໃຊ້ ${selectedUsers.length} ຄົນບໍ?`)) {
    // Call API to bulk delete
    const selectedIds = selectedUsers.map((u) => u.id);
    users.value = users.value.filter((u) => !selectedIds.includes(u.id));
  }
};

const handleBulkDeactivate = (selectedUsers: any[]) => {
  console.log("Bulk deactivate users:", selectedUsers);
  const selectedIds = selectedUsers.map((u) => u.id);
  users.value.forEach((user) => {
    if (selectedIds.includes(user.id)) {
      user.status = "inactive";
    }
  });
};

const handleEditProduct = (product: any) => {
  console.log("Edit product:", product);
  navigateTo(`/products/${product.id}/edit`);
};

const handleDeleteProduct = (product: any) => {
  console.log("Delete product:", product);
  // Implementation here
};

const handleAddProduct = () => {
  navigateTo("/products/add");
};

const handleViewOrder = (order: any) => {
  console.log("View order:", order);
  navigateTo(`/orders/${order.id}`);
};

const handleCellClick = (item: any, column: any) => {
  console.log("Cell clicked:", item, column);
  // Handle cell clicks (e.g., for links, custom actions)
};

const exportProducts = () => {
  console.log("Export products to Excel");
  // Implementation for Excel export
};

// Lifecycle
onMounted(() => {
  // Load initial data
  loading.value = true;
  setTimeout(() => {
    loading.value = false;
  }, 1000);
});
</script>

<style scoped>
.page-container {
  padding: 24px;
  max-width: 100%;
}

.page-header {
  margin-bottom: 32px;
}

.page-header h1 {
  font-size: 28px;
  font-weight: 700;
  color: #1e293b;
  margin: 0 0 8px 0;
}

.page-header p {
  font-size: 16px;
  color: #64748b;
  margin: 0;
}

.mt-8 {
  margin-top: 32px;
}

.mr-2 {
  margin-right: 8px;
}
</style>