<template>
  <div class="data-table-container">
    <!-- Table Header -->
    <div v-if="showHeader" class="table-header">
      <div class="header-content">
        <div class="header-left">
          <h3 v-if="title" class="table-title">{{ title }}</h3>
          <p v-if="subtitle" class="table-subtitle">{{ subtitle }}</p>
        </div>
        <div class="header-right">
          <slot name="header-actions">
            <v-btn
              v-if="showAddButton"
              color="primary"
              variant="flat"
              prepend-icon="mdi-plus"
              @click="$emit('add')"
              class="add-btn"
            >
              {{ addButtonText }}
            </v-btn>
          </slot>
        </div>
      </div>

      <!-- Search and Filters -->
      <div v-if="showSearch || showFilters" class="table-controls">
        <div class="search-section">
          <v-text-field
            v-if="showSearch"
            v-model="searchQuery"
            prepend-inner-icon="mdi-magnify"
            :placeholder="searchPlaceholder"
            variant="outlined"
            density="compact"
            hide-details
            clearable
            class="search-input"
          />
        </div>
        <div class="filter-section">
          <slot name="filters"></slot>
        </div>
      </div>
    </div>

    <!-- Data Table -->
    <div class="table-wrapper">
      <v-data-table
        :headers="computedHeaders"
        :items="filteredItems"
        :loading="loading"
        :server-items-length="totalItems"
        :sort-by="internalSortBy"
        :multi-sort="multiSort"
        :show-select="showSelect"
        :item-value="itemValue"
        v-model="selectedItems"
        v-model:page="currentPage"
        v-model:items-per-page="internalItemsPerPage"
        @update:options="handleOptionsUpdate"
        class="modern-data-table"
        :class="{ 'dense-table': dense, 'striped-table': striped }"
      >
        <!-- Loading Slot -->
        <template #loading>
          <div class="loading-container">
            <v-progress-circular indeterminate color="primary" size="40" />
            <p class="loading-text">{{ loadingText }}</p>
          </div>
        </template>

        <!-- Actions Column (Edit/Delete buttons) -->
        <template #item.actions="{ item }">
          <div class="action-buttons">
            <v-btn
              v-if="showEditButton"
              icon
              size="small"
              variant="text"
              color="primary"
              @click="handleEdit(item)"
              class="action-btn edit-btn"
            >
              <v-icon size="18">mdi-pencil</v-icon>
              <v-tooltip activator="parent" location="top">
                {{ editButtonText }}
              </v-tooltip>
            </v-btn>

            <v-btn
              v-if="showDeleteButton"
              icon
              size="small"
              variant="text"
              color="error"
              @click="handleDelete(item)"
              class="action-btn delete-btn"
            >
              <v-icon size="18">mdi-delete</v-icon>
              <v-tooltip activator="parent" location="top">
                {{ deleteButtonText }}
              </v-tooltip>
            </v-btn>

            <!-- Custom Actions Slot -->
            <slot name="item-actions" :item="item"></slot>
          </div>
        </template>

        <!-- Custom Cell Rendering -->
        <template
          v-for="column in customColumns"
          :key="column.key"
          #[`item.${column.key}`]="{ item }"
        >
          <CellData
            :value="getNestedValue(item, column.key)"
            :type="column.type"
            :format="column.format"
            :options="column.options"
            :item="item"
            :column="column"
            @click="handleCellClick(item, column)"
          />
        </template>

        <!-- No Data Slot -->
        <template #no-data>
          <div class="no-data-container">
            <v-icon size="64" color="grey-lighten-2">{{ noDataIcon }}</v-icon>
            <h4 class="no-data-title">{{ noDataTitle }}</h4>
            <p class="no-data-text">{{ noDataText }}</p>
            <v-btn
              v-if="showAddButton && items.length === 0"
              color="primary"
              variant="outlined"
              prepend-icon="mdi-plus"
              @click="$emit('add')"
              class="no-data-btn"
            >
              {{ addButtonText }}
            </v-btn>
          </div>
        </template>

        <!-- Bottom Slot for Custom Content -->
        <template #bottom>
          <slot name="table-bottom"></slot>
        </template>
      </v-data-table>
    </div>

    <!-- Bulk Actions (when items are selected) -->
    <div v-if="showSelect && selectedItems.length > 0" class="bulk-actions">
      <div class="bulk-info">
        <span class="selected-count"
          >{{ selectedItems.length }} ລາຍການທີ່ເລືອກ</span
        >
      </div>
      <div class="bulk-buttons">
        <slot name="bulk-actions" :selected="selectedItems">
          <v-btn
            variant="outlined"
            color="error"
            prepend-icon="mdi-delete"
            @click="handleBulkDelete"
            class="bulk-btn"
          >
            ລຶບທີ່ເລືອກ
          </v-btn>
        </slot>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch } from "vue";

// Types
interface Column {
  key: string;
  title: string;
  type?:
    | "text"
    | "number"
    | "date"
    | "currency"
    | "status"
    | "image"
    | "chip"
    | "link"
    | "custom";
  format?: string | object;
  sortable?: boolean;
  width?: string | number;
  align?: "start" | "center" | "end";
  options?: any;
  hidden?: boolean;
}

