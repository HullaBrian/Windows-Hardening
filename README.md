# Project Overview
Windows-Hardening is a repository for GPOs (domain and local) and scripts (eventually) meant to assist in the hardening of various Windows operating systems.

The aim is to maximize security while minimizing the impact on user experience, so some settings - such as more verbose logging - have been tuned to attempt balance. Each folder in the root directory of this project corresponds to a different Windows operating system. Additionally, there is documentation for each OS in this readme (see contents below)

In the interest of giving credit where credit is due, some of these configurations are based off of the [Microsoft Security Compliance Toolkit 1.0](https://learn.microsoft.com/en-us/windows/security/operating-system-security/device-management/windows-security-configuration-framework/windows-security-baselines) (See below)
- Windows Server 2022 Security Baseline

# Contents
- [Project Overview](#project-overview)
- [Contents](#contents)
- [Installation](#installation)
    - [Local Installation](#local-installation)
    - [Domain Installation](#domain-installation)
- [Documentation](#documentation)
    - [Windows 10 Pro (Standalone)](#windows-10-pro-standalone)
    - [Windows Server 2022 (Domain)](#windows-server-2022-domain)

# Installation
## Local Installation
**This is meant to install on standalone machines.**

Find the matching top-level folder for the machine.
- To install the GPO (not security policy) onto your machine, simply copy the `GroupPolicy` (and `GroupPolicyUsers` if present) into `C:\Windows\System32\` or `%SystemRoot%\System32\`
- To install the local security policy, open the `Local Security Policy` application. Then, navigate to `Action > Import Policy...` and select the `.inf` file from the repository.

## Domain Installation
**This is meant to install on domain-joined machines.**

Coming soon...

# Documentation
## Windows 10 Pro Standalone
- `Computer Configuration\`
    - `Windows Settings\`
        - `Security Settings\`
            - `Account Policies\`
                - `Password Policy\`
                    - `Enforce password history` → 1 passwords remembered
                    - `Maximum password age` → 90 days
                    - `Minimum password age` → 1 days
                    - `Minimum password length` → 8 characters
                    - `Minimum password length audit` → 8 characters
                    - `Password must meet complexity requirements` → Enabled
                    - `Store passwords using reversible encryption` → Disabled
                - `Account Lockout Policy`
                    - `Account lockout duration` → 10 minutes
                    - `Account lockout threshold` → 5 invalid logon attempts
                    - `Allow Administrator account lockout` → Enabled
                    - `Reset account lockout counter after` → 10 minutes
            - `Local Policies\`
                - `Audit Policy\`
                    - `Audit account logon events` → Success, Failure
                    - `Audit account management` → Success, Failure
                    - `Audit directory service access` → Success, Failure
                    - `Audit logon events` → Success, Failure
                    - `Audit object access` → Success, Failure
                    - `Audit policy change` → Success, Failure
                    - `Audit privilege use` → Success, Failure
                    - `Audit process tracking` → Success, Failure
                    - `Audit system events` → Success, Failure
                - `User Rights Assignment\`
                    - `Access this computer from the network` → Administrators, Users
                    - `Act as part of the operating system` → None
                    - `Allow log on locally` → Administrators, Users
                    - `Back up files and directories` → Administrators
                    - `Create a token object` → None
                    - `Debug Programs` → None
                    - `Load and unload device drivers` → Administrators
                    - `Replace a process level token` → Network Service, Local Service
                    - `Restore files and directories` → Administrators
                    - `Shut down the system` → Administrators
                    - `Impersonate a client after authentication` → Administrators, Local Service, Network Service, Service
                    - `Take ownership of files or other objects` → Administrators
                - `Security Options\`
                    - `Accounts: Administrator account status` → Disabled
                    - `Accounts: Guest account status` → Disabled
                    - `Devices: Prevent users from installing printer drivers` → Enabled
                    - `Interactive logon: Display user information when the session is locked` → User display name only
                    - `Interactive logon: Machine inactivity limit` → 300 seconds
                    - `Microsoft network client: Digitally sign communications (always)` → Enabled
                    - `Microsoft network client: Send unencrypted password to third-party SMB servers` → Disabled
                    - `Microsoft network server: Digitally sign communications (always)` → Enabled
                    - `Microsoft network server: Server SPN target name validation level` → Required from client
                    - `Network access: Do not allow anonymous enumeration of SAM accounts and shares` → Enabled
                    - `Network access: Let Everyone permissions apply to anonymous users` → Disabled
                    - `Network access: Restrict anonymous access to Named Pipes and Shares` → Enabled
                    - `Network security: LAN Manager authentication level` → Send NTLMv2 responses only. Refuse LM & NTLM
                    - `Network security: LDAP client signing requirements` → Require signing
                    - `Network Security: Restrict NTLM: Audit Incoming NTLM Traffic` → Enable auditing for all accounts
                    - `Network security: Restrict NTLM: Incoming NTLM traffic` → Deny all accounts
                    - `Shutdown: Allow system to be shut down without having to log on` → Enabled
                    - `Shutdown: Clear virtual memory pagefile` → Enabled
                    - `System objects: Strengthen default permissions of internal system objects (e.g. Symbolic Links)` → Enabled
                    - `User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode` → Prompt for credentials
                    - `User Account Control: Behavior of the elevation prompt for standard users` → Prompt for credentials
                    - `User Account Control: Run all administrators in Admin Approval Mode` → Enabled
                    - `User Account Control: Switch to the secure desktop when prompting elevation` → Enabled
                    - `User Account Control: Virtualize file and registry write failures to per-user locations` → Enabled
                - `Windows Defender Firewall with Advanced Security\`
                    - `Windows Defender Firewall with Advanced Security - Local Group Policy Object\`
                        - `Private Profile`
                            - `Firewall state` → On
                            - `Inbound connections` → Block
                            - `Outbound connections` → Allow
                        - `Public Profile`
                            - `Firewall state` → On
                            - `Inbound connections` → Block
                            - `Outbound connections` → Allow
                        - `Inbound Rules\`
                            - Block `RDP` using predefined template
                            - Block `Windows Remote Management` using predefined template
                - `Advanced Audit Policy Configuration\`
                    - `Advanced Audit Policies - Local Group Policy Object\`
                        - `Account Management\`
                            - `Audit User Security Group Management` → Success, Failure
                            - `Audit User Account Management` → Success, Failure
                        - `Logon/Logoff\`
                            - `Audit Account Lockout` → Success and Failure
                            - `Audit Logon` → Success and Failure
                        - `System\`
                            - `Audit System Integrity` → Success and Failure
    - `Administrative Templates\`
        - `Control Panel\`
            - `Personalization\`
                - `Prevent enabling lock screen camera` → Enabled
            - `Regional and Language Options\`
                - `Restricts the UI language Windows uses for all logged users` → Enabled, English
        - `Network\`
            - `DNS Client\`
                - `Turn off smart multi-homed name resolution` → Enable
            - `WLAN Service\WLAN Settings\`
                - `Allow Windows to automatically connect to suggested open hotspots, to networks shared by contacts, and to hotspots offering paid services` → Disabled
        - `User Profiles\`
            - `Turn off the advertising ID` → Enabled
        - `Windows Components\`
            - `BitLocker Drive Encryption\`
                - `Choose drive encryption method and cipher strength` → XTS-AES 256-bit for all options
            - `File Explorer\`
                - `Allow the use of remote paths in file shortcut icons` → Disabled
                - `Configure Windows Defender SmartScreen` → Warn
                - `Turn off shell protocol protected mode` → Disabled
            - `Internet Explorer\`
                - `Disable Internet Explorer 11 as a standalone browser` → Enabled
            - `Microsoft Defender Antivirus\`
                - `Allow antimalware service to remain running always` → Enabled
                - `Configure detection for potentially unwanted applications` → Enabled, Block
                - `Turn off Microsoft Defender Antivirus` → Disabled
                - `Turn off routine remediation` → Disabled
                - `MAPS\`
                    - `Configure local setting override for reporting to Microsoft MAPS` → Disabled
                    - `Configure the 'Block at First Sight' feature` → Enable
                    - `Join Microsoft MAPS` → Enabled, Basic MAPS
                    - `Send file samples when further analysis is required` → Enabled, Send safe examples
                - `Microsoft Defender Exploit Guard\`
                    - `Controlled Folder Access\`
                        - `Configure Controlled folder access` → Enabled, Audit
                    - `Network Protection\`
                        - `Prevent users and apps from accessing dangerous websites` → Enabled
                - `MPEngine\`
                    - `Configure extended cloud check` → 20
                    - `Enable file hash computation feature` → Enabled
                    - `Select cloud protection level` → Enabled, Moderate blocking level
                - `Network Inspection System\`
                    - `Turn on definition retirement` → Enabled
                    - `Turn on protocol recognition` → Enabled
                - `Real-time Protection\`
                    - `Configure local setting override for *` → Enabled
                    - `Configure monitoring for incoming and outgoing file and program activity` → Enabled, bi-directional
                    - `Monitor file and program activity on your computers` → Enabled
                    - `Scan all downloaded files and attachements` → Enabled
                    - `Turn off real-time protection` → Disabled
                    - `Turn on behavior monitoring` → Enabled
                    - `Turn on process scanning whenever real-time protection is enabled` → Enabled
                - `Scan\`
                    - `Turn on heuristics` → Enabled
                - `Security Intelligence Updates\`
                    - `Allow real-time security intelligence updates based on reports to Microsoft MAPS` → Enabled
                    - `Allow security intelligence updates from Microsoft Update` → Enabled
            - `Windows PowerShell\`
                - `Turn on Module Logging` → Enabled, Microsoft.PowerShell.*, Microsoft.WSMan.Management
                - `Turn on PowerShell Script Block Logging` → Enabled
                - `Turn on Script Execution` → Disabled
            - `Windows Remote Shell\`
                - `Allow Remote Shell Access` → Disabled
- `User Configuration\`
    - `Administrative Templates\`
        - `Start Menu and Taskbar\`
            - `Turn off user tracking` → Enabled
            - `Do not search Internet` → Enabled

## Windows Server 2022 Domain