#!/bin/bash

urls="https://profile.intra.42.fr/users/me  https://elearning.intra.42.fr/ https://projects.intra.42.fr/ https://companies.intra.42.fr/en/users/smaccary https://api.intra.42.fr/apidoc https://meta.intra.42.fr/ https://shop.intra.42.fr/ https://signin.intra.42.fr/legal/terms/3 https://cdn.intra.42.fr/pdf/pdf/32062/fr.subject.pdf https://adm.42.fr/ https://admissions.42.fr/"

for url in $urls;do
	domain_name=$(echo $url | cut -d/ -f3)
	status_code=$(curl -L -s -b cookies.txt -I "$url" -o /dev/null -w "%{http_code}")
	#if request returned an error
	if [ $? -eq 0 ] && [ "$status_code" -eq 200 ]; then
		echo "[OK] $domain_name is up"
	else
		echo "[KO] $domain_name is down [$status_code] /!\\"
	fi
done