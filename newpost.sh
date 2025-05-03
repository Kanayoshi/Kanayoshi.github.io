#!/bin/bash

# --- 初期設定 ---
mathjax=true
title=""
output_dir="post/test"  # デフォルトの出力先

# --- 引数のパース ---
while [[ $# -gt 0 ]]; do
  case "$1" in
    --mathjax)
      mathjax=true
      shift
      ;;
    --no-mathjax)
      mathjax=false
      shift
      ;;
    --dir)
      output_dir="$2"
      shift 2
      ;;
    *)
      if [ -z "$title" ]; then
        title="$1"
      fi
      shift
      ;;
  esac
done

# --- バリデーション ---
if [ -z "$title" ]; then
  echo "Usage: ./newpost.sh \"記事タイトル\" [--mathjax] [--dir 出力ディレクトリ]"
  exit 1
fi

# --- 記事ファイル名生成 ---
slug=$(echo "$title" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')
date=$(date '+%Y-%m-%d')
mkdir -p "$output_dir"
filename="${output_dir}/${date}-${slug}.md"

# --- Front Matter 書き込み ---
cat > "$filename" <<EOF
---
layout: default
title: "$title"
date: $date
EOF

if $mathjax; then
  echo "use_mathjax: true" >> "$filename"
else
  echo "# use_mathjax: true" >> "$filename"
fi

cat >> "$filename" <<EOF
# categories:
---

# $title

ここに本文を書きます。
EOF

echo "✅ 投稿作成完了: $filename"
