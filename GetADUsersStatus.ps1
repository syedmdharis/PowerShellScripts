cls
Write-Host(" ")
Write-Host("***** List of users active status *****")

#make sure the PowerShell version on the PC running script is OK
$verMajor = (PSVersionTable.PSVersion -spilt '\.')[0]
$verNum = [int] $verMajor
if ($verNum -eq 5)
{
    Write-Host("PowerShell version is acceptble")  -Foregroundcolor White
}
else
{
    Write-Host("PowerShell version on your PC isn't high enough; must be 5.  Was: " + $verNum) -ForegroundColor
}

$path = $PSScriptRoot
$rootPath = $path + "\"
$userListfile = $rootPath + "UserList.txt"

try
{
    Write-Host("Checking users list") -ForegroundColor Blue
    try
    {
        #load users List
        $error.clear()
        $users = Get-Content $userListFile
        if ($error.Count -gt 0)
        {
            throw "problem loading user list. Expected users list to be found at " + $userListFile
        }
        #Loop through users list
        foreach ($username in $users) 
        {
            $user = Get-ADUser -Filter { SamAccountName -eq $username } -Properties E 
            if ($user -ne $null) 
            {
                Write-Host($username + " " + $user. + " is " + $user.Enabled) -ForegroundColor Blue
            }
            else
            {
                Write-Host($username + "not found in AD") -ForegroundColor Red
            }
        }
    }
    catch
    {
        Write-Host($error)
    }
}
catch
{
    Write-Host($error)
}