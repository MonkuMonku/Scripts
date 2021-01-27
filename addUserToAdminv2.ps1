param(
[Parameter(Position=0)]
[bool] $FileMode = $false
)
$users = "null"
$targetFile = "null"
$group = "Administrators"

if($FileMode -eq $false)
{
    $users = Read-Host "Enter a username"
}
else
{
    $targetFile = Read-Host "Give a file of usernames"
    $users = Get-Content $targetFile
}

Write-Host "Adding users to local $group group..."

if($FileMode -eq $true)
{
    ForEach ($user in $users)
    {
        Try
        {          
            Add-LocalGroupMember -Group $group -Member $user -ErrorAction Stop
            Write-Host "$user added to local $group group successfully"
        }
        Catch
        {
            Write-Host "Unable to add $user to the local $group group - ($_)"
        }
    }
}
else
{
    Try
    {
        Add-LocalGroupMember -Group $group -Member $users -ErrorAction Stop
        Write-Host "$user added to local $group group successfully"
    }
    Catch
    {
        Write-Host "Unable to add $user to the local $group group - ($_)"
    }
pause
}
