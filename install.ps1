param(
    [string]$Destination = (Join-Path $HOME ".codex\skills"),
    [switch]$Force
)

$ErrorActionPreference = "Stop"

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "未找到 Git，请先安装 Git。"
}

$groups = @(
    @{
        Repo = "https://github.com/Niko-mzz/Doctor-Ge-SCI-paper-Writing.git"
        Items = @(
            @{ Path = "skills/citation-verification"; Name = "citation-verification" },
            @{ Path = "skills/reference-management"; Name = "reference-management" },
            @{ Path = "skills/exemplar-paper-analysis"; Name = "exemplar-paper-analysis" },
            @{ Path = "skills/writing-pattern-extraction"; Name = "writing-pattern-extraction" },
            @{ Path = "skills/imitation-writing-practice"; Name = "imitation-writing-practice" },
            @{ Path = "skills/scientific-data-analysis"; Name = "scientific-data-analysis" },
            @{ Path = "skills/paper-figure"; Name = "paper-figure" },
            @{ Path = "skills/paper-writing"; Name = "paper-writing" },
            @{ Path = "skills/academic-language-polishing"; Name = "academic-language-polishing" },
            @{ Path = "skills/documents"; Name = "documents" },
            @{ Path = "skills/journal-selection"; Name = "journal-selection" },
            @{ Path = "skills/submission-and-peer-review"; Name = "submission-and-peer-review" }
        )
    },
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
$tempRoot = Join-Path ([IO.Path]::GetTempPath()) ("doctor-ge-sci-skills-" + [guid]::NewGuid())
New-Item -ItemType Directory -Path $tempRoot | Out-Null
$ready = 0

try {
    for ($index = 0; $index -lt $groups.Count; $index++) {
        $group = $groups[$index]
        $checkout = Join-Path $tempRoot ("repo-" + $index)
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
                throw "缺少 SKILL.md：$($item.Name)（$($item.Path)）"
            }
            if (Test-Path $target) {
                if (-not $Force) {
                    Write-Host "已存在，保留：$($item.Name)" -ForegroundColor Yellow
                    $ready++
                    continue
                }
                Remove-Item -LiteralPath $target -Recurse -Force
            }
            Copy-Item -LiteralPath $source -Destination $target -Recurse
            if (-not (Test-Path (Join-Path $target "SKILL.md"))) {
                throw "安装校验失败：$($item.Name)"
            }
            $ready++
            Write-Host "已安装：$($item.Name)" -ForegroundColor Green
        }
    }
}
finally {
    if (Test-Path $tempRoot) { Remove-Item -LiteralPath $tempRoot -Recurse -Force }
}

if ($ready -ne 22) { throw "安装未完成：当前就绪 $ready/22 个 Skills。" }
Write-Host "`n完成：Word 文档中的 22/22 个 Skills 均已就绪。" -ForegroundColor Green
Write-Host "安装目录：$Destination"
Write-Host "请重启 Codex 以加载新 Skills。"
