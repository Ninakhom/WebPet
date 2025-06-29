<template>
  <v-app>
    <v-navigation-drawer
      v-model="drawer"
      :rail="rail"
      permanent
      class="modern-sidebar"
      :width="280"
      rail-width="80"
    >
      <!-- Header Section -->
      <div class="sidebar-header">
        <div class="brand-section">
          <div class="logo-container">
            <div class="logo-icon">
              <v-icon color="white" size="28">mdi-storefront</v-icon>
            </div>
          </div>
          <Transition name="fade-slide" mode="out-in">
            <div v-if="!rail" class="brand-text">
              <h2 class="brand-title">ພັດທະນາ</h2>
              <p class="brand-subtitle">ລະບົບຄຸ້ມຄອງ</p>
            </div>
          </Transition>
        </div>

        <v-btn
          icon
          variant="text"
          size="small"
          @click="toggleRail"
          class="rail-toggle"
          :class="{ 'rail-active': rail }"
        >
          <v-icon size="20">{{ rail ? "mdi-menu" : "mdi-menu-open" }}</v-icon>
        </v-btn>
      </div>

      <!-- Navigation Menu -->
      <div class="nav-container">
        <div class="nav-section">
          <div v-if="!rail" class="section-header">
            <span class="section-title">ໜ້າຫຼັກ</span>
          </div>

          <!-- Dashboard -->
          <NuxtLink to="/" class="nav-link" @click="setActiveItem('/')">
            <div class="nav-item" :class="{ active: activeItem === '/' }">
              <div class="nav-icon">
                <v-icon size="20">mdi-view-dashboard-variant</v-icon>
              </div>
              <Transition name="fade-slide" mode="out-in">
                <span v-if="!rail" class="nav-text">User</span>
              </Transition>
              <div v-if="activeItem === '/'" class="active-indicator"></div>
            </div>
            <v-tooltip
              v-if="rail"
              activator="parent"
              location="end"
              offset="10"
            >
              <div class="tooltip-content">User</div>
            </v-tooltip>
          </NuxtLink>
        </div>

        <!-- Management Section -->
        <div class="nav-section">
          <div class="nav-group">
            <div
              class="nav-group-header"
              :class="{ expanded: managementExpanded, 'rail-mode': rail }"
              @click="toggleManagement"
            >
              <div class="nav-icon">
                <v-icon size="20">mdi-cog-outline</v-icon>
              </div>
              <Transition name="fade-slide" mode="out-in">
                <span v-if="!rail" class="nav-text">ການຈັດການຂໍ້ມູນ</span>
              </Transition>
              <Transition name="fade-slide" mode="out-in">
                <div v-if="!rail" class="nav-arrow">
                  <v-icon size="16" :class="{ rotated: managementExpanded }">
                    mdi-chevron-down
                  </v-icon>
                </div>
              </Transition>
            </div>
            <v-tooltip
              v-if="rail"
              activator="parent"
              location="end"
              offset="10"
            >
              <div class="tooltip-content">ການຈັດການຂໍ້ມູນ</div>
            </v-tooltip>

            <!-- Submenu Items -->
            <Transition name="submenu" mode="out-in">
              <div v-if="managementExpanded && !rail" class="nav-submenu">
                <!-- Users -->
                <NuxtLink
                  to="/user"
                  class="nav-link submenu-link"
                  @click="setActiveItem('/user')"
                >
                  <div
                    class="nav-item submenu-item"
                    :class="{ active: activeItem === '/user' }"
                  >
                    <div class="nav-icon">
                      <v-icon size="18">mdi-account-group</v-icon>
                    </div>
                    <span class="nav-text">ຜູ້ໃຊ້ງານ</span>
                    <div class="notification-badge">3</div>
                    <div
                      v-if="activeItem === '/user'"
                      class="active-indicator"
                    ></div>
                  </div>
                </NuxtLink>

                <!-- Products -->
                <NuxtLink
                  to="/products"
                  class="nav-link submenu-link"
                  @click="setActiveItem('/products')"
                >
                  <div
                    class="nav-item submenu-item"
                    :class="{ active: activeItem === '/products' }"
                  >
                    <div class="nav-icon">
                      <v-icon size="18">mdi-package-variant-closed</v-icon>
                    </div>
                    <span class="nav-text">ສິນຄ້າ</span>
                    <div
                      v-if="activeItem === '/products'"
                      class="active-indicator"
                    ></div>
                  </div>
                </NuxtLink>

                <!-- Orders -->
                <NuxtLink
                  to="/orders"
                  class="nav-link submenu-link"
                  @click="setActiveItem('/orders')"
                >
                  <div
                    class="nav-item submenu-item"
                    :class="{ active: activeItem === '/orders' }"
                  >
                    <div class="nav-icon">
                      <v-icon size="18">mdi-receipt</v-icon>
                    </div>
                    <span class="nav-text">ຄໍາສັ່ງຊື້</span>
                    <div class="notification-badge urgent">12</div>
                    <div
                      v-if="activeItem === '/orders'"
                      class="active-indicator"
                    ></div>
                  </div>
                </NuxtLink>

                <!-- Inventory -->
                <NuxtLink
                  to="/inventory"
                  class="nav-link submenu-link"
                  @click="setActiveItem('/inventory')"
                >
                  <div
                    class="nav-item submenu-item"
                    :class="{ active: activeItem === '/inventory' }"
                  >
                    <div class="nav-icon">
                      <v-icon size="18">mdi-warehouse</v-icon>
                    </div>
                    <span class="nav-text">ສາງເກັບ</span>
                    <div
                      v-if="activeItem === '/inventory'"
                      class="active-indicator"
                    ></div>
                  </div>
                </NuxtLink>
              </div>
            </Transition>

            <!-- Rail Mode Submenu (Shows on hover) -->
            <div v-if="rail" class="rail-submenu" v-show="false">
              <div class="rail-submenu-content">
                <h4 class="rail-submenu-title">ການຈັດການຂໍ້ມູນ</h4>
                <NuxtLink
                  to="/user"
                  class="rail-submenu-item"
                  @click="setActiveItem('/user')"
                >
                  <v-icon size="16">mdi-account-group</v-icon>
                  <span>ຜູ້ໃຊ້ງານ</span>
                  <div class="notification-badge small">3</div>
                </NuxtLink>
                <NuxtLink
                  to="/products"
                  class="rail-submenu-item"
                  @click="setActiveItem('/products')"
                >
                  <v-icon size="16">mdi-package-variant-closed</v-icon>
                  <span>ສິນຄ້າ</span>
                </NuxtLink>
                <NuxtLink
                  to="/orders"
                  class="rail-submenu-item"
                  @click="setActiveItem('/orders')"
                >
                  <v-icon size="16">mdi-receipt</v-icon>
                  <span>ຄໍາສັ່ງຊື້</span>
                  <div class="notification-badge small urgent">12</div>
                </NuxtLink>
                <NuxtLink
                  to="/inventory"
                  class="rail-submenu-item"
                  @click="setActiveItem('/inventory')"
                >
                  <v-icon size="16">mdi-warehouse</v-icon>
                  <span>ສາງເກັບ</span>
                </NuxtLink>
              </div>
            </div>
          </div>
        </div>

        <!-- Service Section -->
        <div class="nav-section">
          <div class="nav-group">
            <div
              class="nav-group-header"
              :class="{ expanded: serviceExpanded, 'rail-mode': rail }"
              @click="toggleService"
            >
              <div class="nav-icon">
                <v-icon size="20">mdi-tools</v-icon>
              </div>
              <Transition name="fade-slide" mode="out-in">
                <span v-if="!rail" class="nav-text">ການບໍລິການ</span>
              </Transition>
              <Transition name="fade-slide" mode="out-in">
                <div v-if="!rail" class="nav-arrow">
                  <v-icon size="16" :class="{ rotated: serviceExpanded }">
                    mdi-chevron-down
                  </v-icon>
                </div>
              </Transition>
            </div>
            <v-tooltip
              v-if="rail"
              activator="parent"
              location="end"
              offset="10"
            >
              <div class="tooltip-content">ການບໍລິການ</div>
            </v-tooltip>

            <!-- Service Submenu Items -->
            <Transition name="submenu" mode="out-in">
              <div v-if="serviceExpanded && !rail" class="nav-submenu">
                <!-- Customer Service -->
                <NuxtLink
                  to="/customer-service"
                  class="nav-link submenu-link"
                  @click="setActiveItem('/customer-service')"
                >
                  <div
                    class="nav-item submenu-item"
                    :class="{ active: activeItem === '/customer-service' }"
                  >
                    <div class="nav-icon">
                      <v-icon size="18">mdi-account-heart</v-icon>
                    </div>
                    <span class="nav-text">ບໍລິການລູກຄ້າ</span>
                    <div
                      v-if="activeItem === '/customer-service'"
                      class="active-indicator"
                    ></div>
                  </div>
                </NuxtLink>

                <!-- Support -->
                <NuxtLink
                  to="/support"
                  class="nav-link submenu-link"
                  @click="setActiveItem('/support')"
                >
                  <div
                    class="nav-item submenu-item"
                    :class="{ active: activeItem === '/support' }"
                  >
                    <div class="nav-icon">
                      <v-icon size="18">mdi-lifebuoy</v-icon>
                    </div>
                    <span class="nav-text">ຊ່ວຍເຫຼືອ</span>
                    <div
                      v-if="activeItem === '/support'"
                      class="active-indicator"
                    ></div>
                  </div>
                </NuxtLink>

                <!-- Maintenance -->
                <NuxtLink
                  to="/maintenance"
                  class="nav-link submenu-link"
                  @click="setActiveItem('/maintenance')"
                >
                  <div
                    class="nav-item submenu-item"
                    :class="{ active: activeItem === '/maintenance' }"
                  >
                    <div class="nav-icon">
                      <v-icon size="18">mdi-wrench</v-icon>
                    </div>
                    <span class="nav-text">ບໍາລຸງຮັກສາ</span>
                    <div
                      v-if="activeItem === '/maintenance'"
                      class="active-indicator"
                    ></div>
                  </div>
                </NuxtLink>
              </div>
            </Transition>

            <!-- Rail Mode Service Submenu -->
            <div v-if="rail" class="rail-submenu" v-show="false">
              <div class="rail-submenu-content">
                <h4 class="rail-submenu-title">ການບໍລິການ</h4>
                <NuxtLink
                  to="/customer-service"
                  class="rail-submenu-item"
                  @click="setActiveItem('/customer-service')"
                >
                  <v-icon size="16">mdi-account-heart</v-icon>
                  <span>ບໍລິການລູກຄ້າ</span>
                </NuxtLink>
                <NuxtLink
                  to="/support"
                  class="rail-submenu-item"
                  @click="setActiveItem('/support')"
                >
                  <v-icon size="16">mdi-lifebuoy</v-icon>
                  <span>ຊ່ວຍເຫຼືອ</span>
                </NuxtLink>
                <NuxtLink
                  to="/maintenance"
                  class="rail-submenu-item"
                  @click="setActiveItem('/maintenance')"
                >
                  <v-icon size="16">mdi-wrench</v-icon>
                  <span>ບໍາລຸງຮັກສາ</span>
                </NuxtLink>
              </div>
            </div>
          </div>
        </div>

        <!-- Reports Section -->
        <div class="nav-section">
          <div class="nav-group">
            <div
              class="nav-group-header"
              :class="{ expanded: reportExpanded, 'rail-mode': rail }"
              @click="toggleReport"
            >
              <div class="nav-icon">
                <v-icon size="20">mdi-chart-box</v-icon>
              </div>
              <Transition name="fade-slide" mode="out-in">
                <span v-if="!rail" class="nav-text">ລາຍງານ</span>
              </Transition>
              <Transition name="fade-slide" mode="out-in">
                <div v-if="!rail" class="nav-arrow">
                  <v-icon size="16" :class="{ rotated: reportExpanded }">
                    mdi-chevron-down
                  </v-icon>
                </div>
              </Transition>
            </div>
            <v-tooltip
              v-if="rail"
              activator="parent"
              location="end"
              offset="10"
            >
              <div class="tooltip-content">ລາຍງານ</div>
            </v-tooltip>

            <!-- Reports Submenu Items -->
            <Transition name="submenu" mode="out-in">
              <div v-if="reportExpanded && !rail" class="nav-submenu">
                <!-- Sales Report -->
                <NuxtLink
                  to="/reports/sales"
                  class="nav-link submenu-link"
                  @click="setActiveItem('/reports/sales')"
                >
                  <div
                    class="nav-item submenu-item"
                    :class="{ active: activeItem === '/reports/sales' }"
                  >
                    <div class="nav-icon">
                      <v-icon size="18">mdi-chart-line</v-icon>
                    </div>
                    <span class="nav-text">ລາຍງານການຂາຍ</span>
                    <div
                      v-if="activeItem === '/reports/sales'"
                      class="active-indicator"
                    ></div>
                  </div>
                </NuxtLink>

                <!-- Statistics -->
                <NuxtLink
                  to="/reports/statistics"
                  class="nav-link submenu-link"
                  @click="setActiveItem('/reports/statistics')"
                >
                  <div
                    class="nav-item submenu-item"
                    :class="{ active: activeItem === '/reports/statistics' }"
                  >
                    <div class="nav-icon">
                      <v-icon size="18">mdi-poll</v-icon>
                    </div>
                    <span class="nav-text">ສະຖິຕິ</span>
                    <div
                      v-if="activeItem === '/reports/statistics'"
                      class="active-indicator"
                    ></div>
                  </div>
                </NuxtLink>

                <!-- Financial Report -->
                <NuxtLink
                  to="/reports/financial"
                  class="nav-link submenu-link"
                  @click="setActiveItem('/reports/financial')"
                >
                  <div
                    class="nav-item submenu-item"
                    :class="{ active: activeItem === '/reports/financial' }"
                  >
                    <div class="nav-icon">
                      <v-icon size="18">mdi-currency-usd</v-icon>
                    </div>
                    <span class="nav-text">ລາຍງານການເງິນ</span>
                    <div
                      v-if="activeItem === '/reports/financial'"
                      class="active-indicator"
                    ></div>
                  </div>
                </NuxtLink>
              </div>
            </Transition>

            <!-- Rail Mode Reports Submenu -->
            <div v-if="rail" class="rail-submenu" v-show="false">
              <div class="rail-submenu-content">
                <h4 class="rail-submenu-title">ລາຍງານ</h4>
                <NuxtLink
                  to="/reports/sales"
                  class="rail-submenu-item"
                  @click="setActiveItem('/reports/sales')"
                >
                  <v-icon size="16">mdi-chart-line</v-icon>
                  <span>ລາຍງານການຂາຍ</span>
                </NuxtLink>
                <NuxtLink
                  to="/reports/statistics"
                  class="rail-submenu-item"
                  @click="setActiveItem('/reports/statistics')"
                >
                  <v-icon size="16">mdi-poll</v-icon>
                  <span>ສະຖິຕິ</span>
                </NuxtLink>
                <NuxtLink
                  to="/reports/financial"
                  class="rail-submenu-item"
                  @click="setActiveItem('/reports/financial')"
                >
                  <v-icon size="16">mdi-currency-usd</v-icon>
                  <span>ລາຍງານການເງິນ</span>
                </NuxtLink>
              </div>
            </div>
          </div>
        </div>

        <!-- Logout -->
        <div class="nav-link logout-link" @click="showLogoutDialog = true">
          <div class="nav-item logout-item">
            <div class="nav-icon">
              <v-icon size="20">mdi-logout-variant</v-icon>
            </div>
            <Transition name="fade-slide" mode="out-in">
              <span v-if="!rail" class="nav-text">ອອກຈາກລະບົບ</span>
            </Transition>
          </div>
          <v-tooltip v-if="rail" activator="parent" location="end" offset="10">
            <div class="tooltip-content">ອອກຈາກລະບົບ</div>
          </v-tooltip>
        </div>
      </div>
    </v-navigation-drawer>

    <!-- Main Content -->
    <v-main class="main-content">
      <div class="content-wrapper">
        <router-view></router-view>
      </div>
    </v-main>

    <!-- Modern Logout Dialog -->
    <v-dialog
      v-model="showLogoutDialog"
      max-width="420"
      persistent
      transition="dialog-transition"
    >
      <v-card class="modern-dialog">
        <div class="dialog-header">
          <div class="dialog-icon">
            <v-icon color="error" size="32">mdi-logout-variant</v-icon>
          </div>
          <h3 class="dialog-title">ອອກຈາກລະບົບ</h3>
          <p class="dialog-subtitle">ທ່ານແນ່ໃຈບໍ່ວ່າຕ້ອງການອອກຈາກລະບົບ?</p>
        </div>

        <div class="dialog-actions">
          <v-btn
            variant="outlined"
            color="grey"
            @click="showLogoutDialog = false"
            class="cancel-btn"
          >
            ຍົກເລີກ
          </v-btn>
          <v-btn
            variant="flat"
            color="error"
            @click="confirmLogout"
            class="confirm-btn"
          >
            ອອກຈາກລະບົບ
          </v-btn>
        </div>
      </v-card>
    </v-dialog>
  </v-app>
