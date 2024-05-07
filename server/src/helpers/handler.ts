import {CustomError, RequestStatus} from "labs-sharable";
import {Request, Response} from "express";
import {EndpointCallback} from "../utils/exec.types";
import { PasbyError } from "@finsel-dgi/pasby";

export const handleRequest = async (request: Request,
    response: Response, callback: EndpointCallback) => {
  try {
    await callback(request, response);
  } catch (error) {
    if (error instanceof CustomError &&
      (error as CustomError).getHttpResponse()) {
      const err = (error as CustomError);
      return response.status(err.getCode()).send(err.getHttpResponse());
    }

    if (error instanceof PasbyError) {
      const e = (error as PasbyError);
      return response.status(e.status ?? 500).send(e.responseBody);
    }

    const message = error instanceof CustomError ?
      (error as CustomError).getMessage() : `${error}`;
    const code = error instanceof CustomError ?
      (error as CustomError).getCode() : 500;
    if (code === 400 && message.length < 1) return;
    return response.status(code).send({
      "status": RequestStatus.failed,
      "reason": message,
    });
  }
  return;
};
