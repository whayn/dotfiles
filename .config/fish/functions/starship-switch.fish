function starship-switch --description 'Switch between starship themes' --argument-names theme
    set presets_dir "$HOME/.config/starship-presets"

    if test -z "$theme"
        echo "Usage: starship-switch <preset-name>"
        echo "Available presets:"
        starship-list-presets
        return 1
    end

    set src "$presets_dir/$theme.toml"
    if not test -f "$src"
        echo "No such preset: '$theme'"
        echo "Available presets:"
        starship-list-presets
        return 1
    end

    set -Ux STARSHIP_CONFIG $src
    echo "Switched starship theme to $theme"

    # Reload starship config
    starship init fish | source
end
