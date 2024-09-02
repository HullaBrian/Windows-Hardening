By default, Active Directory Domain Users can add static DNS entries to the domain. This can pose as a potential security threat, as having the ability to add arbitrary DNS entries to a domain could potentially be used to obfuscate adversary operations or facilitate attacks (such as an LDAP relay attack). Thankfully, restricting access to add DNS entries on an AD domain is very simple.

- Open the `DNS` snap in and navigate to the intended domain on the left pane

![](img/restricting-dns-entry-permissions/navigate-to-dns-snap-in.png)

- Right click on the domain, then select `Properties`

![](img/restricting-dns-entry-permissions/dns-zone-properties.png)

- Navigate to the `Security` tab and click on `Advanced`

![](img/restricting-dns-entry-permissions/advanced-security-settings.png)

- Select the entry whose `Principal` is `Authenticated Users` and select `Remove`

![](img/restricting-dns-entry-permissions/remove-authenticated-users-permissions.png)

- Click `Apply` then `OK`

Now, when a domain user (or adversary impersonating one) attempts to add a DNS record to the domain, they'll be denied access:

![](img/restricting-dns-entry-permissions/proof.png)