#! /bin/bash

WALLPAPER_DIR="$HOME/dotfiles/wallpapers"

if [[ ! -d "$WALLPAPER_DIR" ]]; then
    echo "diretório dos wallpapers não encontrado"
    exit 1
fi

mapfile -t images < <(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \))

if [[ ${#images[@]} -eq 0 ]]; then
    echo "nenhum wallpaper encontado"
    exit 1
fi

option=$(printf "%s\n" "${images[@]##*/}" | rofi -dmenu -p "wallpapers")

if [[ -z "$option" ]]; then
    echo "nenhum wallpaper selecionado"
    exit 0
fi

for img in "${images[@]}"; do
    if [[ "${img##*/}" == "$option" ]]; then
        image_path="$img"
        break
    fi
done

if [[ -z "$image_path" ]]; then
    echo "erro ao localizar arquivo escolhido"
    exit 1
fi

echo "selecionado $image_path"

hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$image_path"

for mon in $(hyprctl monitors | awk '/Monitor/ {print $2}'); do
    hyprctl hyprpaper wallpaper "$mon, $image_path"
done
