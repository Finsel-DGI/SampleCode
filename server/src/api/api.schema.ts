import {object, string} from "zod";

const apiSchema = object({
  body: object({
    payload: string({
      required_error: "Intent sentence is required",
    }),
  }),
});

const ninSchema = object({
  body: object({
    payload: string({
      required_error: "Intent sentence is required",
    }),
    nin: string({
      required_error: "National identification number required",
    }).min(11, "Invalid nin identifier"),
  }),
});

const flowSchema = object({
  body: object({
    request: string({
      required_error: "Flow identifier missing and is required",
    }),
  }),
});

export default {action: apiSchema, flow: flowSchema, ninFlow: ninSchema};