interface TableItem {
  [key: string]: any;
}

interface DataTableHeader {
  title: string;
  key: string;
  sortable: boolean;
  width?: string | number;
  align: "start" | "center" | "end";
}

// Props
interface Props {
  // Data
  items: TableItem[];
  columns: Column[];
  loading?: boolean;
  totalItems?: number;

  // Table Configuration
  title?: string;
  subtitle?: string;
  showHeader?: boolean;
  showSearch?: boolean;
  showFilters?: boolean;
  showSelect?: boolean;
  showAddButton?: boolean;
  showEditButton?: boolean;
  showDeleteButton?: boolean;

  // Pagination
  itemsPerPage?: number;
  serverSide?: boolean;

  // Styling
  dense?: boolean;
  striped?: boolean;

  // Text Customization
  searchPlaceholder?: string;
  loadingText?: string;
  addButtonText?: string;
  editButtonText?: string;
  deleteButtonText?: string;
  noDataTitle?: string;
  noDataText?: string;
  noDataIcon?: string;

  // Table Options
  itemValue?: string;
  multiSort?: boolean;
  sortBy?: any[];
}

const props = withDefaults(defineProps<Props>(), {
  loading: false,
  totalItems: 0,
  showHeader: true,
  showSearch: true,
  showFilters: false,
  showSelect: false,
  showAddButton: true,
  showEditButton: true,
  showDeleteButton: true,
  itemsPerPage: 10,
  serverSide: false,
  dense: false,
  striped: true,
  searchPlaceholder: "ຄົ້ນຫາ...",
  loadingText: "ກຳລັງໂຫຼດຂໍ້ມູນ...",
  addButtonText: "ເພີ່ມໃໝ່",
  editButtonText: "ແກ້ໄຂ",
  deleteButtonText: "ລຶບ",
  noDataTitle: "ບໍ່ມີຂໍ້ມູນ",
  noDataText: "ບໍ່ມີຂໍ້ມູນທີ່ຈະສະແດງ",
  noDataIcon: "mdi-database-off",
  itemValue: "id",
  multiSort: false,
  sortBy: () => [],
});

// Emits
const emit = defineEmits<{
  add: [];
  edit: [item: TableItem];
  delete: [item: TableItem];
  bulkDelete: [items: TableItem[]];
  cellClick: [item: TableItem, column: Column];
  optionsUpdate: [options: any];
}>();

// Reactive Data
const searchQuery = ref("");
const selectedItems = ref<TableItem[]>([]);
const currentPage = ref(1);
const internalSortBy = ref(props.sortBy);
const internalItemsPerPage = ref(props.itemsPerPage);

// Computed Properties
const computedHeaders = computed((): DataTableHeader[] => {
  const headers: DataTableHeader[] = [];

  // Add actions column at the start if needed
  if (props.showEditButton || props.showDeleteButton) {
    headers.push({
      title: "ການດຳເນີນການ",
      key: "actions",
      sortable: false,
      width: props.showEditButton && props.showDeleteButton ? 120 : 80,
      align: "center",
    });
  }

  // Add regular columns
  headers.push(
    ...props.columns
      .filter((col) => !col.hidden)
      .map((col) => ({
        title: col.title,
        key: col.key,
        sortable: col.sortable !== false,
        width: col.width,
        align: col.align || "start",
      }))
  );

  return headers;
});

const customColumns = computed(() => {
  return props.columns.filter((col) => col.type && col.type !== "text");
});

const filteredItems = computed(() => {
  if (!props.serverSide && searchQuery.value) {
    const query = searchQuery.value.toLowerCase();
    return props.items.filter((item) => {
      return props.columns.some((column) => {
        const value = getNestedValue(item, column.key);
        return value?.toString().toLowerCase().includes(query);
      });
    });
  }
  return props.items;
});

// Methods
const getNestedValue = (obj: any, path: string): any => {
  return path.split(".").reduce((current, key) => current?.[key], obj);
};

const handleEdit = (item: TableItem) => {
  emit("edit", item);
};

const handleDelete = (item: TableItem) => {
  emit("delete", item);
};

const handleBulkDelete = () => {
  emit("bulkDelete", selectedItems.value);
  selectedItems.value = [];
};

const handleCellClick = (item: TableItem, column: Column) => {
  emit("cellClick", item, column);
};

const handleOptionsUpdate = (options: any) => {
  emit("optionsUpdate", options);
};

// Watch for search changes (for server-side)
watch(searchQuery, (newValue) => {
  if (props.serverSide) {
    emit("optionsUpdate", {
      page: 1,
      itemsPerPage: internalItemsPerPage.value,
      search: newValue,
      sortBy: internalSortBy.value,
    });
  }
});

// Watch for internal changes
watch(internalSortBy, (newValue) => {
  if (props.serverSide) {
    emit("optionsUpdate", {
      page: currentPage.value,
      itemsPerPage: internalItemsPerPage.value,
      search: searchQuery.value,
      sortBy: newValue,
    });
  }
});

