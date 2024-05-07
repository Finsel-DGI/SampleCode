"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const api_1 = __importDefault(require("./api"));
const start_1 = __importDefault(require("./api/start"));
const flow_1 = __importDefault(require("./api/flow"));
function routes(app) {
    app.use("/api/start", start_1.default);
    app.use("/api/flow", flow_1.default);
    app.use("/", api_1.default);
}
exports.default = routes;
