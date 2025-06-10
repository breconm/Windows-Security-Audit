
Write-Host "===== WINDOWS SECURITY AUDIT REPORT =====" -ForegroundColor Cyan

# Section 1: Windows Defender
Write-Host "`n[+] Checking Windows Defender status..." -ForegroundColor Yellow
$defenderStatus = $null
Start-Sleep -Milliseconds 500
$defenderStatus = Get-MpComputerStatus
Write-Host "    - AntispywareEnabled: $($defenderStatus.AntispywareEnabled)"
Write-Host "    - RealTimeProtectionEnabled: $($defenderStatus.RealTimeProtectionEnabled)"
if ($defenderStatus.AntispywareEnabled -eq $true -and $defenderStatus.RealTimeProtectionEnabled -eq $true) {
    Write-Host "✅ Windows Defender is enabled and running." -ForegroundColor Green
} else {
    Write-Host "❌ Windows Defender is NOT properly enabled." -ForegroundColor Red
}

# Section 2: Firewall
Write-Host "`n[+] Checking Windows Firewall status..." -ForegroundColor Yellow
try {
    $profiles = Get-NetFirewallProfile
    foreach ($profile in $profiles) {
        if ($profile.Enabled -eq $true) {
            Write-Host "✅ $($profile.Name) Firewall is ON." -ForegroundColor Green
        } else {
            Write-Host "❌ $($profile.Name) Firewall is OFF!" -ForegroundColor Red
        }
    }
} catch {
    Write-Host "⚠️ Could not retrieve firewall status. Are you running PowerShell as Administrator?" -ForegroundColor Red
}

# Section 3: Password Policy
Write-Host "`n[+] Checking Password Policy..." -ForegroundColor Yellow
try {
    $passwordInfo = net accounts
    Write-Host $passwordInfo
} catch {
    Write-Host "⚠️ Could not retrieve password policy." -ForegroundColor Red
}

# Section 4: Local Admin Accounts
Write-Host "`n[+] Checking Local Administrator Accounts..." -ForegroundColor Yellow
try {
    $adminGroup = Get-LocalGroupMember -Group "Administrators"
    foreach ($member in $adminGroup) {
        Write-Host "👤 $($member.Name) is an administrator." -ForegroundColor Cyan
    }
} catch {
    Write-Host "⚠️ Could not retrieve local admin accounts." -ForegroundColor Red
}

# Section 5: Guest Account Status
Write-Host "`n[+] Checking Guest Account status..." -ForegroundColor Yellow
try {
    $guest = Get-LocalUser -Name "Guest"
    if ($guest.Enabled -eq $true) {
        Write-Host "❌ Guest account is ENABLED. This is a security risk!" -ForegroundColor Red
    } else {
        Write-Host "✅ Guest account is disabled." -ForegroundColor Green
    }
} catch {
    Write-Host "⚠️ Could not check Guest account status." -ForegroundColor Red
}

# Section 6: Remote Desktop Status
Write-Host "`n[+] Checking Remote Desktop status..." -ForegroundColor Yellow
try {
    $rdpStatus = Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections"
    if ($rdpStatus.fDenyTSConnections -eq 0) {
        Write-Host "❌ Remote Desktop is ENABLED. This can be a security risk!" -ForegroundColor Red
    } else {
        Write-Host "✅ Remote Desktop is disabled." -ForegroundColor Green
    }
} catch {
    Write-Host "⚠️ Could not check RDP status." -ForegroundColor Red
}

# Section 7: BitLocker
Write-Host "`n[+] Checking BitLocker Drive Encryption status..." -ForegroundColor Yellow
try {
    $bitlockerStatus = Get-BitLockerVolume
    foreach ($vol in $bitlockerStatus) {
        $volumeLetter = $vol.VolumeLetter
        $status = $vol.ProtectionStatus
        if ($status -eq 1) {
            Write-Host "✅ Drive $volumeLetter is encrypted with BitLocker." -ForegroundColor Green
        } else {
            Write-Host "❌ Drive $volumeLetter is NOT encrypted with BitLocker." -ForegroundColor Red
        }
    }
} catch {
    Write-Host "⚠️ BitLocker not supported or PowerShell module missing." -ForegroundColor Yellow
}

Read-Host "`nPress ENTER to exit"
