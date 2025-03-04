update push="true":
	#!/usr/bin/env bash
	set -euo pipefail

	dir="$(mktemp -d)"
	echo >&2 "[INFO] Grabbing compendium markdown..."
	git clone --depth 1 --branch backer git@github.com:SteelCompendium/data-md.git "$dir"
	(
		compendium_dir="$(pwd)"
		cd "$dir"
		echo >&2 "[INFO] Copying compendium markdown to website docs..."
		cp -R * "${compendium_dir}/docs"

		sha="$(git rev-parse --short HEAD)"
		echo >&2 "[INFO] Committing and pushing updates..."
		cd "$compendium_dir"
		git add docs/*
		git commit -am "Updates from compendium ($sha)"
		if [ "{{push}}" == "true" ]; then
			git push
		fi
	)
	echo >&2 "[INFO] Done!"
