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
function hello(request, response) {
    return __awaiter(this, void 0, void 0, function* () {
        response.set('Content-Type', 'text/html');
        response.send(Buffer.from('<html> <body><p>Hello there, welcome to pasby demo sample code server -- <a href=https://www.pasby.africa>Learn about pasby</href> </p></body> </html>'));
        return response.end();
    });
}
exports.default = { hello };
