import {
  NextFunction,
  Request, Response,
} from "express";

export const whitelist = [
  "https://demo.pasby.africa",
  "http://localhost:65181",
  "", // uncomment for testing with postman
  // / add your own whitelisted hosts
];

const validateRequester = () => async (
    req: Request,
    res: Response,
    next: NextFunction
) => {
  const origin: string = req.headers.origin ?? "";

  if (whitelist.indexOf(origin) !== -1) {
    next();
  } else {
    res.status(403).send("Not authorized to call this endpoint: Invalid client");
  }
};

export default {validateRequester};
