"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const router = express_1.default.Router(({ mergeParams: true }));
const start_handler_1 = __importDefault(require("./start.handler"));
const api_schema_1 = __importDefault(require("../api.schema"));
const request_validator_1 = __importDefault(require("../../middleware/request.validator"));
const zod_validation_1 = __importDefault(require("../../utils/zod.validation"));
router.post("/securely", [
    request_validator_1.default.validateRequester(),
    (0, zod_validation_1.default)(api_schema_1.default.action),
], start_handler_1.default.secure);
router.post("/auto", [
    request_validator_1.default.validateRequester(),
    (0, zod_validation_1.default)(api_schema_1.default.action),
], start_handler_1.default.auto);
router.post("/signature", [
    request_validator_1.default.validateRequester(),
    (0, zod_validation_1.default)(api_schema_1.default.action),
], start_handler_1.default.signature);
router.post("/authenticate", [
    request_validator_1.default.validateRequester(),
    (0, zod_validation_1.default)(api_schema_1.default.ninFlow),
], start_handler_1.default.authenticateNIN);
exports.default = router;
