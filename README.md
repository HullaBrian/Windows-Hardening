# Windows-Hardening
Windows-Hardening is a repository for GPOs (domain and local) and scripts meant to assist in the hardening of various Windows operating systems.

The aim is to maximize security while minimizing the impact on user experience, so some settings - such as more verbose logging - have been tuned to attempt balance. Under each folder in this repository, there is a `README.md` containing all of the major settings that have been changed.

## Local Installation (standalone machines, not domain-joined)
Find the matching top-level folder for the machine.
- To install the GPO (not security policy) onto your machine, simply copy the `GroupPolicy` (and `GroupPolicyUsers` if present) into `C:\Windows\System32\` or `%SystemRoot%\System32\`
- To install the local security policy, open the `Local Security Policy` application. Then, navigate to `Action > Import Policy...` and select the `.inf` file from the repository.