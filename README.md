# Server health check

[![made-for-VSCode](https://img.shields.io/badge/Made%20for-Powershell-1f425f.svg)](https://code.visualstudio.com/)

## Usage

Run the powershell script by typing in the terminal ".\windowsscript.ps1".

```bash
D:\VIVES\Vakken\Windows2\windows2-script [master]>.\windowsscript.ps1\
```

## Menu

Allows the user to choose for a full health check or a certain health check.

```bash
================ Powershell health check ================
1: Perform Full health check
2: Check CPU-usage
3: Check RAM-usage
4: Check Disk-usage
5: Show Event Logs
6: Show Installed Programs
7: Show Live Processes
8: Show Users
9: Open current directory with elevated permissions
Q: Quit
Please make a selection:
```

## CPU-usage

Shows the user, the total used CPU usage.

```bash
------------------------------------------------------
                Checking 'CPU Usage WORKING'
------------------------------------------------------

Live processor ussage: 41%

InstanceName CPU   
------------ ---   
teams        16.70%
code         15.92%
code         4.47% 
dwm          3.88% 
teams        3.30% 
teams        2.52% 
chrome       1.36% 
audiodg      1.36% 
code         1.16% 
skype        0.78% 



Press any key to continue . . . 
```

## RAM-usage

Shows the user, the total used RAM usage and used memory.

```bash
------------------------------------------------------
                Checking 'RAM Usage WORKING'
------------------------------------------------------

Live RAM-Usage: 76.18%

Used Memory(Mb) ProcessName
--------------- -----------
            358 vmmem
            278 Memory Compression
            266 Teams
            245 Teams
            198 Dropbox
            169 Code
            166 chrome
            161 Code
            155 Teams
            154 Teams
            150 chrome
            146 cmdagent
            135 cavwp
            117 Teams
            107 explorer


Press any key to continue . . .
```

## Disk-usage

Shows the user, the total used disk usage and their free/used space.

```bash
------------------------------------------------------
                Checking 'Disk Usage WORKING'
------------------------------------------------------


Name                                              Total Capacity (GB) Free Space (GB) Free (%)
----                                              ------------------- --------------- --------
\\?\Volume{32ba77f2-94ec-4a00-a8ed-715750ad131c}\                0,25            0,17       69
D:\                                                            914,89          553,37       60
\\?\Volume{63a8daee-1846-4218-84cd-9ee54c69206a}\                0,96            0,29       30
E:\                                                             16,62            1,96       12
C:\                                                            118,01            6,82        6



Press any key to continue . . .
```

## Event logs

Shows the user, the logs of events happened on the system and counts them by id. Eg. User logins

```bash
------------------------------------------------------
                CHECKING SECURITY LOG
------------------------------------------------------


EventId Count Info
------- ----- ----
   5379 26814 Credential Manager credentials were read
   4798  1769 A user's local group membership was enumerated.
   5038  1448 Code integrity determined that the image hash of a file is not valid
   4907  1082 Auditing settings on object were changed
   4624   816 An account was successfully logged on
   4672   757 Special privileges assigned to new logon
   5061   340 Cryptographic operation
   5059   101 Key migration operation
   4634    96 An account was logged off
   4648    84 A logon was attempted using explicit credentials
   5382    80 Vault credentials were read
   4797    76 An attempt was made to query the existence of a blank password for an account
   4799    64 A security-enabled local group membership was enumerated
   4688    52 A new process has been created
   5058    42 Key file operation
   4738    35 A user account was changed
   4647    16 User initiated logoff
   5381    15 Vault credentials were read
   4608     4 Windows is starting up
   4826     4 Boot Configuration Data loaded
   1100     4 The event logging service has shut down
   4696     4 A primary token was assigned to process
   5024     4 The Windows Firewall Service has started successfully
   5033     4 The Windows Firewall Driver has started successfully
   4902     4 The Per-user audit policy table was created
   4625     2 An account failed to log on
   6281     2 Code Integrity determined that the page hashes of an image file are not valid...
   4616     1 The system time was changed.





------------------------------------------------------
                 CHECKING SYSTEM LOG
------------------------------------------------------


EventId Count Info
------- ----- ----
      0   233 No description
  10016   143 No description
     37    40 No description
  10010    38 The server did not register with DCOM within the required timeout.
    219    18 No description
   1014    14 No description
   7000    10 No description
      3     6 No description
     11     6 No description
      6     6 No description
    157     6 No description
  10002     5 No description
   1538     5 No description
   7009     4 No description
   5007     2 No description
   7011     2 No description
  10028     1 No description
  10400     1 No description





------------------------------------------------------
             CHECKING APPLICATION LOG
------------------------------------------------------


EventId Count Info
------- ----- ----
   2002    16 No description
     64    15 No description
    100    13 Het systeem kan de opgegeven omgevingsoptie niet vinden.
  10010    12 No description
    902     5 Software Protection Service has started/is starting.
    903     4 Software Protection Service has stopped.
     13     4 No description
   8193     4 No description
   1020     3 No description
   1008     3 No description
   1032     2 No description
   2004     1 No description
   6004     1 No description
   1002     1 No description





------------------------------------------------------
                    Saving Logs
------------------------------------------------------


Log saved: ./logs/logfile-system-17-11-2020.txt
Log saved: ./logs/logfile-security-17-11-2020.txt
Log saved: ./logs/logfile-application-17-11-2020.txt

------------------------------------------------------
                    Comparing Logs
------------------------------------------------------

========> No Security log to compare with


========> No System log to compare with


========> No Application log to compare with


Press any key to continue . . .
```

## Installed programs

Shows the user, the first ten installed programs on the system along with the necessary info. And checks if it changed from the last time checked.

Beware, if you want to compair you must to edit a variable in the script like.

```powershell
$compareDate = "11-11-2020"
# Fill in the id, 1 is for the first time running, 2 to make the compair object.
# You must run it 2 times to make that he can compaire (befor with $saveid="1" and aftera suspected attack with $saveid="2")
$saveid="2"
# Underneed you can change the 
$logsDirectory = "logs"
# Here set the path to the reference object
$referenceopbject = "./$logsDirectory/inst-prog-11-11-2020-1.txt" 

```

```bash
------------------------------------------------------
                Checking Installed Programs
------------------------------------------------------


DisplayName                                                                 DisplayVersion   Publisher                  InstallDate
-----------                                                                 --------------   ---------                  -----------
Adobe Creative Cloud                                                        4.8.2.476        Adobe Systems Incorporated
                                                                                             Adobe Systems Incorporated 6/10/2019

                                                                                             Adobe Systems Incorporated 6/9/2019   
Digilent Software                                                           1.5.8            Digilent, Inc.
GNU Tools for ARM Embedded Processors 6-2017-q2-update 6 2017 (remove only) 6 2017-q2-update ARM Holdings
Google Chrome                                                               86.0.4240.198    Google LLC                 20201112
Kaspersky Secure Connection                                                 20.0.14.1085     Kaspersky
Kaspersky Security Cloud                                                    20.0.14.1085     Kaspersky




saved in: ./logs/inst-prog-11-11-2020-2.txt

InputObject                                                                                                                         SideIndicator
-----------                                                                                                                         -------------
Office 16 Click-to-Run Localization Component                               16.0.13328.20340 Microsoft Corporation      20201113    =>
Microsoft Visual C++ 2008 Redistributable - x86 9.0.30729.6161              9.0.30729.6161   Microsoft Corporation      20180503    =>
Adobe Refresh Manager                                                       1.8.0            Adobe Systems Incorporated 20200927    =>
Adobe Acrobat Reader DC - Nederlands                                        20.013.20064     Adobe Systems Incorporated 20201105    =>
Silicon Laboratories CP210x VCP Drivers for Windows XP/2003 Server/Vista/7  6.2.00           Silicon Laboratories, Inc. 20181127    =>
Microsoft Visual C++ 2012 x86 Additional Runtime - 11.0.61030               11.0.61030       Microsoft Corporation      20180503    =>
Office 16 Click-to-Run Localization Component                               16.0.13328.20340 Microsoft Corporation      20201113    <=



Press any key to continue . . .
```

## Live Processes

Shows the user, the current live processes on the system.

```bash
------------------------------------------------------
                Checking 'All live processes working'
------------------------------------------------------


Handles  NPM(K)    PM(K)      WS(K)     CPU(s)     Id  SI ProcessName
-------  ------    -----      -----     ------     --  -- -----------
   2287      20    38920      23792   5.423,05   3652   0 audiodg
   2917    4928   427636     245868   1.492,64  14740  14 Teams
   1181      35   245824     215556     864,53   3736  14 Teams
    537      38   194620     193872     727,42  23192  14 Code
   5147     171   271564     151952     709,36  18176  14 Dropbox
    429      92   167036     183276     500,02  21888  14 Teams
    503    1120     9740      17084     480,73  17244  14 SynTPEnh
   1417      29   239640     121516     259,58  16332  14 chrome
    528     148   329908     289296     259,55  16336  14 Teams
    961      79    63952      60348     228,11   5916  14 steam



Press any key to continue . . .
```

## Users

Shows the user, the users on the system along with the necessary info. And checks if it changed from the last time checked.

```bash
------------------------------------------------------
                Checking Users
------------------------------------------------------


Name                PrincipalSource LastLogon           PasswordChangeableDate PasswordLastSet     Description
----                --------------- ---------           ---------------------- ---------------     -----------
WDAGUtilityAccount            Local                     16/09/2018 21:37:06    16/09/2018 21:37:06 Een gebruikersaccount dat wordt beheerd en gebruik...
Gast                          Local                                                                Ingebouwd account voor gasttoegang op de computer ...
Tjoep                         Local 16/03/2020 13:01:38 16/03/2020 13:00:10    16/03/2020 13:00:10
Administrator                 Local 6/12/2017 1:37:21                          18/03/2017 4:53:19  Ingebouwd account voor beheer van de computer of h...
DefaultAccount                Local                                                                Een gebruikersaccount dat wordt beheerd door het s...
dhond              MicrosoftAccount                     16/03/2020 12:58:42    16/03/2020 12:58:42
benja              MicrosoftAccount                     14/09/2018 19:21:13    14/09/2018 19:21:13
mamam              MicrosoftAccount                     16/03/2020 12:58:42    16/03/2020 12:58:42


dinsdag 11/17/2020 11:30 +01:00

Number of Local accounts:  5
Number of Microsoft accounts:  3

Files are the same
```

## Shares

Shows the user, the shares on the system and makes a backup.

```bash
------------------------------------------------------
                Checking 'All shares'
------------------------------------------------------


Name     Path        Description
----     ----        -----------
ADMIN$   C:\WINDOWS  Extern beheer
C$       C:\         Standaardshare
D$       D:\         Standaardshare
E$       E:\         Standaardshare
IPC$                 Externe IPC
SERVERS! D:\SERVERS!



saved in: ./logs/shares-11-11-2020-2.txt
Press any key to continue . . .
```

## Elevated permissions

Allows user to run powershell with elevated permissions. This is necessary for the script show-event-logs.ps1.

## UML
