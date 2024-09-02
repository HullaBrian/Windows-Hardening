# Server Signing Requirement
- Group Policy Setting:
	- `Default Domain Controller Policy\Computer Configuration\Policies\Windows Setting\Security Settings\Local Policies\Security Options`
	- Set `Domain controller: LDAP server signing requirements` to `Require signing`
- Registry Setting: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters`
	- DWORD `LDAPServerIntegrity` set to `2`
		- 1 indicates no LDAP signing requirements
		- 2 indicates LDAP signing is required