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
Object.defineProperty(exports, "__esModule", { value: true });
exports.handleRequest = void 0;
const labs_sharable_1 = require("labs-sharable");
const pasby_1 = require("@finsel-dgi/pasby");
const handleRequest = (request, response, callback) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    try {
        yield callback(request, response);
    }
    catch (error) {
        if (error instanceof labs_sharable_1.CustomError &&
            error.getHttpResponse()) {
            const err = error;
            return response.status(err.getCode()).send(err.getHttpResponse());
        }
        if (error instanceof pasby_1.PasbyError) {
            const e = error;
            return response.status((_a = e.status) !== null && _a !== void 0 ? _a : 500).send(e.responseBody);
        }
        const message = error instanceof labs_sharable_1.CustomError ?
            error.getMessage() : `${error}`;
        const code = error instanceof labs_sharable_1.CustomError ?
            error.getCode() : 500;
        if (code === 400 && message.length < 1)
            return;
        return response.status(code).send({
            "status": labs_sharable_1.RequestStatus.failed,
            "reason": message,
        });
    }
    return;
});
exports.handleRequest = handleRequest;