watch(internalItemsPerPage, (newValue) => {
  if (props.serverSide) {
    emit("optionsUpdate", {
      page: 1,
      itemsPerPage: newValue,
      search: searchQuery.value,
      sortBy: internalSortBy.value,
    });
  }
});
</script>

<style scoped>
.data-table-container {
  background: white;
  border-radius: 16px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  overflow: hidden;
  border: 1px solid rgba(0, 0, 0, 0.05);
}

/* Header Styles */
.table-header {
  padding: 24px 24px 16px;
  border-bottom: 1px solid rgba(0, 0, 0, 0.06);
  background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
}

.header-content {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 16px;
}

.header-left {
  flex: 1;
}

.table-title {
  font-size: 20px;
  font-weight: 600;
  color: #1e293b;
  margin: 0 0 4px 0;
}

.table-subtitle {
  font-size: 14px;
  color: #64748b;
  margin: 0;
}

.header-right {
  display: flex;
  gap: 12px;
  align-items: center;
}

.add-btn {
  font-weight: 600;
  border-radius: 12px;
  padding: 0 24px;
  box-shadow: 0 2px 8px rgba(59, 130, 246, 0.3);
}

/* Controls Styles */
.table-controls {
  display: flex;
  gap: 16px;
  align-items: center;
  flex-wrap: wrap;
}

.search-section {
  flex: 1;
  min-width: 280px;
}

.search-input {
  max-width: 400px;
}

.search-input :deep(.v-field) {
  border-radius: 12px;
  background: white;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
}

.filter-section {
  display: flex;
  gap: 12px;
  align-items: center;
}

/* Table Wrapper */
.table-wrapper {
  overflow: hidden;
}

/* Modern Data Table Styles */
.modern-data-table {
  background: transparent;
}

.modern-data-table :deep(.v-data-table__wrapper) {
  border-radius: 0;
  box-shadow: none;
}

.modern-data-table :deep(.v-data-table-header) {
  background: #f8fafc;
  border-bottom: 2px solid #e2e8f0;
}

.modern-data-table :deep(.v-data-table-header__content) {
  font-weight: 600;
  color: #475569;
  font-size: 13px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.modern-data-table :deep(tr) {
  transition: all 0.2s ease;
}

.modern-data-table :deep(tbody tr:hover) {
  background: rgba(59, 130, 246, 0.04) !important;
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}

.modern-data-table.striped-table :deep(tbody tr:nth-child(even)) {
  background: rgba(248, 250, 252, 0.5);
}

.modern-data-table.dense-table :deep(.v-data-table__td),
.modern-data-table.dense-table :deep(.v-data-table__th) {
  padding: 8px 16px;
  height: 48px;
}

.modern-data-table :deep(.v-data-table__td) {
  border-bottom: 1px solid #f1f5f9;
  padding: 12px 16px;
  vertical-align: middle;
}

/* Action Buttons */
.action-buttons {
  display: flex;
  gap: 4px;
  align-items: center;
  justify-content: center;
}

.action-btn {
  border-radius: 8px;
  transition: all 0.2s ease;
}

.edit-btn:hover {
  background: rgba(59, 130, 246, 0.1);
  transform: scale(1.05);
}

.delete-btn:hover {
  background: rgba(239, 68, 68, 0.1);
  transform: scale(1.05);
}

/* Loading Container */
.loading-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 40px;
  gap: 16px;
}

.loading-text {
  color: #64748b;
  font-size: 14px;
  margin: 0;
}

/* No Data Container */
.no-data-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 60px 40px;
  text-align: center;
}

.no-data-title {
  color: #475569;
  font-size: 18px;
  font-weight: 600;
  margin: 16px 0 8px 0;
}

.no-data-text {
  color: #64748b;
  font-size: 14px;
  margin: 0 0 24px 0;
}

.no-data-btn {
  border-radius: 12px;
  font-weight: 600;
}

/* Bulk Actions */
.bulk-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 24px;
  background: #f0f9ff;
  border-top: 1px solid #e0f2fe;
}

.bulk-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.selected-count {
  font-weight: 600;
  color: #0369a1;
  font-size: 14px;
}

.bulk-buttons {
  display: flex;
  gap: 12px;
}

.bulk-btn {
  border-radius: 10px;
  font-weight: 600;
}

/* Responsive Design */
@media (max-width: 768px) {
  .table-header {
    padding: 16px;
  }

  .header-content {
    flex-direction: column;
    gap: 16px;
    align-items: stretch;
  }

  .table-controls {
    flex-direction: column;
    align-items: stretch;
  }

  .search-section {
    min-width: auto;
  }

  .bulk-actions {
    flex-direction: column;
    gap: 12px;
    align-items: stretch;
  }

  .action-buttons {
    flex-direction: column;
    gap: 2px;
  }
}

/* Animation for row hover */
@keyframes rowHover {
  from {
    transform: translateY(0);
    box-shadow: none;
  }
  to {
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  }
}
</style>