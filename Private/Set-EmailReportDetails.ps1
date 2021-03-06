function Set-EmailReportDetails {
    param(
        $FormattingOptions,
        $ReportOptions,
        $TimeToGenerate,
        [int] $CountUsersImminent,
        [int] $CountUsersCountdownStarted,
        [int] $CountUsersAlreadyExpired
    )
    $DateReport = get-date
    # HTML Report settings
    $Report = @"
        <p>
            <strong>Report Time:</strong> $DateReport
            <br>
            <strong>Time to generate:</strong> $($TimeToGenerate.Hours) hours, $($TimeToGenerate.Minutes) minutes, $($TimeToGenerate.Seconds) seconds, $($TimeToGenerate.Milliseconds) milliseconds
            <br>
            <strong>Account Executing Report :</strong> $env:userdomain\$($env:username.toupper()) on $($env:ComputerName.toUpper())
            <br>
            <strong>Users expiring countdown started: </strong> $CountUsersCountdownStarted
            <br>
            <strong>Users expiring soon: </strong> $CountUsersImminent
            <br>
            <strong>Users already expired count: </strong> $CountUsersAlreadyExpired
            <br>
        </p>
"@
    foreach ($ip in $ReportOptions.MonitoredIps.Values) {
        $Report += "<li>ip:</strong> $ip</li>"
    }
    $Report += '</ul>'
    $Report += '</p>'
    return $Report
}