<template>
  <div class="cell-data" :class="`cell-type-${type}`">
    <!-- Text Type -->
    <span v-if="type === 'text'" class="cell-text">
      {{ displayValue }}
    </span>

    <!-- Number Type -->
    <span v-else-if="type === 'number'" class="cell-number">
      {{ formatNumber(value) }}
    </span>

    <!-- Currency Type -->
    <span v-else-if="type === 'currency'" class="cell-currency">
      {{ formatCurrency(value) }}
    </span>

    <!-- Date Type -->
    <span v-else-if="type === 'date'" class="cell-date">
      {{ formatDate(value) }}
    </span>

    <!-- Status Type -->
    <v-chip
      v-else-if="type === 'status'"
      :color="getStatusColor(value)"
      :variant="getStatusVariant(value)"
      size="small"
      class="cell-status"
    >
      <v-icon
        v-if="getStatusIcon(value)"
        :icon="getStatusIcon(value)"
        size="16"
        class="mr-1"
      />
      {{ getStatusText(value) }}
    </v-chip>

    <!-- Chip Type -->
    <div v-else-if="type === 'chip'" class="cell-chips">
      <v-chip
        v-for="(chip, index) in getChipArray(value)"
        :key="index"
        :color="chip.color || 'primary'"
        :variant="chip.variant || 'tonal'"
        size="small"
        class="chip-item"
      >
        <v-icon v-if="chip.icon" :icon="chip.icon" size="14" class="mr-1" />
        {{ chip.text || chip }}
      </v-chip>
    </div>

    <!-- Image Type -->
    <div v-else-if="type === 'image'" class="cell-image">
      <v-avatar :size="options?.size || 32" class="image-avatar">
        <v-img
          :src="value || options?.placeholder"
          :alt="options?.alt || 'Image'"
          @error="handleImageError"
        >
          <template #placeholder>
            <div class="image-placeholder">
              <v-icon :icon="options?.placeholderIcon || 'mdi-image'" />
            </div>
          </template>
        </v-img>
      </v-avatar>
    </div>

    <!-- Link Type -->
    <NuxtLink
      v-else-if="type === 'link'"
      :to="getLinkUrl(value)"
      :target="options?.target || '_self'"
      class="cell-link"
      @click="handleLinkClick"
    >
      <v-icon
        v-if="options?.icon"
        :icon="options.icon"
        size="16"
        class="mr-1"
      />
      {{ getLinkText(value) }}
    </NuxtLink>
    <div v-else-if="type === 'boolean'" class="cell-boolean">
      <v-icon
        :icon="value ? 'mdi-check-circle' : 'mdi-close-circle'"
        :color="value ? 'success' : 'error'"
        size="20"
      />
      <span class="boolean-text">
        {{
          value ? options?.trueText || "ແມ່ນ" : options?.falseText || "ບໍ່ແມ່ນ"
        }}
      </span>
    </div>

    <!-- Progress Type -->
    <div v-else-if="type === 'progress'" class="cell-progress">
      <v-progress-linear
        :model-value="value"
        :color="getProgressColor(value)"
        height="8"
        rounded
        class="progress-bar"
      />
      <span class="progress-text">{{ value }}%</span>
    </div>

    <!-- Rating Type -->
    <div v-else-if="type === 'rating'" class="cell-rating">
      <v-rating
        :model-value="value"
        :length="options?.max || 5"
        :size="options?.size || 'small'"
        :color="options?.color || 'amber'"
        readonly
        half-increments
        density="compact"
      />
      <span v-if="options?.showValue" class="rating-value">
        ({{ value }})
      </span>
    </div>

    <!-- Actions Type -->
    <div v-else-if="type === 'actions'" class="cell-actions">
      <v-btn
        v-for="action in getActions()"
        :key="action.key"
        :icon="action.icon"
        :color="action.color"
        :variant="action.variant || 'text'"
        :size="action.size || 'small'"
        @click="handleActionClick(action)"
        class="action-btn"
      >
        <v-icon :icon="action.icon" />
        <v-tooltip activator="parent" location="top">
          {{ action.tooltip }}
        </v-tooltip>
      </v-btn>
    </div>

    <!-- Custom Type -->
    <div v-else-if="type === 'custom'" class="cell-custom">
      <slot name="custom" :value="value" :item="item" :column="column">
        {{ displayValue }}
      </slot>
    </div>

    <!-- Default Text -->
    <span v-else class="cell-default">
      {{ displayValue }}
    </span>
  </div>
</template>

<script setup lang="ts">
import { computed } from "vue";

// Types
interface ChipData {
  text?: string;
  color?: string;
  variant?: string;
  icon?: string;
}

interface ActionData {
  key: string;
  icon: string;
  tooltip: string;
  color?: string;
  variant?: string;
  size?: string;
  handler?: (item: any) => void;
}

