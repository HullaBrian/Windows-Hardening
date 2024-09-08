# Overview
The aim of this project's GPOs are to maximize security while minimizing the impact on user experience, so some settings - such as more verbose logging - have been tuned to attempt balance. Each folder in the `GPOs` directory of this project corresponds to a different Windows operating system. Additionally, there will (hopefully) be documentation for each OS either in this readme (below) or included in `.htm` previews.

In the interest of giving credit where credit is due, many of these configurations are based off of the [Microsoft Security Compliance Toolkit 1.0](https://learn.microsoft.com/en-us/windows/security/operating-system-security/device-management/windows-security-configuration-framework/windows-security-baselines) as well as [STIG GPOs](https://public.cyber.mil/stigs/gpo/) (All files in the `SupportFiles` directory are from this as well).

# Installation
## Local Installation
**This is meant to install on standalone machines.**

Find the matching folder for the machine in the `GPOs` directory of this project.
- To install the GPO (not security policy) onto your machine, simply copy the `GroupPolicy` (and `GroupPolicyUsers` if present) into `C:\Windows\System32\` or `%SystemRoot%\System32\`
- To install the local security policy, open the `Local Security Policy` application. Then, navigate to `Action > Import Policy...` and select the `.inf` file from the repository.

## Domain Installation
**These are meant to be installed in an Active Directory environment on a Domain Controller**

Coming soon...