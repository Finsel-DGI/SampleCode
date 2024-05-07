import {Request, Response} from "express";
/**
 * Define a type alias for
 * custom endpoint verification and callback
 */
export type EndpointCallback = (request: Request,
    response: Response) => Promise<unknown>;