interface Props {
  value: any;
  type?:
    | "text"
    | "number"
    | "currency"
    | "date"
    | "status"
    | "chip"
    | "image"
    | "link"
    | "boolean"
    | "progress"
    | "rating"
    | "actions"
    | "custom";
  format?: string | object;
  options?: any;
  item?: any;
  column?: any;
}

const props = withDefaults(defineProps<Props>(), {
  type: "text",
  format: "",
  options: () => ({}),
  item: () => ({}),
  column: () => ({}),
});

// Emits
const emit = defineEmits<{
  click: [value: any, item: any, column: any];
  actionClick: [action: string, item: any];
}>();

// Computed Properties
const displayValue = computed(() => {
  if (props.value === null || props.value === undefined) {
    return props.options?.emptyText || "-";
  }
  return props.value;
});

// Formatting Methods
const formatNumber = (value: number) => {
  if (typeof value !== "number") return value;

  const options = (props.format as Intl.NumberFormatOptions) || {};
  return new Intl.NumberFormat("lo-LA", {
    minimumFractionDigits: 0,
    maximumFractionDigits: 2,
    ...options,
  }).format(value);
};

const formatCurrency = (value: number) => {
  if (typeof value !== "number") return value;

  const currency = props.options?.currency || "LAK";
  const locale = props.options?.locale || "lo-LA";

  return new Intl.NumberFormat(locale, {
    style: "currency",
    currency: currency,
    minimumFractionDigits: 0,
    maximumFractionDigits: 2,
  }).format(value);
};

const formatDate = (value: string | Date) => {
  if (!value) return "-";

  const date = new Date(value);
  if (isNaN(date.getTime())) return value;

  const format = (props.format as string) || "dd/MM/yyyy";
  const locale = props.options?.locale || "lo-LA";

  // Simple date formatting
  if (format === "relative") {
    return getRelativeTime(date);
  }

  return new Intl.DateTimeFormat(locale, {
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    hour: format.includes("HH") ? "2-digit" : undefined,
    minute: format.includes("mm") ? "2-digit" : undefined,
  }).format(date);
};

const getRelativeTime = (date: Date) => {
  const now = new Date();
  const diffInMs = now.getTime() - date.getTime();
  const diffInDays = Math.floor(diffInMs / (1000 * 60 * 60 * 24));

  if (diffInDays === 0) return "ມື້ນີ້";
  if (diffInDays === 1) return "ມື້ວານ";
  if (diffInDays < 7) return `${diffInDays} ມື້ກ່ອນ`;
  if (diffInDays < 30) return `${Math.floor(diffInDays / 7)} ອາທິດກ່ອນ`;
  if (diffInDays < 365) return `${Math.floor(diffInDays / 30)} ເດືອນກ່ອນ`;
  return `${Math.floor(diffInDays / 365)} ປີກ່ອນ`;
};

// Status Methods
const getStatusColor = (status: string) => {
  const statusConfig = props.options?.statusConfig || {};
  const defaultColors: Record<string, string> = {
    active: "success",
    inactive: "error",
    pending: "warning",
    completed: "success",
    cancelled: "error",
    draft: "info",
    published: "success",
    archived: "grey",
  };

  return (
    statusConfig[status]?.color ||
    defaultColors[status?.toLowerCase()] ||
    "primary"
  );
};

const getStatusVariant = (status: string) => {
  const statusConfig = props.options?.statusConfig || {};
  return statusConfig[status]?.variant || "tonal";
};

const getStatusIcon = (status: string) => {
  const statusConfig = props.options?.statusConfig || {};
  const defaultIcons: Record<string, string> = {
    active: "mdi-check-circle",
    inactive: "mdi-close-circle",
    pending: "mdi-clock-outline",
    completed: "mdi-check-circle",
    cancelled: "mdi-cancel",
    draft: "mdi-file-outline",
    published: "mdi-publish",
    archived: "mdi-archive",
  };

  return statusConfig[status]?.icon || defaultIcons[status?.toLowerCase()];
};

const getStatusText = (status: string) => {
  const statusConfig = props.options?.statusConfig || {};
  const defaultTexts: Record<string, string> = {
    active: "ເປີດໃຊ້ງານ",
    inactive: "ປິດໃຊ້ງານ",
    pending: "ລໍຖ້າ",
    completed: "ສຳເລັດ",
    cancelled: "ຍົກເລີກ",
    draft: "ຮ່າງ",
    published: "ເຜີຍແຜ່",
    archived: "ເກັບມ້ຽນ",
  };

  return (
    statusConfig[status]?.text || defaultTexts[status?.toLowerCase()] || status
  );
};

// Chip Methods
const getChipArray = (value: any) => {
  if (Array.isArray(value)) return value;
  if (typeof value === "string") {
    try {
      const parsed = JSON.parse(value);
      return Array.isArray(parsed) ? parsed : [value];
    } catch {
      return value.split(",").map((item: string) => item.trim());
    }
  }
  return [value];
};

