import {
  PrismaClientKnownRequestError,
  PrismaClientUnknownRequestError,
  PrismaClientValidationError,
} from "@prisma/client/runtime/library";
const env = useRuntimeConfig().ENV;
export default function handleError({
  error,
  message,
}: {
  error: unknown;
  message?: string | null;
}) {
  // const ins_err = new Error();
  let msg = null,
    stack = null;

  if (error instanceof Error) {
    stack = error.stack;
    msg = message ?? error.message;
  } else if (
    error instanceof PrismaClientValidationError ||
    error instanceof PrismaClientKnownRequestError ||
    error instanceof PrismaClientUnknownRequestError
  ) {
    stack = error.stack;
    msg = message ?? error.message;
  } else {
    stack = error as string;
    msg = message ?? "Unknown error";
  }

  message = msg;
  return {
    statusCode: 500,
    message: msg,
    stack: env == "development" ? stack : undefined,
  };
}
