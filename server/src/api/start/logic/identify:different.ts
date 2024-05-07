import { Request, Response } from "express";
import { handleRequest } from "../../../helpers/handler";
import { PasbyService } from "../../../services/pasby";

const differentDeviceAuth = (request: Request,
  response: Response) => handleRequest(request, response,
    async () => {
      const req: { payload: string, nin: string } = request.body;

      const pasby = new PasbyService();

      const res = await pasby.differentDevice(req.payload, req.nin);

      response.status(200).send({
        data: res,
      });
      return response.end();
    });

export default differentDeviceAuth;