// Link Methods
const getLinkUrl = (value: any) => {
  if (typeof value === "object" && value.url) return value.url;
  if (props.options?.urlTemplate) {
    return props.options.urlTemplate.replace("{value}", value);
  }
  return value;
};

const getLinkText = (value: any) => {
  if (typeof value === "object" && value.text) return value.text;
  if (props.options?.textTemplate) {
    return props.options.textTemplate.replace("{value}", value);
  }
  return value;
};

// Progress Methods
const getProgressColor = (value: number) => {
  if (value >= 80) return "success";
  if (value >= 60) return "info";
  if (value >= 40) return "warning";
  return "error";
};

// Actions Methods
const getActions = () => {
  return props.options?.actions || [];
};

// Event Handlers
const handleImageError = (value: string | undefined) => {
  // This handler is called with the src value that failed to load.
  // You can update a local fallback if needed, or leave empty if v-img handles placeholder.
};

const handleLinkClick = () => {
  emit("click", props.value, props.item, props.column);
};

const handleActionClick = (action: ActionData) => {
  if (action.handler) {
    action.handler(props.item);
  }
  emit("actionClick", action.key, props.item);
};
</script>

<style scoped>
.cell-data {
  display: flex;
  align-items: center;
  min-height: 32px;
  gap: 4px;
}

/* Text Styles */
.cell-text {
  color: #334155;
  font-size: 14px;
  line-height: 1.4;
}

.cell-number {
  color: #1e293b;
  font-size: 14px;
  font-weight: 500;
  font-variant-numeric: tabular-nums;
}

.cell-currency {
  color: #059669;
  font-size: 14px;
  font-weight: 600;
  font-variant-numeric: tabular-nums;
}

.cell-date {
  color: #64748b;
  font-size: 13px;
  font-variant-numeric: tabular-nums;
}

/* Status Styles */
.cell-status {
  font-weight: 500;
  font-size: 12px;
  text-transform: capitalize;
}

/* Chip Styles */
.cell-chips {
  display: flex;
  flex-wrap: wrap;
  gap: 4px;
  align-items: center;
}

.chip-item {
  font-size: 11px;
  font-weight: 500;
}

/* Image Styles */
.cell-image {
  display: flex;
  align-items: center;
}

.image-avatar {
  border: 2px solid rgba(0, 0, 0, 0.08);
  overflow: hidden;
}

.image-placeholder {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100%;
  background: #f1f5f9;
  color: #94a3b8;
}

/* Link Styles */
.cell-link {
  color: #3b82f6;
  text-decoration: none;
  font-weight: 500;
  font-size: 14px;
  display: flex;
  align-items: center;
  transition: all 0.2s ease;
  border-radius: 6px;
  padding: 2px 6px;
  margin: -2px -6px;
}

.cell-link:hover {
  color: #1d4ed8;
  background: rgba(59, 130, 246, 0.1);
  text-decoration: underline;
}

/* Boolean Styles */
.cell-boolean {
  display: flex;
  align-items: center;
  gap: 6px;
}

.boolean-text {
  font-size: 13px;
  font-weight: 500;
}

/* Progress Styles */
.cell-progress {
  display: flex;
  align-items: center;
  gap: 8px;
  width: 100%;
  max-width: 120px;
}

.progress-bar {
  flex: 1;
  border-radius: 4px;
}

.progress-text {
  font-size: 12px;
  font-weight: 500;
  color: #64748b;
  min-width: 32px;
  text-align: right;
}

/* Rating Styles */
.cell-rating {
  display: flex;
  align-items: center;
  gap: 6px;
}

.rating-value {
  font-size: 12px;
  color: #64748b;
  font-weight: 500;
}

/* Actions Styles */
.cell-actions {
  display: flex;
  gap: 2px;
  align-items: center;
}

.action-btn {
  border-radius: 6px;
  transition: all 0.2s ease;
}

.action-btn:hover {
  transform: scale(1.05);
}

/* Custom Styles */
.cell-custom {
  width: 100%;
}

/* Default Styles */
.cell-default {
  color: #374151;
  font-size: 14px;
}

/* Cell Type Specific Styles */
.cell-type-currency {
  justify-content: flex-end;
}

.cell-type-number {
  justify-content: flex-end;
}

.cell-type-progress {
  width: 100%;
}

.cell-type-actions {
  justify-content: center;
}

.cell-type-boolean {
  justify-content: center;
}

.cell-type-rating {
  justify-content: center;
}

/* Responsive Design */
@media (max-width: 768px) {
  .cell-chips {
    flex-direction: column;
    align-items: flex-start;
  }

  .cell-progress {
    max-width: 100px;
  }

  .progress-text {
    min-width: 28px;
    font-size: 11px;
  }

  .cell-actions {
    flex-direction: column;
    gap: 1px;
  }
}

/* Animation for hover effects */
@keyframes cellHover {
  from {
    transform: scale(1);
  }
  to {
    transform: scale(1.02);
  }
}

.cell-link:hover,
.action-btn:hover {
  animation: cellHover 0.2s ease forwards;
}
</style>