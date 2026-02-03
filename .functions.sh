nix-search() {
nix search nixpkgs $1 --json | jq -r '.[] | "\(.pname): \(.description)"' | grep -i $1
}
lls() {
	ls -ah $1 | grep $2
}
nix-update() {
	nix profile upgrade --all --refresh --impure
}
nix-add() {
	nix profile add nixpkgs#"$1" --impure 
}
hytale() {
	#!/bin/zsh
	PLACEHOLDER=($(echo "$1" | tr ',' '\ '))
	WORLDSFIX=()
	WORLDSSAVE=()
	if ! [ $1 = all ]; then
	for f in "${PLACEHOLDER[@]}"; do
		WORLDSSAVE+=(~/.var/app/com.hypixel.HytaleLauncher/data/Hytale/UserData/Saves/"$f")
		WORLDSFIX+=(~/important/hytale-backups/backup-LATEST/"$f")
	done
else
	WORLDSSAVE+=(~/.var/app/com.hypixel.HytaleLauncher/data/Hytale/UserData/Saves/*)
	WORLDSFIX+=(~/important/hytale-backups/backup-LATEST/*)
	
	fi
	if [ $2 = fix ]; then
	cp -r "${WORLDSFIX[@]}" ~/.var/app/com.hypixel.HytaleLauncher/data/Hytale/UserData/Saves/
elif [ $1 = save ]; then
	cp -r ~/.var/app/com.hypixel.HytaleLauncher/data/Hytale/UserData/Saves/* ~/important/hytale-backups/backup-OUTDATED/
	mv ~/important/hytale-backups/backup-OUTDATED ~/important/hytale-backups/placeholder
	mv ~/important/hytale-backups/backup-LATEST ~/important/hytale-backups/backup-OUTDATED
	mv ~/important/hytale-backups/placeholder ~/important/hytale-backups/backup-LATEST
	exit
elif [ $1 = fix ]; then
	cp -r ~/important/hytale-backups/backup-LATEST/* ~/.var/app/com.hypixel.HytaleLauncher/data/Hytale/UserData/Saves/
	exit
elif [[ $1 = "" ]]; then
	flatpak run com.hypixel.HytaleLauncher & disown
	exit
	fi
	pkill gslapper
	flatpak run com.hypixel.HytaleLauncher & disown
	sleep 300
	while true; do
	time=0
	cp -r "${WORLDSSAVE[@]}" ~/important/hytale-backups/backup-OUTDATED/
	mv ~/important/hytale-backups/backup-OUTDATED ~/important/hytale-backups/placeholder
	mv ~/important/hytale-backups/backup-LATEST ~/important/hytale-backups/backup-OUTDATED
	mv ~/important/hytale-backups/placeholder ~/important/hytale-backups/backup-LATEST
	until [ "$time" -eq "30" ]; do
		sleep 10
		if ! pkill -0 HytaleClient; then
			cp -r "${WORLDSSAVE[@]}" ~/important/hytale-backups/backup-OUTDATED/
			mv ~/important/hytale-backups/backup-OUTDATED ~/important/hytale-backups/placeholder
			mv ~/important/hytale-backups/backup-LATEST ~/important/hytale-backups/backup-OUTDATED
			mv ~/important/hytale-backups/placeholder ~/important/hytale-backups/backup-LATEST
			exit
		else
			(( time += 1 ))
		fi
	done
done
}
