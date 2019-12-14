#!/bin/bash

# Algunos canales son inaccesibles desde el extranjero (24h por ejemplo) o durante emisiones restringidas (La 2, Antena3, ...). Que fallen puede ser normal
ignore_array=(
	La_1
	La_2
	24_Horas
	Neox_\(fallback\)
	Antena_3_\(fallback\)
	Nova_\(fallback\)
	Mega_\(fallback\)
	La_Sexta_\(fallback\)
	Teledeporte
	Neox
	Nova
	Mega
	Atreseries
	TV_Canaria
)


ffmpeg_ua() {
	ffprobe -user_agent "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:70.0) Gecko/20100101 Firefox/70.0" -timeout 10000000 -loglevel quiet -i "$1"
}

ffmpeg_wua() {
	ffprobe -timeout 10000000 -loglevel quiet -i "$1"
}

num_retries=3

exit_code=0

while read line; do
	name=$(echo $line | cut -d\| -f3 | sed 's/ /_/g')
	m3u8=$(echo $line | cut -d\| -f5 | cut -d\( -f2 | cut -d\) -f1)

	status="\e[92mVALID\e[0m"

	ec=1
	for it in $(seq 1 $num_retries); do
		# Some streams fail with/without UA
		if [[ $it -eq 1 ]]; then
			ffmpeg_ua "$m3u8"
		else
			ffmpeg_wua "$m3u8"
		fi
		
		if [[ $? -eq 0 ]]; then
			ec=0
			break
		fi
	done

	if [[ $ec -ne 0 ]]; then
		status="\e[93mPASSD\e[0m"
		
		if [[ ! " ${ignore_array[@]} " =~ " ${name} " ]]; then
    		status="\e[31mERROR\e[0m"
			exit_code=1
		fi
	fi
	
	echo -e "$status - $name"

done < <(cat README.md | sed -n '/canales hay/,/Agradecimientos/{/canales hay/b;/Agradecimientos/b;p}' | grep "^|<" |grep -v "^|:--" | grep -vi "^|Logo")

exit $exit_code
