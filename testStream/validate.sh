#!/bin/bash

# Algunos canales son inaccesibles desde el extranjero (24h por ejemplo) o durante emisiones restringidas (La 2, Antena3, ...). Que fallen puede ser normal
ignore_array=(
	La_2
	24_Horas
	Neox_\(fallback\)
)


exit_code=0

while read line; do
	name=$(echo $line | cut -d\| -f3 | sed 's/ /_/g')
	m3u8=$(echo $line | cut -d\| -f5 | cut -d\( -f2 | cut -d\) -f1)

	status="\e[92mVALID\e[0m"
	ffprobe -loglevel quiet -i "$m3u8"
	if [[ $? -ne 0 ]]; then
		status="\e[93mPASSD\e[0m"
		
		if [[ ! " ${ignore_array[@]} " =~ " ${name} " ]]; then
    		status="\e[31mERROR\e[0m"
			exit_code=1
		fi
	fi
	
	echo -e "$status - $name"

done < <(cat README.md | sed -n '/canales hay/,/Agradecimientos/{/canales hay/b;/Agradecimientos/b;p}' | grep "^|<" |grep -v "^|:--" | grep -vi "^|Logo")

exit $exit_code
