#!/bin/sh

# Copyright (c) 2023 Ralf Grawunder

cd "$(dirname "$(readlink -m "${0}";)";)" || exit 1;
[ -f config.sh ] && . ./config.sh || . ./config.dist.sh;

dir_flash_print="$(readlink -m "${dir_flash_print}";)";
dir_dedicated="$(readlink -m "${dir_dedicated}";)";

[ -d "${dir_flash_print}" ] && mkdir -vp "${dir_dedicated}" || exit 1;

ext=".cfg";

normalize_configurations() {
    local folder="${dir_dedicated}/${1}";

    [ -d "${folder}" ] &&
    find "${folder}/"*"${ext}" -type f -regextype posix-extended ! -regex ".+/${2}\\${ext}$" | while read file; do
        sed -Ei "s/(profileName=).*/\1$(basename "${file}" "${ext}" | cut -d_ -f3-;)/" "${file}";
    done;
}

find "${dir_dedicated}/"* -maxdepth 0 -type d -printf "%f\n" | while read folder; do
    folder_backup="${dir_flash_print}/${folder}";

    [ ! -L "${folder_backup}" ] &&
    mv -vf "${folder_backup}" "${dir_dedicated}" && ln -vs "${dir_dedicated}/${folder}" "${dir_flash_print}";
done;

normalize_configurations "slice_profile" "${exclude_slice_profile}";
