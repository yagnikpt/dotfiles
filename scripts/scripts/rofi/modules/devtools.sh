#!/usr/bin/env bash

postgres="Quick PostgreSQL"
rows="$postgres"

run_postgres() {
    local rows_length=$(docker volume ls | awk 'NR>1{c++} END{print c+0}')
    local max_rows=$(( rows_length > 6 ? 6 : rows_length ))

    local docker_volumes=$(docker volume ls | awk 'NR>1{print $2}')
    local volume=$(echo -e "$docker_volumes" | rofi -dmenu -i -p "Volume" -theme ~/.config/rofi/modules/base_with_search.rasi -l $max_rows)

    if [ -z "$volume" ]; then
        exit 0
    fi

    docker run -d --rm \
        --name postgres \
        -e POSTGRES_USER=postgres \
        -e POSTGRES_PASSWORD=postgres \
        -e POSTGRES_DB=postgres \
        -p 5432:5432 \
        -v $volume:/var/lib/postgresql/data \
        postgres:17-trixie

    if [ $? -ne 0 ]; then
        notify-send -a "Postgres" "Error starting container."
    else
        wl-copy "postgresql://postgres:postgres@localhost:5432/postgres"

        notify-send -a "Postgres" "DB up and running. Connection URL copied to clipboard."
    fi
}

tool=$(echo -e $rows | rofi -dmenu -p "DevTools" -i -theme ~/.config/rofi/modules/base.rasi -l 1)

case "$tool" in
    $postgres)
        run_postgres
        ;;
    *)
        exit 0
esac
