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

    # Calculate RGB values.
    # Using a higher amplitude (200) and clamping pushes colors to the edges
    # of the color space, eliminating the "muddy/gray" transition colors.
    local r=$(( int(sin(freq * i + 0) * 200 + 128) ))
    local g=$(( int(sin(freq * i + 2.0944) * 200 + 128) ))
    local b=$(( int(sin(freq * i + 4.1888) * 200 + 128) ))

    # Clamp to 0-255
    (( r = r > 255 ? 255 : (r < 0 ? 0 : r) ))
    (( g = g > 255 ? 255 : (g < 0 ? 0 : g) ))
    (( b = b > 255 ? 255 : (b < 0 ? 0 : b) ))

    # Format directly as a zsh truecolor code %F{#RRGGBB}
    # Using pure zsh parameter expansion instead of printf to avoid the printing bug
    local hex="%F{#${(l:2::0:)$(([##16]r))}${(l:2::0:)$(([##16]g))}${(l:2::0:)$(([##16]b))}}"
    new_prompt+="${hex}${char}"
  done

  # %f resets color.
  # %{\e[5 q%} sets the cursor to a blinking bar (use 1 q for blinking block).
  PROMPT="${new_prompt}%f"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd build_rainbow_prompt
