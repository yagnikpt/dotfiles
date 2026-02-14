#!/bin/bash

pom() {
    # 1. Use existing env var or prompt user via gum
    local split="$POMO_SPLIT"
    if [ -z "$split" ]; then
        split=$(gum choose "25/5" "50/10" "all done" --header "Choose a pomodoro split.")
    fi

    # 2. Define durations based on selection
    case "$split" in
        "25/5")
            work="25m"
            break="5m"
            ;;
        "50/10")
            work="50m"
            break="10m"
            ;;
        "all done"|"")
            return
            ;;
    esac

    # 3. Work Phase: Run timer then notify on macOS
    timer "$work" && terminal-notifier -message "Pomodoro" \
        -title 'Work Timer is up! Take a Break 😊' \
        -sound Crystal

    # 4. Break Phase: Confirm readiness before starting break timer
    if gum confirm "Ready for a break?"; then
        timer "$break" && terminal-notifier -message "Pomodoro" \
            -title 'Break is over! Get back to work 😬' \
            -sound Crystal

        # Recursive call to start next cycle
        pom
    else
        # If break is declined, restart selection/pom
        pom
    fi
}
