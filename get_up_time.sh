#!/bin/bash

urls="https://profile.intra.42.fr/users/me  https://elearning.intra.42.fr/ https://projects.intra.42.fr/ https://companies.intra.42.fr/en/users/smaccary https://api.intra.42.fr/apidoc https://meta.intra.42.fr/ https://shop.intra.42.fr/ https://signin.intra.42.fr/legal/terms/3 https://cdn.intra.42.fr/pdf/pdf/32062/fr.subject.pdf https://adm.42.fr/ https://admissions.42.fr/"
mkdir -p up down
for url in $urls;do
	domain_name=$(echo $url | cut -d/ -f3)
	status_code=$(curl -L -s -b cookies.txt -I "$url" -o /dev/null -w "%{http_code}")
	#if request returned an error
	if [ $? -eq 0 ] && [ "$status_code" -eq 200 ]; then
		rm -f down/$domain_name
		#if up/domain_name doesn't exist
		if [ ! -f up/$domain_name ]; then
			date > up/$domain_name
		fi
		last_date=$(cat up/$domain_name)
		printf "[%s] %30s is %-4s since %s\n" "OK" "$domain_name" "up" "$last_date" 
	else
		rm -f up/$domain_name
		#if down/domain_name doesn't exist
		if [ ! -f down/$domain_name ]; then
			date > down/$domain_name
		fi
		last_date=$(cat down/$domain_name)
		printf "[%s] %30s is %-4s since %s  /!\\ [%s] /!\\ \n" "KO" "$domain_name" "down" "$last_date" "$status_code"
	fi
done