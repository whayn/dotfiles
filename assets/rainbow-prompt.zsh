# Enable dynamic prompt substitution
setopt PROMPT_SUBST

build_rainbow_prompt() {
  local raw_text="${USERNAME}@${HOST%%.*}:${PWD/#$HOME/~} > "
  local colors=(red yellow green cyan blue magenta)
  local new_prompt=""

  for (( i=0; i < ${#raw_text}; i++ )); do
    local char="${raw_text:$i:1}"
    local color="${colors[((i % 6) + 1)]}"
    new_prompt+="%F{${color}}${char}"
  done

  PROMPT="${new_prompt}%f"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd build_rainbow_prompt
