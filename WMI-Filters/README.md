# Quick Reference
| Target Platform            | Filter                                                                                                                                  |
|----------------------------|-----------------------------------------------------------------------------------------------------------------------------------------|
| Windows 10                 | `select * from Win32_OperatingSystem WHERE Version like "10.%" AND ProductType="1"`                                                     |
| Windows 10 x64             | `select * from Win32_OperatingSystem WHERE Version like "10.%" AND ProductType="1" AND OSArchitecture = "64-bit"`                       |
| Windows 10 x32             | `select * from Win32_OperatingSystem WHERE Version like "10.%" AND ProductType="1" AND OSArchitecture = "32-bit"`                       |
| Windows 10 Build X         | `select * from Win32_OperatingSystem WHERE Version like "10.%" AND ProductType="1" AND BuildNumber = "X"`                               |
| Windows 11                 | `select * from Win32_OperatingSystem WHERE Caption like "%Windows 11%"`                                                                 |
| Windows 11 Build X         | `select * from Win32_OperatingSystem WHERE Caption like "%Windows 11%" AND ProductType="1" AND BuildNumber = "X"`                       |
| Server 2016                | `select * from Win32_OperatingSystem WHERE Caption LIKE "%2016%" AND Version LIKE "10.%" AND ( ProductType = "2" or ProductType = "3")` |
| Server 2019                | `select * from Win32_OperatingSystem WHERE Caption LIKE "%2019%" AND Version LIKE "10.%" AND ( ProductType = "2" or ProductType = "3")` |
| Server 2022                | `select * from Win32_OperatingSystem WHERE Caption LIKE "%2022%" AND Version LIKE "10.%" AND ( ProductType = "2" or ProductType = "3")` |
| Specific Subnet(s)         | `Select * FROM Win32_IP4RouteTable WHERE (Mask='255.255.255.255' AND (Destination Like 10.1.1.%' OR Destination Like '10.1.2.%'))`      |
| X Bytes of RAM             | `Select * from WIN32_ComputerSystem where TotalPhysicalMemory >= X`                                                                     |
| Specific Program Installed | `Select * From Win32_Product where Name like "%7-Zip %"`                                                                                |

# WMI Filters
The WMI filter allows you to select the operating system type:
- ProductType=1 – any desktop Windows edition;
- ProductType=2 – Active Directory domain controller;
- ProductType=3 – Windows Server OS.

WMI query to select Windows version:
`select * from Win32_OperatingSystem WHERE Version LIKE "X.X%"`
- **Windows Server 2022,2019,2016 and Windows 11,10** — 10.%
- **Windows Server 2012 R2 and Windows 8.1** — 6.3%
- **Windows Server 2012 and Windows 8** — 6.2%
- **Windows Server 2008 R2 and Windows 7** — 6.1%
- **Windows Server 2008 and Windows Vista** — 6.0%
- **Windows Server 2003** — 5.2%
- **Windows XP** — 5.1%
- **Windows 2000** — 5.0%

# Examples
- Only `Windows Server 2019`:
	- `select * from Win32_OperatingSystem WHERE Caption LIKE "%2019%" AND Version LIKE "10.%" AND ( ProductType = "2" or ProductType = "3")`
- Only `Windows 10 x64`
	- `select * from Win32_OperatingSystem WHERE Version like "10.%" AND ProductType="1" AND OSArchitecture = "64-bit"`
- Only a specific build of `Windows 11` (for example, `23H2 build 22631`):
	- `select * from Win32_OperatingSystem WHERE Caption like "%Windows 11%" AND ProductType="1" AND BuildNumber = "22631"`
- VMWare VMs only
	- `SELECT Model FROM Win32_ComputerSystem WHERE Model LIKE "%VMware%"`
- Laptops only:
	- `select * from Win32_ComputerSystem where PCSystemType="2"`
- Desktops only:
	- `select * from Win32_ComputerSystem where PCSystemType="1" or PCSystemType="3"`
- Computers whose names begin with `lon-pc*`
	- `SELECT Name FROM Win32_ComputerSystem WHERE Name LIKE "lon-pc%"`
- Computers on specific subnets
	- `Select * FROM Win32_IP4RouteTable WHERE (Mask='255.255.255.255' AND (Destination Like 172.16.1.%' OR Destination Like '172.16.2.%'))`
- Computers with more than 4GB RAM
	- `Select * from WIN32_ComputerSystem where TotalPhysicalMemory >= 4200000000`
- Computers with a specific program installed
	- `Select * From Win32_Product where Name like "%7-Zip %"`