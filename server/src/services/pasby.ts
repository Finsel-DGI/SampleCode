import {Pasby, SigningRequestWebhook, parseInterface} from "@finsel-dgi/pasby";
import account = require("../config/service.json"); // change the attributes of service.json for your use-case
import {CustomError, LabsCipher} from "labs-sharable";

/**
 * This service class will store all business logic for using the pasby integration
 */
export class PasbyService {
  private pasby: Pasby;

  /**
   * initialize pasby services
   */
  constructor() {
    this.pasby = new Pasby({
      apikeyAuth: account.apikeys.live,
      appSecretKey: account.secret,
      basePath: "https://l.pasby.africa",
    });
  }

  /**
   * Create a wildcard authentication flow. This requires the client to present a QR code with the generated flow id seeds
   * @summary identification:wildcard
   * @param {string} payload pass a payload disclosing the intent of the flow request
   * @param {'signup' | 'login' | 'link'} action flow action type
   * @return {Promise<{seeds: Array<string>, identifier: string}>}
   */
  public async secureStart(payload: string, action: "signup" | "login" | "link" = "signup"): Promise<{
    /**
     * Present a QR code with these generated flow id seeds
     */
    seeds: Array<string>,
    /**
     * Flow action id. Use this to control & listen to the flow after creation
     */
    identifier: string
  }> {
    return await this.pasby.identification.wildcard({
      action: action,
      claims: ["naming.family", "naming.given", "contact.email"],
      payload: payload,
      seeds: 5,
    }).then((value) => {
      if (!value.data.data) throw new CustomError("Failed to communicate properly with pasby");
      return {
        seeds: value.data.data.seeds,
        identifier: value.data.data.request.id,
      };
    });
  }

  /**
  * Create an authentication flow that automatically opens pasby on the users device.
  * @summary identification:same
  * @param {string} payload pass a payload disclosing the intent of the flow request
  * @param {'signup' | 'login' | 'link'} action flow action type
  * @return {Promise<{uri: string, identifier: string}>}
  */
  public async autoStart(payload: string, action: "signup" | "login" | "link" = "signup"): Promise<{
    /**
     * You use this link to open up the pasby™ mobile app automatically
     */
    uri: string,
    /**
     * Flow action id. Use this to control & listen to the flow after creation
     */
    identifier: string
  }> {
    return await this.pasby.identification.sameDevice({
      action: action,
      claims: ["naming.family", "naming.given", "contact.email"],
      payload: payload,
    }).then((value) => {
      if (!value.data.data) throw new CustomError("Failed to communicate properly with pasby");
      return {
        uri: value.data.data.link,
        identifier: value.data.data.request.id,
      };
    });
  }


  /**
   * Create a signature flow with a "confirm" action.
   * @summary signing:wildcard
   * @param {string} payload pass a payload disclosing the intent of the flow request
   * @param {SigningRequestWebhook} webhook attach a webhook reference and host
   * @return {Promise<{seeds: Array<string>, identifier: string}>}
   */
  public async wildcardSigning(payload: string, webhook?: SigningRequestWebhook): Promise<{
    /**
     * Present a QR code with these generated flow id seeds
     */
    seeds: Array<string>,
    /**
     * Flow action id. Use this to control & listen to the flow after creation
     */
    identifier: string
  }> {
    return await this.pasby.signing.wildcard({
      action: webhook ? 'sign': 'confirm',
      payload: payload,
      webhook: webhook,
      seeds: 5,
    }).then((value) => {
      if (!value.data.data) throw new CustomError("Failed to communicate properly with pasby");
      return {
        seeds: value.data.data.seeds,
        identifier: value.data.data.request.id,
      };
    });
  }


  /**
   * Create an signature flow that automatically opens pasby on the users device.
   * @summary signing:same
   * @param {string} payload pass a payload disclosing the intent of the flow request
   * @param {string} nin National ID of the user
   * @param {SigningRequestWebhook} webhook attach a webhook reference and host
   * @return {Promise<{identifier: string}>}
   */
  public async autoSign(payload: string, nin: string, webhook?: SigningRequestWebhook): Promise<{
    /**
     * You use this link to open up the pasby™ mobile app automatically
     */
    uri: string,
    /**
     * Flow action id. Use this to control & listen to the flow after creation
     */
    identifier: string
  }> {
    return await this.pasby.signing.sameDevice({
      action: webhook ? "sign" : "confirm",
      nin: nin,
      webhook: webhook,
      payload: payload,
    }).then((value) => {
      if (!value.data.data) throw new CustomError("Failed to communicate properly with pasby");
      return {
        uri: value.data.data.link,
        identifier: value.data.data.request.id,
      };
    });
  }


