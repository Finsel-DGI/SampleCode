import {Request, Response} from "express";
import secureStart from "./logic/secure.start";
import autoStart from "./logic/auto.start";
import signatureStart from "./logic/signature.start";
import differentDeviceAuth from "./logic/identify:different";

/* eslint-disable*/


async function secure(request: Request, response: Response) {
  return secureStart(request, response);
}

async function auto(request: Request, response: Response) {
  return autoStart(request, response);
}

async function signature(request: Request, response: Response) {
  return signatureStart(request, response);
}

async function authenticateNIN(request: Request, response: Response) {
  return differentDeviceAuth(request, response);
}

export default { signature, auto, secure, authenticateNIN };
