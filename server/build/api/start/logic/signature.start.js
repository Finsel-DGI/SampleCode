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
const handler_1 = require("../../../helpers/handler");
const pasby_1 = require("../../../services/pasby");
const signatureStart = (request, response) => (0, handler_1.handleRequest)(request, response, () => __awaiter(void 0, void 0, void 0, function* () {
    const req = request.body;
    const pasby = new pasby_1.PasbyService();
    const res = yield pasby.wildcardSigning(req.payload, req.webhook);
    response.status(200).send({
        data: res,
    });
    return response.end();
}));
exports.default = signatureStart;
