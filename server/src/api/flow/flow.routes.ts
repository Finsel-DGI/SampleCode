import express from "express";
/* eslint new-cap: ["error", { "capIsNew": false }]*/
const router = express.Router(({mergeParams: true}));

// handlers
import handler from "./flow.handler";
// schema
import schema from "../api.schema";
// headers
import header from "../../middleware/request.validator";
import validate from "../../utils/zod.validation";

router.post("/cancel",
    [
      header.validateRequester(),
      validate(schema.flow),
    ],
    handler.cancel,
);

// checks status of authentication flow
router.post("/ping",
    [
      header.validateRequester(),
      validate(schema.flow),
    ],
    handler.authentication,
);

// checks status of confirmation signature mode flow
router.post("/ping-confirmation",
    [
      header.validateRequester(),
      validate(schema.flow),
    ],
    handler.confirmation,
);

export default router;
