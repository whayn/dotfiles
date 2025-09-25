function starship-list-presets --description 'Print available starship presets (one per line)'
    set presets_dir "$HOME/.config/starship-presets"

    if not test -d "$presets_dir"
        echo "No presets directory: $presets_dir"
        return 1
    end

    set found 0
    for f in $presets_dir/*.toml
        if test -f "$f"
            set base (basename $f .toml)
            set_color green
            echo "  → $base"
            set_color normal
            set found 1
        end
    end

    if test $found -eq 0
        echo "(no .toml presets found in $presets_dir)"
        return 1
    end
end
