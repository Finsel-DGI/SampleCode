import express from "express";
/* eslint new-cap: ["error", { "capIsNew": false }]*/
const router = express.Router(({mergeParams: true}));

// handlers
import handler from "./start.handler";
// schema
import schema from "../api.schema";
// headers
import header from "../../middleware/request.validator";
import validate from "../../utils/zod.validation";

// wildcard
router.post("/securely",
    [
      header.validateRequester(),
      validate(schema.action),
    ],
    handler.secure,
);

// wildcard
router.post("/auto",
    [
      header.validateRequester(),
      validate(schema.action),
    ],
    handler.auto,
);

// wildcard
router.post("/signature",
    [
      header.validateRequester(),
      validate(schema.action),
    ],
    handler.signature,
);

// Use only when you have the users nin
router.post("/authenticate",
    [
      header.validateRequester(),
      validate(schema.ninFlow),
    ],
    handler.authenticateNIN,
);

// add other scopes of your choosing ....

export default router;
