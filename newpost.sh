#!/bin/bash

# --- 引数のパース ---
mathjax=false
title=""

for arg in "$@"; do
  case "$arg" in
    --mathjax)
      mathjax=true
      ;;
    --no-mathjax)
      mathjax=false
      ;;
    *)
      if [ -z "$title" ]; then
        title="$arg"
      fi
      ;;
  esac
done

# --- バリデーション ---
if [ -z "$title" ]; then
  echo "Usage: ./newpost.sh \"記事タイトル\" [--mathjax]"
  exit 1
fi

# --- 記事ファイル名生成 ---
slug=$(echo "$title" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')
date=$(date '+%Y-%m-%d')
filename="_post/test/${date}-${slug}.md"

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
