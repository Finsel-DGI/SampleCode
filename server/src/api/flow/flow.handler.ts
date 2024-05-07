import {Request, Response} from "express";
import cancelFlow from "./logic/cancel.flow";
import authenticationFlowCheck from "./logic/check.authentication";
import confirmationFlowCheck from "./logic/check.confirmation";

/* eslint-disable*/


async function cancel(request: Request, response: Response) {
  return cancelFlow(request, response);
}

async function authentication(request: Request, response: Response) {
  return authenticationFlowCheck(request, response);
}

async function confirmation(request: Request, response: Response) {
  return confirmationFlowCheck(request, response);
}

export default { confirmation, authentication, cancel };