</template>

<script setup lang="ts">
import { ref, onMounted, watch } from "vue";

const router = useRouter();
const route = useRoute();
const drawer = ref(true);
const rail = ref(false);
const showLogoutDialog = ref(false);
const activeItem = ref("/");
const managementExpanded = ref(false);
const serviceExpanded = ref(false);
const reportExpanded = ref(false);

// Initialize active item based on current route
onMounted(() => {
  activeItem.value = route.path;

  // Restore rail state
  const savedRailState = localStorage.getItem("sidebar-rail");
  if (savedRailState) {
    rail.value = JSON.parse(savedRailState);
  }
});

// Watch route changes
watch(
  () => route.path,
  (newPath) => {
    activeItem.value = newPath;
  }
);

// Watch rail state and save to localStorage
watch(rail, (newValue) => {
  localStorage.setItem("sidebar-rail", JSON.stringify(newValue));
});

function toggleRail() {
  rail.value = !rail.value;
}

function setActiveItem(path: string) {
  activeItem.value = path;
}

function toggleManagement() {
  if (!rail.value) {
    managementExpanded.value = !managementExpanded.value;
  }
}

function toggleService() {
  if (!rail.value) {
    serviceExpanded.value = !serviceExpanded.value;
  }
}

function toggleReport() {
  if (!rail.value) {
    reportExpanded.value = !reportExpanded.value;
  }
}

