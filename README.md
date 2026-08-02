# SCI 写作 Skills 一键安装器

这个目录把《Codex SCI 论文写作 Skills 分类》中的**公开下载方式**集中到一起。安装器不会把上游 Skill 源码复制进本仓库，而是在用户执行时从原作者的 GitHub 仓库获取，便于追溯来源和更新。

## 一键安装

### Windows PowerShell

```powershell
irm https://raw.githubusercontent.com/Niko-mzz/Doctor-Ge-SCI-paper-Writing/main/install.ps1 | iex
```

如需覆盖已有同名 Skill：

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/Niko-mzz/Doctor-Ge-SCI-paper-Writing/main/install.ps1))) -Force
```

### macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/Niko-mzz/Doctor-Ge-SCI-paper-Writing/main/install.sh | bash
```

覆盖已有同名 Skill：

```bash
curl -fsSL https://raw.githubusercontent.com/Niko-mzz/Doctor-Ge-SCI-paper-Writing/main/install.sh | bash -s -- --force
```

默认安装到 `~/.codex/skills`。安装完成后重启 Codex。

## 会自动安装的 10 个公开 Skills

| 分类 | Skill | 上游仓库 |
|---|---|---|
| 文献综述 | `literature-review` | `K-Dense-AI/scientific-agent-skills` |
| 系统综述 | `systematic-literature-review` | `bytedance/deer-flow` |
| 论文检索 | `paper-lookup` | `K-Dense-AI/scientific-agent-skills` |
| 单篇论文理解 | `academic-paper-review` | `bytedance/deer-flow` |
| 科学批判性思维 | `scientific-critical-thinking` | `K-Dense-AI/scientific-agent-skills` |
| 论文绘图 | `academic-plotting` | `Orchestra-Research/AI-Research-SKILLs` |
| 统计分析 | `statistical-analysis` | `K-Dense-AI/scientific-agent-skills` |
| 科学写作 | `scientific-writing` | `K-Dense-AI/scientific-agent-skills` |
| 同行评审 | `peer-review` | `K-Dense-AI/scientific-agent-skills` |
| 投稿准备度评估 | `scholar-evaluation` | `K-Dense-AI/scientific-agent-skills` |

## 不会自动下载的项目

以下名称来自功能规划或本地定制，目前没有在清单中确认到可直接复用的公开上游 `SKILL.md`，因此安装器会明确跳过，而不会用同名文件冒充：

- `citation-verification`
- `reference-management`
- `exemplar-paper-analysis`
- `writing-pattern-extraction`
- `imitation-writing-practice`
- `scientific-data-analysis`
- `paper-figure`
- `paper-writing`
- `academic-language-polishing`
- `journal-selection`
- `submission-and-peer-review`

`documents` 由 Codex 桌面版/运行时提供，不作为普通 GitHub Skill 下载。

完整机器可读清单见 [`skills-manifest.json`](./skills-manifest.json)。

## 安全与来源

- 安装前可以先打开 `install.ps1` 或 `install.sh` 审查。
- 安装器使用 Git 稀疏检出，只复制目标 Skill 目录，不克隆无关大文件到安装目录。
- 每个 Skill 的许可证和依赖以其上游仓库中的文件为准。
- 本仓库只聚合安装方式，不宣称拥有上游 Skill 的版权。
