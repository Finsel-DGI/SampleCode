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
exports.whitelist = void 0;
exports.whitelist = [
    "https://demo.pasby.africa",
    "http://localhost:65181",
    "",
];
const validateRequester = () => (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    const origin = (_a = req.headers.origin) !== null && _a !== void 0 ? _a : "";
    if (exports.whitelist.indexOf(origin) !== -1) {
        next();
    }
    else {
        res.status(403).send("Not authorized to call this endpoint: Invalid client");
    }
});
exports.default = { validateRequester };
