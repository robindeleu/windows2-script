$File1= get-content "./logs/proc-11-11-2020-1.txt"
$File2 = get-content "./logs/proc-11-11-2020-2.txt"
$finaldest2       = "./logs/test.txt"
Function Compare-Contract

{

[cmdletBinding()]

Param (

    $Previous = "./logs/logfile-security-17-11-2020.txt",

    $Current = "./logs/logfile-security-11-11-2020.txt"

)

 

 

    # Function: Write-Line

    # Writes the characters out one by one.  Green if they match, red if they do not.

    # The LoneLine and ShortLine allows for any lines that have extra

    # Characters in them to be marked in red.

    Function Write-Line

    {

        Param ($LongLine, $ShortLine)

        $Y = $LongLine.Count

 

        Try

        {

            For ($X = 0;$X -lt $Y; $X++)

            {

                If($LongLine[$X] -eq $ShortLine[$X])

                {

                    Write-Host "$($LongLine[$X])" -NoNewline @Color0

                }

                Else

                {

                    Write-Host "$($LongLine[$X])" -NoNewline @Color1

                }

               

            }

        }

        Catch

        {Write-Host "$LongLine[$X]" -NoNewline @Color1}

 

        # Adds a carriage return to the line.

        Write-Host ""

 

    } # End: Function Write-Line

 

    # Read the content of the text files.

    $Previous = Get-Content $Previous

    $Current = Get-Content $Current

 

    # Split the contracts on each line.  This helps to reduce

    # the false positives.

    $Prev = $Previous.Split("`n")

    $Curr = $Current.Split("`n")

   

    # Color splats used to help clarify what I need to look at.

    $Color0 = @{ForegroundColor="Green";BackgroundColor = "DarkBlue"}

    $Color1 = @{ForegroundColor="Red";BackgroundColor = "DarkRed"}

    $Color2 = @{ForegroundColor="Cyan";BackgroundColor = "DarkBlue"}

    $Color3 = @{ForegroundColor="Magenta";BackgroundColor = "DarkBlue"}   

    

    # Lets you know if any lines were added or removed between contracts.

    Write-Host "Previous contract line count: $($Prev.Count)" @Color2

    Write-Host "Current contract line count: $($Curr.Count)" @Color2

    Write-Host "-------------------------------------------------------"

 

    # Find out what the maximum line count is between the two contracts.

    $Y = $Prev.count, $Curr.count | Measure-Object -Maximum |

         Select-Object -ExpandProperty Maximum

 

    # Loop through the contracts line by line.

    # The IF Statements makes sure that if one contract is longer then

    # the other, that the extended text will be marked red.

    For ($X = 0; $X -lt $Y; $X++)

    {

 

        Try

        {

            If ($Curr.count -ge $Prev.count)

            {

                Write-Host "[$($X)]" -NoNewLine @Color3

                $P = $Prev[$X].ToCharArray()

                $C = $Curr[$X].ToCharArray()

                Write-Line -LongLine $C -ShortLine $P

            }

        }

        Catch

        {

            Write-Host $Curr[$X] @Color1

        }

           

        Try

        {   

            If ($Curr.count -lt $Prev.count)

            {

                Write-Host "[$($X)]" -NoNewLine @Color3

                $P = $Prev[$X].ToCharArray()

                $C = $Curr[$X].ToCharArray()

                Write-Line -LongLine $P -ShortLine $C

            }

        }

        Catch

        {

            Write-Host $Prev[$X] @Color1

        }

 

 

    } # End: For ($X = 0; $X -lt $Y; $X++)

<#

.SYNOPSIS

Compares two sets of texts for differences.

 

.DESCRIPTION

Compares two sets of texts for differences.  Highlights lines with

different characters in red.

 

.PARAMETER Previous

The text file of the previous contract.

 

.PARAMETER Current

The text file of the current contract.

 

.EXAMPLE

Compare-Contract -Previous Previous.txt -Current Current.txt

 

.NOTE

Output is written to the host utilizing Write-Host.  Output to an object

is not part of this codes design.

 

#>

} # End: Compare-Contract
Compare-Contract