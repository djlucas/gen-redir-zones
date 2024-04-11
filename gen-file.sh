#!/bin/bash
if test "${server}" == ""; then
    echo "Please set a value for 'server' in the environment or on the cli."
    exit 1
fi

mkdir redir

if test "${list}" != ""; then
    if test -f "${list}"; then
        mkdir "redir/${list%.*}"
        for domain in `cat ${list}`; do
            sed -e "s@gen\.com@${domain}@g" \
                -e "s@server\.example\.com@${server}@g" \
                gen.zone > "redir/${list%.*}/${domain}.zone"
            echo -e "zone \"${domain}\" IN {" >> "redir/${list%.*}/${list%.*}.conf"
            echo -e "\ttype master;" >> "redir/${list%.*}/${list%.*}.conf"
            echo -e "\tfile \"redir/${list%.*}/${domain}.zone\";" >> "redir/${list%.*}/${list%.*}.conf"
            echo -e "};\n" >> "redir/${list%.*}/${list%.*}.conf" 
        done
    else
        echo "No file ${list}!"
	exit 1
    fi

else
    for list in *.txt; do
        mkdir "redir/${list%.*}"
        for domain in `cat ${list}`; do
            sed -e "s@gen\.com@${domain}@g" \
                -e "s@server\.example\.com@${server}@g" \
                gen.zone > "redir/${list%.*}/${domain}.zone"
            echo -e "zone \"${domain}\" IN {" >> "redir/${list%.*}/${list%.*}.conf"
            echo -e "\ttype master;" >> "redir/${list%.*}/${list%.*}.conf"
            echo -e "\tfile \"redir/${list%.*}/${domain}.zone\";" >> "redir/${list%.*}/${list%.*}.conf"
            echo -e "};\n" >> "redir/${list%.*}/${list%.*}.conf"
	done
    done
fi

