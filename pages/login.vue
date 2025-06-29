<template>
  <v-container fluid class="pa-0 fill-height" style="background-color: #FFF8E1;">
    <v-row no-gutters class="fill-height">
      <v-col md="7" class="d-none d-md-flex align-end" style="position: relative;">
        <div style="position: absolute; top: 20px; left: 20px;">
          <v-icon color="orange lighten-4">mdi-butterfly</v-icon>
        </div>
        <div style="position: absolute; top: 120px; left: 250px;">
            <v-icon color="orange lighten-3">mdi-butterfly</v-icon>
        </div>
        <v-img
         src="/cat_login_logo.png"
          contain
          height="200px"
          class="mb-16 ml-10"
        ></v-img>
      </v-col>

      <v-col cols="12" md="5" class="d-flex justify-center align-center">
        <v-card class="elevation-12" width="450" style="border-radius: 20px;">
          <v-card-text class="pa-8">
            <div class="text-center mb-6">
              <v-avatar size="100" class="mb-4">
                <v-img src="/img/logo.png">pet</v-img>
              </v-avatar>
              <h2 class="font-weight-bold" style="color: #5D4037; font-size: 2rem;">ເຂົ້າສູລະບົບ</h2>
              <p class="text-subtitle-1" style="color: #795548;">ຮ້ານແພັດແຄ່</p>
            </div>

            <v-form>
              <v-text-field
                label="ຊື່ຜູ້ໃຊ້"
                prepend-inner-icon="mdi-account-outline"
                variant="solo-filled"
                flat
                rounded
                background-color="grey lighten-4"
                class="mb-4"
              ></v-text-field>

              <v-text-field
                label="ລະຫັດຜ່ານ"
                prepend-inner-icon="mdi-lock-outline"
                type="password"
                variant="solo-filled"
                flat
                rounded
                background-color="grey lighten-4"
                class="mb-4"
              ></v-text-field>

              <v-row>
                <v-col>
                  <v-btn
                    block
                    color="amber lighten-3"
                    class="font-weight-bold"
                    size="large"
                    rounded
                  >
                    ເຂົ້າສູ່ລະບົບ
                  </v-btn>
                </v-col>
                <v-col>
                  <v-btn
                    block
                    color="grey lighten-2"
                    class="font-weight-bold"
                    size="large"
                    rounded
                  >
                    ອອກຈາກລະບົບ
                  </v-btn>
                </v-col>
              </v-row>
            </v-form>

          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<style>
/* Optional: Add a custom font if you want to match the original exactly */
@import url('https://fonts.googleapis.com/css2?family=Kanit:wght@400;700&display=swap');

.v-application {
  font-family: 'Kanit', sans-serif;
}

.v-card {
    background: rgba(255, 255, 255, 0.9) !important;
    backdrop-filter: blur(5px);
}
</style>