#!/usr/bin/env bash
set -euo pipefail

DESTINATION="${CODEX_HOME:-$HOME/.codex}/skills"
FORCE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --destination) DESTINATION="$2"; shift 2 ;;
    --force) FORCE=1; shift ;;
    *) echo "未知参数: $1" >&2; exit 2 ;;
  esac
done

command -v git >/dev/null 2>&1 || { echo "未找到 git，请先安装 Git。" >&2; exit 1; }
mkdir -p "$DESTINATION"
TMP_ROOT="$(mktemp -d)"
trap 'rm -rf "$TMP_ROOT"' EXIT

install_group() {
  local repo="$1"; shift
  local checkout="$TMP_ROOT/$(basename "$repo" .git)"
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
      echo "警告：上游路径不存在，跳过 $name" >&2
      continue
    fi
    if [[ -e "$target" && "$FORCE" -ne 1 ]]; then
      echo "跳过已存在：$name（使用 --force 可覆盖）"
      continue
    fi
    [[ -e "$target" ]] && rm -rf "$target"
    cp -R "$source" "$target"
    echo "已安装：$name"
  done
}

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

echo ""
echo "完成。请重启 Codex 以加载新 Skills。"
echo "安装目录：$DESTINATION"
echo "注意：清单中没有已验证公开来源的规划型 Skill 不会被本脚本安装。"
