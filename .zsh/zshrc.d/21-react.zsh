#!/usr/bin/env zsh

function startcomponent() {
  capitalize() {
    local w=$1
    echo "$(tr '[:lower:]' '[:upper:]' <<< ${w:0:1})${w:1}"
  }

  getRelPath() {
    echo "${1}${1}${2}"
  }


  local name
  for name in "$@"
  do
    mkdir -p ${name}

    local js="${name}.js"
    local css="${name}.css"
    local index="index.js"

    local indexPath="${name}/${index}"
    local jsPath="${name}/${js}"
    local cssPath="${name}/${css}"

    local className=""

    touch $indexPath $jsPath $cssPath

    for part in $(tr "-" "\n" <<< $name)
    do
      part=$(capitalize $part)
      className="${className}${part}"
    done

    # at least it looks better(?) the eol
    indexTmpl() {
      echo "import ${className} from './${js}';"
      echo "export default ${className};"
    }
    indexTmpl >>$indexPath

    jsStatefulTmpl() {
      echo "import React from 'react';"
      echo "import './${css}';"
      echo
      echo
      echo "export default class ${className} extends React.Component {"
      echo "  render() {"
      echo "    return <span>${className} Component</span>"
      echo "  }"
      echo "}"
      echo
    }
    jsStatefulTmpl >>$jsPath

    
  done
}
