import express, {Application} from "express";
import config from "./config/default";
import cors from "cors";
import dotenv from "dotenv";
import routes from "./routes";
/* eslint-disable @typescript-eslint/no-var-requires*/
const pino = require("pino-http")();
/* eslint-disable @typescript-eslint/no-var-requires*/

// Load environment variables from .env file
dotenv.config();

const port = process.env.PORT || config.port;
const app: Application = express();

app.use(cors());
app.use(pino);
app.use(express.json());
app.use(express.urlencoded({extended: false}));


app.listen(port, () => {
  console.log(`App is running at http://localhost:${port}`);
  routes(app);
});
