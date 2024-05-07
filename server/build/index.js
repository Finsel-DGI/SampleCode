"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const default_1 = __importDefault(require("./config/default"));
const cors_1 = __importDefault(require("cors"));
const dotenv_1 = __importDefault(require("dotenv"));
const routes_1 = __importDefault(require("./routes"));
const pino = require("pino-http")();
dotenv_1.default.config();
const port = process.env.PORT || default_1.default.port;
const app = (0, express_1.default)();
app.use((0, cors_1.default)());
app.use(pino);
app.use(express_1.default.json());
app.use(express_1.default.urlencoded({ extended: false }));
app.listen(port, () => {
    console.log(`App is running at http://localhost:${port}`);
    (0, routes_1.default)(app);
});
