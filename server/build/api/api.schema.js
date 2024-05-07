"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const zod_1 = require("zod");
const apiSchema = (0, zod_1.object)({
    body: (0, zod_1.object)({
        payload: (0, zod_1.string)({
            required_error: "Intent sentence is required",
        }),
    }),
});
const ninSchema = (0, zod_1.object)({
    body: (0, zod_1.object)({
        payload: (0, zod_1.string)({
            required_error: "Intent sentence is required",
        }),
        nin: (0, zod_1.string)({
            required_error: "National identification number required",
        }).min(11, "Invalid nin identifier"),
    }),
});
const flowSchema = (0, zod_1.object)({
    body: (0, zod_1.object)({
        request: (0, zod_1.string)({
            required_error: "Flow identifier missing and is required",
        }),
    }),
});
exports.default = { action: apiSchema, flow: flowSchema, ninFlow: ninSchema };
