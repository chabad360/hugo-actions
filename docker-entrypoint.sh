#!/usr/bin/env sh
set -e

PLAIN='\033[0m'
BOLD='\033[1;37m'

if [ "${INPUT_HUGOVERSION}" ]; then
  echo -e "\n${BOLD}Downloading Hugo version ${INPUT_HUGOVERSION}.${PLAIN}"
  wget "https://github.com/gohugoio/hugo/releases/download/v$(echo "${INPUT_HUGOVERSION}" | grep -o  "[0-9]\+.[0-9]\+.[0-9]\+")/hugo_${INPUT_HUGOVERSION}_Linux-64bit.tar.gz"
  tar xzvf hugo*
  mv hugo /usr/bin/hugo
  rm hugo*
fi


echo -e "\n${BOLD}Versions:${PLAIN}"
echo -ne "${BOLD}Hugo: ${PLAIN}"
hugo version
echo -ne "${BOLD}Pygments: ${PLAIN}"
pygmentize -V
echo -ne "${BOLD}Asciidoctor: ${PLAIN}"
asciidoctor --version
echo -ne "${BOLD}PostCSS: ${PLAIN}"
postcss --version
echo -ne "${BOLD}Pandoc: ${PLAIN}"
pandoc -v

echo -e "\n${BOLD}Generating Site ${NAME} at commit ${GITHUB_SHA}.${PLAIN}"
hugo ${INPUT_ARGS} -d "${INPUT_BUILDPATH}"