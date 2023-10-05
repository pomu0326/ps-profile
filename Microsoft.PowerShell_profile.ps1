# Prompt
function prompt {
    $hostname = hostname
    $username = $env:USERNAME
    $path = (Get-Location).Path
    $gitbranch = `
        if ((-not [int]$env:PROMPT_SKIP_GIT) -and (Get-Command -Name 'git' -ErrorAction Ignore)) {
        "$(
                git branch `
                | Where-Object { $_ -match '^\* (.*)$' } `
                | ForEach-Object { $Matches[1] }
            )"
    }
    else {
        ""
    }

    Write-Host ""
    Write-Host "┌──(" -NoNewline -ForegroundColor "Green"
    Write-Host "$username@$hostname" -NoNewline -ForegroundColor "Magenta"
    Write-Host "                   )-[".Trim() -NoNewline -ForegroundColor "Green"
    Write-Host "                      $path".Trim() -NoNewline
    Write-Host "                           ]".Trim() -NoNewline -ForegroundColor "Green"
    if ($gitbranch) {
        Write-Host " (" -NoNewline -ForegroundColor "Green"
        Write-Host "  $gitbranch".Trim() -NoNewline -ForegroundColor "Red"
        Write-Host "            )".Trim() -NoNewline -ForegroundColor "Green"
    }

    Write-Host ""
    Write-Host "└─" -NoNewline -ForegroundColor "Green"
    Write-Host "    PS".Trim() -NoNewline -ForegroundColor "Magenta"
    Write-Host "      >".Trim() -NoNewline -ForegroundColor "Green"

    return " "
}

# Aliases
function ll { Get-ChildItem @args }

# Helper

function Get-UppercaseAlphabet {
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.ToCharArray()
}

function Get-LowercaseAlphabet {
    'abcdefghijklmnopqrstuvwxyz'.ToCharArray()
}

function Get-NumberCharacter {
    '0123456789'.ToCharArray()
}

function Get-SymbolCharacter {
    [char[]] @(
        '!' # 感嘆符
        '"' # ダブルクォート
        '#' # 番号記号
        '$' # ドル記号
        '%' # パーセント
        '&' # アンパサンド
        "'" # アポストロフィ、シングルクォート
        '(' # 左小かっこ
        ')' # 右小かっこ
        '*' # アスタリスク
        '+' # 正符号、プラス
        ',' # コンマ、セディユ
        '-' # ハイフン、負記号
        '.' # ピリオド
        '/' # 斜線、スラッシュ
        ':' # コロン
        ';' # セミコロン
        '<' # 不等号（より小）
        '=' # 等号
        '>' # 不等号（より大）
        '?' # ?
        '@' # 単価記号、アットマーク
        '[' # 左大かっこ
        '\' # 円記号、バックスラッシュ
        ']' # 右大かっこ
        '^' # アクサンシルコンフレックス
        '_' # アンダーライン
        '`' # アクサングラーブ、バッククォート
        '{' # 左中かっこ
        '|' # 縦線、パイプ記号
        '}' # 右中かっこ
        '~' # チルダg 
    )
}

function Get-RandomCharacter {
    Param([char[]]$CharacterSet)
    $CharacterSet[$(Get-Random) % $CharacterSet.Length]
}

function New-Password {
    Param(
        [Parameter(Position = 0)]
        [int]$Length = 16,

        [char[]] $UppercaseAlphabet = (Get-UppercaseAlphabet),
        [char[]] $LowercaseAlphabet = (Get-LowercaseAlphabet),
        [char[]] $NumberCharacter = (Get-NumberCharacter),
        [char[]] $SymbolCharacter = (Get-SymbolCharacter),

        [char[]] $ExcludeCharacter = @()
    )
    
    $charset = @(
        $UppercaseAlphabet
        $LowercaseAlphabet
        $NumberCharacter
        $SymbolCharacter
    ) | Where-Object { (-not $ExcludeCharacter) -or ($_ -notin $ExcludeCharacter) }

    $result = (1..$Length | ForEach-Object {
            Get-RandomCharacter -CharacterSet $charSet
        }) -join ""
    
    $result
}

function Make {
    Invoke-psake -buildFile "$((Get-Item .).BaseName).build.ps1" @args
}