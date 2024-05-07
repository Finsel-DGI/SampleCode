import {Request, Response} from "express";
/* eslint-disable*/

async function hello(request: Request, response: Response) {
  response.set('Content-Type', 'text/html');
  response.send(Buffer.from('<html> <body><p>Hello there, welcome to pasby demo sample code server -- <a href=https://www.pasby.africa>Learn about pasby</href> </p></body> </html>'));
  return response.end()
}

export default { hello };
