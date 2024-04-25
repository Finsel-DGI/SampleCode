# pasby demo client

This is the frontend part of this pasby demo. Here we provide an example of how to handle all the things necessary in a frontend of a site with pasby™ integrations.


## Wildcard start

> To protect users and businesses, Wildcard start will be mandatory from 1st of October 2024.
> 
> It eliminates the need for your user to write in their nins before authenticating. 
> 
> Wildcard start means using animated QR code and autostart.


### Animated QR code

Qr code is used when the user visits a service provider on one device and uses pasby app on another device. The user simply scans the QR code with their pasby app and verify the authentication.

In the frontend we handle the animation by randomly shuffling the unique flow codes provided in the seeds payload of pasby API response to your client.

See [identification:wildcard](https://docs.pasby.africa/#ac8f30be-e463-42c0-bbce-cd5afcb83a24)


### Autostart

Otherwise known as same device flows; is when the user visits a service provider on the same device as their pasby is located, most likely on a mobile device where the pasby app is installed. The user simply clicks a button on the your application which opens their pasby application where they can verify the authentication flow.

In the frontend we handle this by checking what type of device the user has and show different buttons depending on the scenario.


### Autostart Mobile

On a mobile device we redirect to `open.pasby.africa` which handles opening of the pasby app correctly on iOS and Android. For the pasby app to redirect back to your app correctly the flow action needs to have began from the users interaction with your app identifier if it's a mobile app, if it is a site we will automatically return to the current page where the flow state began. 