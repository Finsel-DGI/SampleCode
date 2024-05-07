"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const secure_start_1 = __importDefault(require("./logic/secure.start"));
const auto_start_1 = __importDefault(require("./logic/auto.start"));
const signature_start_1 = __importDefault(require("./logic/signature.start"));
const identify_different_1 = __importDefault(require("./logic/identify:different"));
function secure(request, response) {
    return __awaiter(this, void 0, void 0, function* () {
        return (0, secure_start_1.default)(request, response);
    });
}
function auto(request, response) {
    return __awaiter(this, void 0, void 0, function* () {
        return (0, auto_start_1.default)(request, response);
    });
}
function signature(request, response) {
    return __awaiter(this, void 0, void 0, function* () {
        return (0, signature_start_1.default)(request, response);
    });
}
function authenticateNIN(request, response) {
    return __awaiter(this, void 0, void 0, function* () {
        return (0, identify_different_1.default)(request, response);
    });
}
exports.default = { signature, auto, secure, authenticateNIN };
