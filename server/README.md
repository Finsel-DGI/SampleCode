# pasby demo server

This is the server part of the pasby demo.

## Important class


### [PasbyService](src/services/pasby.ts)
The business logic for using the pasby integrations.


## Configuration file

This server relies on your configuration file [service.json](src/config/service.json)

#### Service profiles

| name        | description                                       |
| ----------- | ------------------------------------------------- |
| type        | configuration file type - should be "app".        |
| appid       | Your application identifier created in [console](https://console.pasby.africa/dashboard/app-settings/details) |
| consumer    | organisation identifier who owns the app in use           |
| secret      | generate your secret from [console](https://console.pasby.africa/dashboard/app-settings)                       |
| privatekey     | pasby provides each app cryptographic keys used in communicating               |
| apikeys | each organisation is provided an api key. Vital for authenticating your client/server with pasby                     |

---

#### pasby node sdk

Find the pasby node library at [npm](https://www.npmjs.com/package/@finsel-dgi/pasby)