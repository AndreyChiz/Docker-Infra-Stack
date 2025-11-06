#!/bin/bash
set -e

# Basic support for passing the db password as a mounted file. Or any other KC_ variable,
# really.
# Looks up environment variables like KC_*_FILE, reads the specified file and exports
# the content to KC_*
# e.g. KC_DB_PASSWORD_FILE -> KC_DB_PASSWORD

lines=$(printenv | grep -o KC_.*_FILE)
vars=($lines)

for var in ${vars[@]}; do
    outvar="${var%_FILE}"
    file="${!var}"

    if [[ -z $file ]]; then
        echo "WARN: $var specified but empty"
        continue
    fi

    if [[ -e $file ]]; then
        content=$(cat "$file")
        if [[ -n $content ]]; then
            export $outvar=$content
            echo "INFO: exported $outvar from $var"
        else
            echo "WARN: $var -> $file is empty"
        fi
    else
        echo "ERR: $var -> file '$file' not found"
        exit 1
    fi
done

exec /opt/keycloak/bin/kc.sh start "$@"
