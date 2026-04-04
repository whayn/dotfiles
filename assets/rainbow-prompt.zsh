# Enable dynamic prompt substitution
setopt PROMPT_SUBST
zmodload zsh/mathfunc

build_rainbow_prompt() {
  local raw_text="${USER:-$USERNAME}@${HOST%%.*}:${PWD/#$HOME/~} > "
  local new_prompt=""
  local len=${#raw_text}
  (( len == 0 )) && len=1

  # Spread the rainbow spectrum across the entire string length
  local freq=$(( 6.28318 / len ))

  for (( i=0; i < len; i++ )); do
    local char="${raw_text:$i:1}"

    # Calculate smooth RGB values using sine waves offset by 120 degrees (2pi/3)
    local r=$(( int(sin(freq * i + 0) * 127 + 128) ))
    local g=$(( int(sin(freq * i + 2.0944) * 127 + 128) ))
    local b=$(( int(sin(freq * i + 4.1888) * 127 + 128) ))

    # Format directly as a zsh truecolor code %F{#RRGGBB}
    # Using printf -v avoids subshell performance penalties
    local hex
    printf -v hex "%%F{#%02x%02x%02x}" $r $g $b
    new_prompt+="${hex}${char}"
  done

  PROMPT="${new_prompt}%f"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd build_rainbow_prompt
