- Open the DNS manager and right click the zone you intend to audit (ie `corp.local`)

![](img/auditing-dns-entries/one.png)

- Navigate to `Properties` > `Security`, then click on `Advanced` towards the bottom of the dialogue

![](img/auditing-dns-entries/two.png)

- Navigate to the `Auditing` tab then click `Add`

![](img/auditing-dns-entries/three.png)

- Fill in the following:
	- Use `Authenticated Users` as the `Principle` field
	- Type: `Success`
	- Applies to: `This object and all descendant objects`
- Scroll down to the bottom of the window, then click `Clear all`
- Finally configure the following permissions
	- `Create all child objects`
	- `Create dnsZoneScopeContainer objects`

![](img/auditing-dns-entries/four.png)

- Click `OK`
- Click `Apply` then `OK`
- Click `OK`
