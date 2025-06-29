import handleError from "~/server/handle";
import prisma from "@/lib/prisma";
export default defineEventHandler(async (event) => {
  try {
    const categories = await prisma.productTypes.findMany();
    return {
      status: 200,
      data: categories,
    };
  } catch (error) {
    throw handleError({
      error,
      message: "Internal Server Error",
    });
  }
});
