#!/usr/bin/env bash
# LaTeX package install script
# Author: Xu Cheng

command_exists () {
    type "$1" &> /dev/null ;
}

if ! command_exists realpath ; then
    if command_exists grealpath ; then
        realpath() {
            grealpath "$1"
        }
    else
        realpath() {
            [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
        }
    fi
fi

SCRIPT_PATH=$(realpath $(cd $(dirname $0);pwd))
cd $SCRIPT_PATH/..

TEXMFLOCAL=`kpsewhich --var-value=TEXMFLOCAL | awk -v RS="" -v FS="[\r\n]" '{print $1}' `

install(){
echo "Install hustproposal.cls template into local."
mkdir -p "${TEXMFLOCAL}/tex/latex/hustproposal/"
cp -f ./hustproposal/hustproposal.cls "${TEXMFLOCAL}/tex/latex/hustproposal/"
mkdir -p "${TEXMFLOCAL}/doc/latex/hustproposal/"
cp -f ./hustproposal/hustproposal.pdf "${TEXMFLOCAL}/doc/latex/hustproposal/"
mkdir -p "${TEXMFLOCAL}/doc/latex/hustproposal/example/"
cp -f ./hustproposal/hustproposal-zh-example.pdf "${TEXMFLOCAL}/doc/latex/hustproposal/example/"
cp -f ./hustproposal/hustproposal-zh-example.tex "${TEXMFLOCAL}/doc/latex/hustproposal/example/"
cp -f ./hustproposal/hustproposal-en-example.pdf "${TEXMFLOCAL}/doc/latex/hustproposal/example/"
cp -f ./hustproposal/hustproposal-en-example.tex "${TEXMFLOCAL}/doc/latex/hustproposal/example/"
cp -f ./hustproposal/ref-example.bib "${TEXMFLOCAL}/doc/latex/hustproposal/example/"
hash
}

uninstall(){
echo "Uninstall hustproposal.cls template."
rm -rf "${TEXMFLOCAL}/tex/latex/hustproposal/"
rm -rf "${TEXMFLOCAL}/doc/latex/hustproposal/"
hash
}

hash(){
echo "Refresh TeX hash database."
texhash
}

help(){
echo "Usage:"
echo " $(basename $0) install          - install hustproposal.cls template into local."
echo " $(basename $0) uninstall        - uninstall hustproposal.cls template."
echo ""
}

if [[ $1 = "install" ]]; then
    install
elif [[ $1 = "uninstall" ]]; then
    uninstall
else
    help
fi
