"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const router = express_1.default.Router(({ mergeParams: true }));
const flow_handler_1 = __importDefault(require("./flow.handler"));
const api_schema_1 = __importDefault(require("../api.schema"));
const request_validator_1 = __importDefault(require("../../middleware/request.validator"));
const zod_validation_1 = __importDefault(require("../../utils/zod.validation"));
router.post("/cancel", [
    request_validator_1.default.validateRequester(),
    (0, zod_validation_1.default)(api_schema_1.default.flow),
], flow_handler_1.default.cancel);
router.post("/ping", [
    request_validator_1.default.validateRequester(),
    (0, zod_validation_1.default)(api_schema_1.default.flow),
], flow_handler_1.default.authentication);
router.post("/ping-confirmation", [
    request_validator_1.default.validateRequester(),
    (0, zod_validation_1.default)(api_schema_1.default.flow),
], flow_handler_1.default.confirmation);
exports.default = router;
