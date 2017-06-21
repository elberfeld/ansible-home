#!/bin/bash

# Der SSH Key für den Server muss vorher erzeugt werden (ohne Passwort) mit:
#   ssh-keygen -t ed25519 -f /data/borgbackup/repo_sshkey

# Initialisierung des Borg Backup Archives

export BORG_PASSPHRASE="{{repo_passphrase}}"
export BORG_RSH="ssh -i /data/borgbackup/repo_sshkey"

borg init $1 $2 $3 --info --show-rc --remote-path borg1 --encryption=repokey {{repo_url}} 
