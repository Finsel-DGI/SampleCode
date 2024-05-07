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
exports.PasbyService = void 0;
const pasby_1 = require("@finsel-dgi/pasby");
const account = require("../config/service.dev.json");
const labs_sharable_1 = require("labs-sharable");
class PasbyService {
    constructor() {
        this.pasby = new pasby_1.Pasby({
            apikeyAuth: account.apikeys.live,
            appSecretKey: account.secret,
            basePath: "https://l.pasby.africa",
        });
    }
    secureStart(payload, action = "signup") {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.pasby.identification.wildcard({
                action: action,
                claims: ["naming.family", "naming.given", "contact.email"],
                payload: payload,
                seeds: 5,
            }).then((value) => {
                if (!value.data.data)
                    throw new labs_sharable_1.CustomError("Failed to communicate properly with pasby");
                return {
                    seeds: value.data.data.seeds,
                    identifier: value.data.data.request.id,
                };
            });
        });
    }
    autoStart(payload, action = "signup") {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.pasby.identification.sameDevice({
                action: action,
                claims: ["naming.family", "naming.given", "contact.email"],
                payload: payload,
            }).then((value) => {
                if (!value.data.data)
                    throw new labs_sharable_1.CustomError("Failed to communicate properly with pasby");
                return {
                    uri: value.data.data.link,
                    identifier: value.data.data.request.id,
                };
            });
        });
    }
    wildcardSigning(payload, webhook) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.pasby.signing.wildcard({
                action: webhook ? 'sign' : 'confirm',
                payload: payload,
                webhook: webhook,
                seeds: 5,
            }).then((value) => {
                if (!value.data.data)
                    throw new labs_sharable_1.CustomError("Failed to communicate properly with pasby");
                return {
                    seeds: value.data.data.seeds,
                    identifier: value.data.data.request.id,
                };
            });
        });
    }
    autoSign(payload, nin, webhook) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.pasby.signing.sameDevice({
                action: webhook ? "sign" : "confirm",
                nin: nin,
                webhook: webhook,
                payload: payload,
            }).then((value) => {
                if (!value.data.data)
                    throw new labs_sharable_1.CustomError("Failed to communicate properly with pasby");
                return {
                    uri: value.data.data.link,
                    identifier: value.data.data.request.id,
                };
            });
        });
    }
    generalizedPing(identifier) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.pasby.flows.ping({
                request: identifier,
            }).then((value) => {
                if (!value.data.data)
                    throw new labs_sharable_1.CustomError("Flow must have expired");
                return {
                    cancelled: value.data.data.request.cancelled,
                    sessionPicked: value.data.data.request.onsession,
                    user: value.data.data.request.requestee,
                    iat: value.data.data.request.iat,
                    mode: value.data.data.request.mode,
                    username: value.data.data.username,
                    signedAt: value.data.data.request.signedAt,
                    signature: value.data.data.request.signature,
                    claims: value.data.data.request.mode === 'signature' ? undefined : this.decryption({
                        claims: value.data.data.request.claims,
                    }),
                };
            });
        });
    }
    pingSignatureFlow(identifier) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.pasby.flows.ping({
                request: identifier,
            }).then((value) => {
                if (!value.data.data)
                    throw new labs_sharable_1.CustomError("Failed to communicate properly with pasby");
                return {
                    cancelled: value.data.data.request.cancelled,
                    sessionPicked: value.data.data.request.onsession,
                    user: value.data.data.request.requestee,
                    iat: value.data.data.request.iat,
                    mode: value.data.data.request.mode,
                    signedAt: value.data.data.request.signedAt,
                    username: value.data.data.username,
                    signature: value.data.data.request.signature,
                };
            });
        });
    }
    differentDevice(payload, nin) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.pasby.identification.differentDevice({
                action: 'login',
                user: nin,
                claims: ["contact.email"],
                payload: payload,
            }).then((value) => {
                if (!value.data.data)
                    throw new labs_sharable_1.CustomError("Failed to communicate properly with pasby");
                return {
                    identifier: value.data.data.request.id,
                };
            });
        });
    }
    cancelflow(identifier) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.pasby.flows.cancel({
                request: identifier,
            }).then((value) => {
                return (0, pasby_1.parseInterface)(value.data);
            });
        });
    }
    decryption(params) {
        if (!params.claims)
            return;
        if (Object.keys(params.claims).length === 0) {
            return;
        }
        const record = JSON.parse(JSON.stringify(params.claims));
        for (const key in record) {
            if (Object.prototype.hasOwnProperty.call(record, key)) {
                for (const sub in record[key]) {
                    if (Object.prototype.hasOwnProperty.call(record[key], sub)) {
                        const val = labs_sharable_1.LabsCipher.
                            jsRsaDecrypt(JSON.stringify(record[key][sub]), account.privatekey);
                        record[key][sub] = JSON.parse(val);
                    }
                }
            }
        }
        return record;
    }
}
exports.PasbyService = PasbyService;
