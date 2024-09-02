# Windows Server 2022 23H2+
- Starting with Windows Server 2022, 23H2 Edition, all new versions of Windows will contain this GPO setting
- GPO Location: `Default Domain Controller Policy\Computer Configuration\Policies\Windows Setting\Security Settings\Local Policies\Security Options`
	- `Domain controller: LDAP server channel binding token requirements`

# AD DS DCs
- Registry Location: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters`
	- DWORD `LdapEnforceChannelBinding` -> 2
		- 0 indicates *disabled*
		- 1 indicates *enabled*
		- 2 indicates *enabled, always*
# AD LDS Servers
- Registry Location: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\_<LDS instance name>_\Parameters`
	- DWORD `LdapEnforceChannelBinding` -> 2
		- 0 indicates *disabled*
		- 1 indicates *enabled*
		- 2 indicates *enabled, always*