<template>
  <div class="page-container">
    <div class="page-header">
      <h1>ການຈັດການຜູ້ໃຊ້ງານ</h1>
      <p>ຈັດການຂໍ້ມູນຜູ້ໃຊ້ງານທັງໝົດຂອງລະບົບ</p>
    </div>

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
    </DataTable>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from "vue";
import DataTable from "@/components/datatable.vue";

// Page Setup
definePageMeta({
  title: "ການຈັດການຜູ້ໃຊ້ງານ",
  layout: "default",
});

// Reactive Data
const loading = ref(false);
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
]);

const userColumns = ref([
  { key: "avatar", title: "ຮູບພາບ", type: "avatar" },
  { key: "name", title: "ຊື່", sortable: true },
  { key: "email", title: "ອີເມວ", sortable: true },
  { key: "role", title: "ບົດບາດ", type: "badge" },
  { key: "status", title: "ສະຖານະ", type: "status" },
  { key: "lastLogin", title: "ເຂົ້າສູ່ລະບົບຄັ້ງສຸດທ້າຍ", type: "date" },
]);

const statusOptions = ref([
  { title: "ໃຊ້ງານ", value: "active" },
  { title: "ບໍ່ໃຊ້ງານ", value: "inactive" },
  { title: "ລໍຖ້າ", value: "pending" },
]);

const roleOptions = ref([
  { title: "ຜູ້ບໍລິຫານ", value: "admin" },
  { title: "ຜູ້ໃຊ້ງານ", value: "user" },
  { title: "ຜູ້ຄວບຄຸມ", value: "moderator" },
]);

// Event Handlers
const handleAddUser = () => {
  console.log("Add user clicked");
};

const handleEditUser = (user: any) => {
  console.log("Edit user:", user);
};

const handleDeleteUser = (user: any) => {
  console.log("Delete user:", user);
};

const handleBulkDelete = (selected: any[]) => {
  console.log("Bulk delete:", selected);
};

onMounted(() => {
  // Load user data
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