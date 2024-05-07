import {Request, Response} from "express";
import {handleRequest} from "../../../helpers/handler";
import {PasbyService} from "../../../services/pasby";
import { SigningRequestWebhook } from "@finsel-dgi/pasby";

const signatureStart = (request: Request,
    response: Response) => handleRequest(request, response,
    async () => {
      const req: { payload: string, webhook?: SigningRequestWebhook } = request.body;

      const pasby = new PasbyService();

      const res = await pasby.wildcardSigning(req.payload, req.webhook);

      response.status(200).send({
        data: res,
      });
      return response.end();
    });

export default signatureStart;