function confirmLogout() {
  console.log("Logging out...");
  localStorage.removeItem("sidebar-rail");
  router.push("/login");
  showLogoutDialog.value = false;
}
</script>

<style scoped>
.modern-sidebar {
  background: linear-gradient(
    145deg,
    #0f1419 0%,
    #1a1f29 50%,
    #0f1419 100%
  ) !important;
  border-right: 1px solid rgba(255, 255, 255, 0.08) !important;
  box-shadow: 4px 0 20px rgba(0, 0, 0, 0.15),
    0 0 0 1px rgba(255, 255, 255, 0.05) inset !important;
  backdrop-filter: blur(20px);
}

/* Header Section */
.sidebar-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 24px 20px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.08);
  background: rgba(255, 255, 255, 0.02);
}

.brand-section {
  display: flex;
  align-items: center;
  gap: 16px;
  flex: 1;
}

.logo-container {
  position: relative;
}

.logo-icon {
  width: 48px;
  height: 48px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 8px 24px rgba(102, 126, 234, 0.3);
  border: 2px solid rgba(255, 255, 255, 0.1);
}

.brand-text {
  color: white;
}

.brand-title {
  font-size: 22px;
  font-weight: 700;
  margin: 0;
  background: linear-gradient(135deg, #ffffff 0%, #a0a9c0 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  line-height: 1.2;
}

.brand-subtitle {
  font-size: 12px;
  color: rgba(255, 255, 255, 0.6);
  margin: 2px 0 0 0;
  font-weight: 500;
}

.rail-toggle {
  background: rgba(255, 255, 255, 0.08) !important;
  border: 1px solid rgba(255, 255, 255, 0.1);
  transition: all 0.3s ease;
  backdrop-filter: blur(10px);
}

.rail-toggle:hover {
  background: rgba(255, 255, 255, 0.15) !important;
  transform: scale(1.05);
}

.rail-toggle.rail-active {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
}

/* Navigation Container */
.nav-container {
  flex: 1;
  padding: 20px 0;
  overflow-y: auto;
}

.nav-section {
  margin-bottom: 8px;
  padding: 0 12px;
}

.section-header {
  margin-bottom: 12px;
}

.section-title {
  font-size: 11px;
  font-weight: 700;
  color: rgba(255, 255, 255, 0.5);
  text-transform: uppercase;
  letter-spacing: 1px;
}

/* Navigation Group */
.nav-group {
  margin-bottom: 4px;
}

.nav-group-header {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px 16px;
  border-radius: 12px;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  cursor: pointer;
  position: relative;
  overflow: hidden;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.nav-group-header::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(
    135deg,
    rgba(255, 255, 255, 0.1) 0%,
    rgba(255, 255, 255, 0.05) 100%
  );
  opacity: 0;
  transition: opacity 0.3s ease;
  border-radius: 12px;
}

.nav-group-header:hover::before {
  opacity: 1;
}

.nav-group-header.expanded {
  background: linear-gradient(
    135deg,
    rgba(102, 126, 234, 0.15) 0%,
    rgba(118, 75, 162, 0.1) 100%
  );
  border: 1px solid rgba(102, 126, 234, 0.2);
}

.nav-group-header.rail-mode {
  justify-content: center;
  padding: 12px;
}

.nav-arrow {
  margin-left: auto;
  transition: transform 0.3s ease;
}

.nav-arrow .rotated {
  transform: rotate(180deg);
}

/* Submenu Styles */
.nav-submenu {
  margin-top: 4px;
  padding-left: 12px;
  border-left: 2px solid rgba(102, 126, 234, 0.3);
  margin-left: 16px;
}

.submenu-link {
  text-decoration: none;
  display: block;
  margin-bottom: 2px;
}

.submenu-item {
  padding: 10px 12px !important;
  margin-left: 8px;
  background: rgba(255, 255, 255, 0.02) !important;
  border-radius: 8px !important;
  font-size: 13px;
  border: 1px solid transparent;
}

.submenu-item:hover {
  background: rgba(255, 255, 255, 0.08) !important;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.submenu-item.active {
  background: linear-gradient(
    135deg,
    rgba(102, 126, 234, 0.25) 0%,
    rgba(118, 75, 162, 0.15) 100%
  ) !important;
  border: 1px solid rgba(102, 126, 234, 0.4);
}

.submenu-item .nav-icon {
  min-width: 18px;
}

/* Rail Mode Submenu */
.rail-submenu {
  position: absolute;
  left: 100%;
  top: 0;
  background: rgba(0, 0, 0, 0.95);
  border-radius: 12px;
  padding: 16px;
  min-width: 200px;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
  border: 1px solid rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(20px);
  z-index: 1000;
  opacity: 0;
  visibility: hidden;
  transition: all 0.3s ease;
  transform: translateX(-10px);
}

.nav-group:hover .rail-submenu {
  opacity: 1;
  visibility: visible;
  transform: translateX(0);
}

.rail-submenu-title {
  color: white;
  font-size: 14px;
  font-weight: 600;
  margin: 0 0 12px 0;
  padding-bottom: 8px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.rail-submenu-item {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px 12px;
  border-radius: 8px;
  color: rgba(255, 255, 255, 0.8);
  text-decoration: none;
  font-size: 13px;
  transition: all 0.2s ease;
  margin-bottom: 2px;
}

.rail-submenu-item:hover {
  background: rgba(102, 126, 234, 0.2);
  color: white;
}

.notification-badge.small {
  font-size: 9px;
  padding: 1px 4px;
  min-width: 14px;
  height: 14px;
}

/* Submenu Transitions */
.submenu-enter-active,
.submenu-leave-active {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  transform-origin: top;
}

.submenu-enter-from,
.submenu-leave-to {
  opacity: 0;
  transform: scaleY(0.8) translateY(-10px);
}

.submenu-enter-to,
.submenu-leave-from {
  opacity: 1;
  transform: scaleY(1) translateY(0);
}

/* Navigation Items */
.nav-link {
  text-decoration: none;
  display: block;
  margin-bottom: 4px;
}

.nav-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px 16px;
  border-radius: 12px;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.nav-item::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(
    135deg,
    rgba(255, 255, 255, 0.1) 0%,
    rgba(255, 255, 255, 0.05) 100%
  );
  opacity: 0;
  transition: opacity 0.3s ease;
  border-radius: 12px;
}

.nav-item:hover::before {
  opacity: 1;
}

.nav-icon {
  color: rgba(255, 255, 255, 0.7);
  transition: color 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  min-width: 20px;
}

.nav-text {
  color: rgba(255, 255, 255, 0.85);
  font-size: 14px;
  font-weight: 500;
  flex: 1;
  transition: color 0.3s ease;
}

.nav-item:hover .nav-icon,
.nav-item:hover .nav-text {
  color: white;
}

/* Active State */
.nav-item.active {
  background: linear-gradient(
    135deg,
    rgba(102, 126, 234, 0.2) 0%,
    rgba(118, 75, 162, 0.1) 100%
  );
  border: 1px solid rgba(102, 126, 234, 0.3);
}

.nav-item.active .nav-icon,
.nav-item.active .nav-text {
  color: #7c3aed;
}

.active-indicator {
  position: absolute;
  right: 8px;
  top: 50%;
  transform: translateY(-50%);
  width: 4px;
  height: 24px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 2px;
  animation: slideIn 0.3s ease;
}

/* Notification Badges */
.notification-badge {
  background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
  color: white;
  font-size: 10px;
  font-weight: 700;
  padding: 2px 6px;
  border-radius: 10px;
  min-width: 18px;
  height: 18px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-left: auto;
  box-shadow: 0 2px 8px rgba(255, 107, 107, 0.4);
}

.notification-badge.urgent {
  animation: pulse 2s infinite;
}

/* Logout Item */
.logout-item {
  color: #ff6b6b !important;
}

.logout-item .nav-icon,
.logout-item .nav-text {
  color: #ff6b6b !important;
}

.logout-item:hover {
  background: rgba(255, 107, 107, 0.1) !important;
}

/* Main Content */
.main-content {
  background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
  min-height: 100vh;
}

.content-wrapper {
  padding: 24px;
  max-width: 100%;
}

/* Modern Dialog */
.modern-dialog {
  border-radius: 24px !important;
  overflow: hidden;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3) !important;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.dialog-header {
  padding: 32px 32px 24px;
  text-align: center;
  background: linear-gradient(135deg, #1a1f29 0%, #0f1419 100%);
  color: white;
}

.dialog-icon {
  margin-bottom: 16px;
}

.dialog-title {
  font-size: 20px;
  font-weight: 700;
  margin: 0 0 8px 0;
}

.dialog-subtitle {
  font-size: 14px;
  color: rgba(255, 255, 255, 0.7);
  margin: 0;
}

.dialog-actions {
  padding: 24px 32px 32px;
  display: flex;
  gap: 12px;
  justify-content: center;
}

.cancel-btn,
.confirm-btn {
  padding: 12px 32px !important;
  font-weight: 600 !important;
  border-radius: 12px !important;
  min-width: 120px;
}

/* Tooltips */
:deep(.v-tooltip > .v-overlay__content) {
  background: rgba(0, 0, 0, 0.9) !important;
  border-radius: 8px !important;
  padding: 8px 12px !important;
  font-size: 12px !important;
  font-weight: 500;
  border: 1px solid rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(20px);
}

.tooltip-content {
  color: white;
  font-weight: 500;
}

/* Transitions */
.fade-slide-enter-active,
.fade-slide-leave-active {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.fade-slide-enter-from {
  opacity: 0;
  transform: translateX(-10px);
}

.fade-slide-leave-to {
  opacity: 0;
  transform: translateX(10px);
}

/* Animations */
@keyframes slideIn {
  from {
    opacity: 0;
    transform: translateY(-50%) scale(0);
  }
  to {
    opacity: 1;
    transform: translateY(-50%) scale(1);
  }
}

@keyframes pulse {
  0%,
  100% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.1);
  }
}

/* Rail Mode Adjustments */
.modern-sidebar.v-navigation-drawer--rail .nav-item {
  justify-content: center;
  padding: 12px;
}

.modern-sidebar.v-navigation-drawer--rail .notification-badge {
  position: absolute;
  top: 8px;
  right: 8px;
  margin-left: 0;
}

/* Responsive Design */
@media (max-width: 768px) {
  .modern-sidebar {
    position: fixed !important;
    z-index: 1000;
  }
}

/* Scrollbar Styling */
.nav-container::-webkit-scrollbar {
  width: 4px;
}

.nav-container::-webkit-scrollbar-track {
  background: transparent;
}

.nav-container::-webkit-scrollbar-thumb {
  background: rgba(255, 255, 255, 0.2);
  border-radius: 2px;
}

.nav-container::-webkit-scrollbar-thumb:hover {
  background: rgba(255, 255, 255, 0.3);
}
</style>