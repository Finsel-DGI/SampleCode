import {Request, Response} from "express";
import {handleRequest} from "../../../helpers/handler";
import {PasbyService} from "../../../services/pasby";

const secureStart = (request: Request,
    response: Response) => handleRequest(request, response,
    async () => {
      const req: { payload: string } = request.body;

      const pasby = new PasbyService();

      const res = await pasby.secureStart(req.payload);

      response.status(200).send({
        data: res,
      });
      return response.end();
    });

export default secureStart;
