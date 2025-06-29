import { PrismaClient } from "@prisma/client";

const prismaClientSingleton = () => {
  return new PrismaClient();
};

// เพิ่ม global typing ให้ถูกต้อง
const globalForPrisma = globalThis as typeof globalThis & {
  prismaGlobal?: PrismaClient;
};

// ใช้ instance เดียวตลอด
const prisma = globalForPrisma.prismaGlobal ?? prismaClientSingleton();

if (process.env.NODE_ENV !== "production") {
  globalForPrisma.prismaGlobal = prisma;
}

export default prisma;
