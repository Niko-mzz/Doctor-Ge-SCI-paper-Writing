param(
    [string]$Destination = (Join-Path $HOME ".codex\skills"),
    [switch]$Force
)

$ErrorActionPreference = "Stop"

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "未找到 git，请先安装 Git。"
}

$groups = @(
    @{
        Repo = "https://github.com/K-Dense-AI/scientific-agent-skills.git"
        Items = @(
            @{ Path = "skills/literature-review"; Name = "literature-review" },
            @{ Path = "skills/paper-lookup"; Name = "paper-lookup" },
            @{ Path = "skills/scientific-critical-thinking"; Name = "scientific-critical-thinking" },
            @{ Path = "skills/statistical-analysis"; Name = "statistical-analysis" },
            @{ Path = "skills/scientific-writing"; Name = "scientific-writing" },
            @{ Path = "skills/peer-review"; Name = "peer-review" },
            @{ Path = "skills/scholar-evaluation"; Name = "scholar-evaluation" }
        )
    },
    @{
        Repo = "https://github.com/bytedance/deer-flow.git"
        Items = @(
            @{ Path = "skills/public/systematic-literature-review"; Name = "systematic-literature-review" },
            @{ Path = "skills/public/academic-paper-review"; Name = "academic-paper-review" }
        )
    },
    @{
        Repo = "https://github.com/Orchestra-Research/AI-Research-SKILLs.git"
        Items = @(
            @{ Path = "20-ml-paper-writing/academic-plotting"; Name = "academic-plotting" }
        )
    }
)

New-Item -ItemType Directory -Force -Path $Destination | Out-Null
$tempRoot = Join-Path ([IO.Path]::GetTempPath()) ("sci-writing-skills-" + [guid]::NewGuid())
New-Item -ItemType Directory -Path $tempRoot | Out-Null

try {
    foreach ($group in $groups) {
        $repoName = [IO.Path]::GetFileNameWithoutExtension($group.Repo)
        $checkout = Join-Path $tempRoot $repoName
        Write-Host "`n获取 $($group.Repo)" -ForegroundColor Cyan
        & git clone --depth 1 --filter=blob:none --sparse $group.Repo $checkout
        if ($LASTEXITCODE -ne 0) { throw "克隆失败：$($group.Repo)" }

        $paths = @($group.Items | ForEach-Object { $_.Path })
        & git -C $checkout sparse-checkout set --no-cone @paths
        if ($LASTEXITCODE -ne 0) { throw "稀疏检出失败：$($group.Repo)" }

        foreach ($item in $group.Items) {
            $source = Join-Path $checkout ($item.Path -replace '/', '\')
            $target = Join-Path $Destination $item.Name
            if (-not (Test-Path (Join-Path $source "SKILL.md"))) {
                Write-Warning "上游路径不存在，跳过：$($item.Name)"
                continue
            }
            if (Test-Path $target) {
                if (-not $Force) {
                    Write-Host "跳过已存在：$($item.Name)（使用 -Force 可覆盖）" -ForegroundColor Yellow
                    continue
                }
                Remove-Item -LiteralPath $target -Recurse -Force
            }
            Copy-Item -LiteralPath $source -Destination $target -Recurse
            Write-Host "已安装：$($item.Name)" -ForegroundColor Green
        }
    }
}
finally {
    if (Test-Path $tempRoot) { Remove-Item -LiteralPath $tempRoot -Recurse -Force }
}

Write-Host "`n完成。请重启 Codex 以加载新 Skills。" -ForegroundColor Green
Write-Host "安装目录：$Destination"
Write-Host "注意：清单中没有已验证公开来源的规划型 Skill 不会被本脚本安装。"
