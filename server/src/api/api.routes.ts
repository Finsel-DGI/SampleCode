import express from "express";
/* eslint new-cap: ["error", { "capIsNew": false }]*/
const router = express.Router(({mergeParams: true}));

// handlers
import handler from "./api.handler";
// headers
import header from "../middleware/request.validator";

router.get("/",
    [
      header.validateRequester(),
    ],
    handler.hello,
);

export default router;
