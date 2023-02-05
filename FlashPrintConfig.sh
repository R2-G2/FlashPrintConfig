#!/bin/sh

# Copyright (c) 2023 Ralf Grawunder

cd "$(dirname "$(readlink -m "${0}";)";)" || exit 1;
[ -f config.sh ] && . ./config.sh || . ./config.dist.sh;

dir_flash_print="$(readlink -m "${dir_flash_print}";)";
dir_dedicated="$(readlink -m "${dir_dedicated}";)";

[ -d "${dir_flash_print}" ] && mkdir -vp "${dir_dedicated}" || exit 1;

ext=".cfg";

maintain_settings() {
    local folder_flash_print="${dir_flash_print}/${1}";
    local folder_dedicated="${dir_dedicated}/${1}";

    [ ! -L "${folder_flash_print}" ] &&
    cp -vrf "${folder_flash_print}" "${dir_dedicated}" && rm -vrf "${folder_flash_print}" &&
    ln -vs "${folder_dedicated}" "${dir_flash_print}";

    [ true = ${2} ] &&
    find "${folder_dedicated}/"*"${ext}" -type f -regextype posix-extended ! -regex ".+/${3}\\${ext}$" |
    while read file; do
        sed -Ei "s/(profileName=).*/\1$(basename "${file}" "${ext}" | cut -d_ -f3-;)/" "${file}";
    done;
}

maintain_settings "slice_profile" true "${exclude_slice_profile}";
maintain_settings "slice_profile_def" false;
