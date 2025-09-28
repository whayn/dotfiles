function pomo --argument-names time message --description 'Pomodoro timer that sends a notification after a set number of minutes with a custom message'
    # Require at least two args: minutes and a message
    if test -z "$time" -o -z "$message"
        echo "Usage: pomo <minutes> <message> — Example: pomo 15 Take a break"
        return 1
    end

    # If there are more than two positional args, append them to message
    if test (count $argv) -gt 2
        set message (string join ' ' $message $argv[3..-1])
    end

    # Validate integer minutes
    if not string match -r '^[0-9]+$' -- $time
        echo "Minutes must be an integer. Example: pomo 15 Take a break"
        return 1
    end

    # Convert minutes to seconds (Fish 3+)
    set sec (math "$time * 60")

    echo "First break will be at (time (math "$sec + (date +%s)") +%H:%M)."

    while true
        sleep $sec
        echo $message
        notify-send -u critical -- $message
        sleep (math "5 * 60") # 5 minute break
        echo "Break over. Back to work!"
        notify-send -u normal -- "Break over. Back to work!"
    end
end
