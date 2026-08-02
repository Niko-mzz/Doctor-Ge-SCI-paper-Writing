# Doctor Ge SCI-paper-Writing

《Codex SCI 论文写作 Skills》配套的一键安装仓库。Word 文档中的 **22 个 Skills 已全部纳入安装器**：其中 12 个随本仓库提供，10 个在安装时从原作者的公开 GitHub 仓库获取。

## 一键安装全部 22 个 Skills

### Windows PowerShell

```powershell
irm https://raw.githubusercontent.com/Niko-mzz/Doctor-Ge-SCI-paper-Writing/main/install.ps1 | iex
```

覆盖已有同名 Skill：

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

## Word 文档中的全部 Skills

| 序号 | Skill | 主要用途 | 安装来源 |
|---:|---|---|---|
| 1 | `literature-review` | 文献检索、筛选与综述 | K-Dense |
| 2 | `citation-verification` | 核验引用真实性与论述对应关系 | 本仓库 |
| 3 | `reference-management` | 整理、去重和转换参考文献 | 本仓库 |
| 4 | `systematic-literature-review` | 系统综述与统一引用 | DeerFlow |
| 5 | `paper-lookup` | 查找论文与元数据 | K-Dense |
| 6 | `academic-paper-review` | 阅读并解析单篇论文 | DeerFlow |
| 7 | `scientific-critical-thinking` | 评估证据、论证与研究局限 | K-Dense |
| 8 | `exemplar-paper-analysis` | 拆解范文结构和写作策略 | 本仓库 |
| 9 | `writing-pattern-extraction` | 提取可迁移的论文写作模式 | 本仓库 |
| 10 | `imitation-writing-practice` | 基于范文练习科研表达 | 本仓库 |
| 11 | `scientific-data-analysis` | 清洗、分析实验数据并记录流程 | 本仓库 |
| 12 | `academic-plotting` | 生成论文级科研图表 | Orchestra Research |
| 13 | `paper-figure` | 创建、优化和检查 SCI 论文图片 | 本仓库 |
| 14 | `statistical-analysis` | 统计检验、效应量与功效分析 | K-Dense |
| 15 | `paper-writing` | SCI/EI 论文撰写与修订 | 本仓库 |
| 16 | `academic-language-polishing` | 学术语言润色与术语统一 | 本仓库 |
| 17 | `scientific-writing` | 科学论文结构化写作 | K-Dense |
| 18 | `documents` | 创建、编辑和检查 Word 文档 | 本仓库 |
| 19 | `journal-selection` | 期刊匹配和候选排序 | 本仓库 |
| 20 | `submission-and-peer-review` | 投稿材料与审稿回复准备 | 本仓库 |
| 21 | `peer-review` | 模拟同行评审并提出修改意见 | K-Dense |
| 22 | `scholar-evaluation` | 评估论文与投稿准备度 | K-Dense |

完整机器可读清单见 [`skills-manifest.json`](./skills-manifest.json)。

## 安装器行为

- 需要本机已安装 `Git`。
- 默认保留已经存在的同名 Skill；使用 `-Force` 或 `--force` 才会覆盖。
- 使用 Git 稀疏检出，只获取所需 Skill 目录。
- 每个复制到目标目录的 Skill 都必须包含 `SKILL.md`，否则安装立即报错。
- 上游项目的许可证与使用条件以各自仓库为准。
