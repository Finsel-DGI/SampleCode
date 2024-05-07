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
const cancel_flow_1 = __importDefault(require("./logic/cancel.flow"));
const check_authentication_1 = __importDefault(require("./logic/check.authentication"));
const check_confirmation_1 = __importDefault(require("./logic/check.confirmation"));
function cancel(request, response) {
    return __awaiter(this, void 0, void 0, function* () {
        return (0, cancel_flow_1.default)(request, response);
    });
}
function authentication(request, response) {
    return __awaiter(this, void 0, void 0, function* () {
        return (0, check_authentication_1.default)(request, response);
    });
}
function confirmation(request, response) {
    return __awaiter(this, void 0, void 0, function* () {
        return (0, check_confirmation_1.default)(request, response);
    });
}
exports.default = { confirmation, authentication, cancel };
