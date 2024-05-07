import {Request, Response} from "express";
import {handleRequest} from "../../../helpers/handler";
import {PasbyService} from "../../../services/pasby";

const confirmationFlowCheck = (request: Request,
    response: Response) => handleRequest(request, response,
    async () => {
      const req: { request: string } = request.body;

      const pasby = new PasbyService();

      const res = await pasby.pingSignatureFlow(req.request);

      response.status(200).send({
        data: res,
      });
      return response.end();
    });

export default confirmationFlowCheck;