  /**
   * Check the status of your created flow identification mode.
   * @summary flow:ping
   * @param {string} identifier pass the request identifier you got from pasby when a flow action was created.
   * @return {Promise<Record<string, unknown>>}
   */
  public async generalizedPing(identifier: string): Promise<{
    /**
     * Shared ID information the user has granted to you
     */
    claims?: Record<string, Record<string, unknown>>,
    /**
     * users digital signature verifiable through pasby. To ensure the signature is valid and originated from a recognized source
     */
    signature?: string,
    /**
     * Date signed
     */
    signedAt?: number,
    /**
     * Date created
     */
    iat: number,
    /**
     * Type of pasby flow
     */
    mode: string,
    /**
     * Listen to cancellation events
     */
    cancelled: boolean,
    /**
     * Listen to session events
     */
    sessionPicked?: boolean,
    /**
     * Identification number of the user carrying processing flow action.
     */
    user: string,
    /**
    * Name of the requestee
    */
    username?: string,
  }> {
    return await this.pasby.flows.ping({
      request: identifier,
    }).then((value) => {
      if (!value.data.data) throw new CustomError("Flow must have expired");
      return {
        cancelled: value.data.data.request.cancelled,
        sessionPicked: value.data.data.request.onsession,
        user: value.data.data.request.requestee,
        iat: value.data.data.request.iat,
        mode: value.data.data.request.mode,
        username: value.data.data.username,
        signedAt: value.data.data.request.signedAt,
        signature: value.data.data.request.signature,
        claims: value.data.data.request.mode === 'signature' ? undefined: this.decryption({
          claims: value.data.data.request.claims as Record<string, Record<string, string>> | undefined,
        }),
      };
    });
  }


  /**
   * Check the status of your created flow signature mode.
   * @summary flow:ping
   * @param {string} identifier pass the request identifier you got from pasby when a flow action was created.±
   * @return {Promise<Record<string, unknown>>}
   */
  public async pingSignatureFlow(identifier: string): Promise<{
    /**
     * users digital signature verifiable through pasby. To ensure the signature is valid and originated from a recognized source
     */
    signature?: string,
    /**
     * Date signed
     */
    signedAt?: number,
    /**
     * Date created
     */
    iat: number,
    /**
     * Listen to cancellation events
     */
    cancelled: boolean,
    /**
     * Listen to session events
     */
    sessionPicked?: boolean,
    /**
     * Identification number of the user carrying processing flow action.
     */
    user: string,
    /**
     * Type of pasby flow
     */
    mode: string,
    /**
     * Name of the requestee
     */
    username?: string,
  }> {
    return await this.pasby.flows.ping({
      request: identifier,
    }).then((value) => {
      if (!value.data.data) throw new CustomError("Failed to communicate properly with pasby");
      return {
        cancelled: value.data.data.request.cancelled,
        sessionPicked: value.data.data.request.onsession,
        user: value.data.data.request.requestee,
        iat: value.data.data.request.iat,
        mode: value.data.data.request.mode,
        signedAt: value.data.data.request.signedAt,
        username: value.data.data.username,
        signature: value.data.data.request.signature,
      };
    });
  }


  /**
   * Create a directed authentication flow on a different device.
   * @summary identification:different
   * @param {string} payload pass a payload disclosing the intent of the flow request
   * @param {string} nin National ID of the user
   * @return {Promise<{identifier: string}>}
   */
  public async differentDevice(payload: string, nin: string): Promise<{
    /**
     * Flow action id. Use this to control & listen to the flow after creation
     */
    identifier: string
  }> {
    return await this.pasby.identification.differentDevice({
      action: 'login',
      user: nin,
      claims: ["contact.email"],
      payload: payload,
    }).then((value) => {
      if (!value.data.data) throw new CustomError("Failed to communicate properly with pasby");
      return {
        identifier: value.data.data.request.id,
      };
    });
  }

  /**
   * Cancel any flow action request.
   * @summary flow:cancel
   * @param {string} identifier pass the request identifier you got from pasby when a flow action was created.
   * @return {Promise<void>}
   */
  public async cancelflow(identifier: string): Promise<Record<string, unknown>> {
    return await this.pasby.flows.cancel({
      request: identifier,
    }).then((value) => {
      return parseInterface(value.data);
    });
  }

  /**
   * Decrypt the claims received from your flow ping method. The decryption requires the calling apps private key certificate. This private-key can be found in the apps service-file
   * Remember to pass the original to this function and not the munched string pasby gave you in the .json file.
   * @param {Record<string, unknown>} params argument
   * @return {Record<string, unknown> | undefined}
   */
  private decryption(params: {
    /**
     * Shared ID data received from pasby servers
     */
    claims?: Record<string, Record<string, string>>;
  }): Record<string, Record<string, unknown>> | undefined{
    if (!params.claims) return;
    if (Object.keys(params.claims).length === 0) {
      return;
    }
    const record = JSON.parse(JSON.stringify(params.claims));
    for (const key in record) {
      if (Object.prototype.hasOwnProperty.call(record, key)) {
        for (const sub in record[key]) {
          if (Object.prototype.hasOwnProperty.call(record[key], sub)) {
            const val = LabsCipher.
              jsRsaDecrypt(JSON.stringify(record[key][sub]), account.privatekey);
            record[key][sub] = JSON.parse(val);
          }
        }
      }
    }
    return record;
  }
}
