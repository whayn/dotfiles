function backup --description 'Create a file backup' --argument-names original
    if not set -q -- "$original"
            echo "Usage: backup <file>" >&2
            return 1
    end

    if not test -e -- "$original"
        echo "File '$original' does not exist." >&2
        return 1
    end

    if not test -f -- "$original"
        echo "'$original' is not a regular file." >&2
        return 1
    end

    if not test -r -- "$original"
        echo "File '$original' is not readable." >&2
        return 1
    end

    set -l bak "$original.bak"

    if test -e -- "$bak"
        echo "Backup file '$bak' already exists. Aborting to prevent overwrite." >&2
        return 1
    end


    command cp -p -- "$original" "$bak"
    and echo "Backup created: $bak"
    or begin
        echo "Failed to create backup for '$original'." >&2
        return 1
    end
end
