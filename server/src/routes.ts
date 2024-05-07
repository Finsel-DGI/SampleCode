import {Application} from "express";

// routes
import api from "./api";
import start from "./api/start";
import flow from "./api/flow";
/**
 * route-based versioning
 * @param {Application} app express app
 */
function routes(app: Application) {
  app.use("/api/start", start);
  app.use("/api/flow", flow);
  app.use("/", api);
}

export default routes;
