#!/bin/env bash

declare -A BROWSERS=(
    [Helium]="helium-browser-bin"
    [Chrome]="google-chrome-stable"
    [Brave]="brave-origin-stable"
)

create_web_app() {
    local name="$1"
    local url="$2"
    local icon="$3"
    local browser="$4"
    local incognito="$5"
    local comment="$6:-Web App"
    local id=$(printf "%04d\n" $((RANDOM % 10000)))
    local browser_bin_name="${BROWSERS["$browser"]}"

    local incognito_param=""
    if [[ "$incognito" == "true" ]]; then
        incognito_param="--incognito"
    fi
    local private_window="false"
    if [[ "$incognito" == "true" ]]; then
        private_window="true"
    fi

    # Resolve home directory expansion for the redirect
    local dest_dir
    eval dest_dir="~/.local/share/applications"
    mkdir -p "$dest_dir"
    local file_name="${dest_dir}/WebApp-${name}${id}.desktop"
    file_name="${file_name//[[:space:]]/}"

    cat <<EOF >"$file_name"
[Desktop Entry]
Version=1.0
Name=${name}
Comment=${comment}
Exec=${browser_bin_name} --app="${url}" --class=WebApp-${name}${id} --name=WebApp-${name}${id} ${incognito_param}
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=${icon}
Categories=GTK;WebApps;
MimeType=text/html;text/xml;application/xhtml_xml;
StartupWMClass=WebApp-${name}${id}
StartupNotify=true
X-WebApp-Browser=${browser}
X-WebApp-URL=${url}
X-WebApp-CustomParameters=
X-WebApp-Navbar=false
X-WebApp-PrivateWindow=${private_window}
X-WebApp-Isolated=false
EOF

    echo "Created: $file_name"
}

input_web_app() {
    local name=$(gum input --placeholder "Enter name...")
    local url=$(gum input --placeholder "Enter url...")
    echo "Choose an icon"
    local icon=$(zenity --file-selection --title="Choose an icon" --filename=$HOME/.local/share/icons/)
    echo "$icon"
    local browser=$(gum choose "${!BROWSERS[@]}")
    local incognito=$(gum choose "No" "Yes" --header "Incognito?" | grep -q "Yes" && echo "true" || echo "false")
    local comment=$(gum input --placeholder "Enter comment...")

    create_web_app "$name" "$url" "$icon" "$browser" "$incognito" "$comment"
}

delete_web_app() {
    local dest_dir
    eval dest_dir="~/.local/share/applications"

    # Find all desktop files matching WebApp-*.desktop
    local files=()
    while IFS= read -r -d '' file; do
        files+=("$file")
    done < <(find "$dest_dir" -maxdepth 1 -name "WebApp-*.desktop" -print0 2>/dev/null)

    if [[ ${#files[@]} -eq 0 ]]; then
        echo "No web apps found to delete."
        return
    fi

    # Prepare display list (just filenames for user-friendly display)
    local display_names=()
    for file in "${files[@]}"; do
        display_names+=("$(basename "$file")")
    done

    # Let user choose which to delete using gum choose
    local chosen_display
    chosen_display=$(printf "%s\n" "${display_names[@]}" | gum choose --header "Select a Web App to delete:")

    if [[ -n "$chosen_display" ]]; then
        local chosen_file="${dest_dir}/${chosen_display}"
        if [[ -f "$chosen_file" ]]; then
            rm "$chosen_file"
            echo "Deleted: $chosen_display"
        else
            echo "File not found: $chosen_display"
        fi
    fi
}

main() {
    figlet "Web Apps" | lolcat -g d7a657:d4be98

    while true; do
        local choice
        choice=$(gum choose "New" "Delete" "Exit")
        case "$choice" in
        "New")
            input_web_app
            ;;
        "Delete")
            delete_web_app
            ;;
        "Exit" | *)
            echo "Exiting..."
            exit 0
            ;;
        esac
    done
}

main
