function stats --description 'Show stats for a file or directory' --argument-names file
    if test -z -- "$file"
        echo "Usage: stats <file or directory>" >&2
        return 1
    end
    if not test -e -- "$file"
        echo "File or directory '$file' does not exist.">&2
        return 1
    end
    if not test -r -- "$file"
        echo "File or directory '$file' is not readable." >&2
        return 1
    end

    # Logic to show stats
    if test -d -- "$file"
        echo "Nombre d’entrées dans le répertoire $file :"
        echo "$(ls -a -l -- $file | wc -l)"
    else if test -f -- "$file"
        echo "Nombre de lignes dans le fichier :"
        echo $(wc -l -- $file)
    else
        echo "Type de fichier non supporté" >&2
        return 1
    end
end
