"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const router = express_1.default.Router(({ mergeParams: true }));
const api_handler_1 = __importDefault(require("./api.handler"));
const request_validator_1 = __importDefault(require("../middleware/request.validator"));
router.get("/", [
    request_validator_1.default.validateRequester(),
], api_handler_1.default.hello);
exports.default = router;
