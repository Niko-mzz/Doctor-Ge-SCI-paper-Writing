#!/usr/bin/env bash
set -euo pipefail

DESTINATION="${CODEX_HOME:-$HOME/.codex}/skills"
FORCE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --destination) DESTINATION="$2"; shift 2 ;;
    --force) FORCE=1; shift ;;
    *) echo "未知参数：$1" >&2; exit 2 ;;
  esac
done

command -v git >/dev/null 2>&1 || { echo "未找到 Git，请先安装 Git。" >&2; exit 1; }
mkdir -p "$DESTINATION"
TMP_ROOT="$(mktemp -d)"
trap 'rm -rf "$TMP_ROOT"' EXIT
READY=0
GROUP_INDEX=0

install_group() {
  local repo="$1"; shift
  local checkout="$TMP_ROOT/repo-$GROUP_INDEX"
  GROUP_INDEX=$((GROUP_INDEX + 1))
  echo ""
  echo "获取 $repo"
  git clone --depth 1 --filter=blob:none --sparse "$repo" "$checkout"

  local paths=()
  local pair
  for pair in "$@"; do paths+=("${pair%%::*}"); done
  git -C "$checkout" sparse-checkout set --no-cone "${paths[@]}"

  for pair in "$@"; do
    local path="${pair%%::*}"
    local name="${pair##*::}"
    local source="$checkout/$path"
    local target="$DESTINATION/$name"
    if [[ ! -f "$source/SKILL.md" ]]; then
      echo "缺少 SKILL.md：$name（$path）" >&2
      exit 1
    fi
    if [[ -e "$target" && "$FORCE" -ne 1 ]]; then
      echo "已存在，保留：$name"
      READY=$((READY + 1))
      continue
    fi
    [[ -e "$target" ]] && rm -rf "$target"
    cp -R "$source" "$target"
    [[ -f "$target/SKILL.md" ]] || { echo "安装校验失败：$name" >&2; exit 1; }
    READY=$((READY + 1))
    echo "已安装：$name"
  done
}

install_group "https://github.com/Niko-mzz/Doctor-Ge-SCI-paper-Writing.git" \
  "skills/citation-verification::citation-verification" \
  "skills/reference-management::reference-management" \
  "skills/exemplar-paper-analysis::exemplar-paper-analysis" \
  "skills/writing-pattern-extraction::writing-pattern-extraction" \
  "skills/imitation-writing-practice::imitation-writing-practice" \
  "skills/scientific-data-analysis::scientific-data-analysis" \
  "skills/paper-figure::paper-figure" \
  "skills/paper-writing::paper-writing" \
  "skills/academic-language-polishing::academic-language-polishing" \
  "skills/documents::documents" \
  "skills/journal-selection::journal-selection" \
  "skills/submission-and-peer-review::submission-and-peer-review"

install_group "https://github.com/K-Dense-AI/scientific-agent-skills.git" \
  "skills/literature-review::literature-review" \
  "skills/paper-lookup::paper-lookup" \
  "skills/scientific-critical-thinking::scientific-critical-thinking" \
  "skills/statistical-analysis::statistical-analysis" \
  "skills/scientific-writing::scientific-writing" \
  "skills/peer-review::peer-review" \
  "skills/scholar-evaluation::scholar-evaluation"

install_group "https://github.com/bytedance/deer-flow.git" \
  "skills/public/systematic-literature-review::systematic-literature-review" \
  "skills/public/academic-paper-review::academic-paper-review"

install_group "https://github.com/Orchestra-Research/AI-Research-SKILLs.git" \
  "20-ml-paper-writing/academic-plotting::academic-plotting"

[[ "$READY" -eq 22 ]] || { echo "安装未完成：当前就绪 $READY/22 个 Skills。" >&2; exit 1; }
echo ""
echo "完成：Word 文档中的 22/22 个 Skills 均已就绪。"
echo "安装目录：$DESTINATION"
echo "请重启 Codex 以加载新 Skills。"
