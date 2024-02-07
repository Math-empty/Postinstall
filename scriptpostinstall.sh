#!/bin/bash
echo "Mise a jour des depots, installation de Tixeo"

echo "deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware" | sudo tee /etc/apt/sources.list

#Mise a jour des depots
sudo apt update -y && apt full-upgrade -y

#Modification du nom de version Linux
sed -i 's/VERSION_CODENAME=kali-rolling/VERSION_CODENAME=bullseye/' /usr/lib/os-release

#Telechargements des depots Tixeo
wget -qO - https://repos.tixeo.com/tixeorepos.gpg.key | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/tixeo-archive.gpg

#Ajout des depots Tixeo au systeme
echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/tixeo-archive.gpg] https://repos.tixeo.com/debian $(lsb_release -cs) non-free" | sudo tee /etc/apt/sources.list.d/tixeo.list

#Mise a jour des depots avec les nouveaux parametres et installation de Tixeo
sudo apt-get update -y
sudo apt-get install tixeoclient libreoffice terminator -y

#Mise a jour du 10 Janvier 2024
# Pour faire le ménage au cas où avant d’installer les nouveaux pilotes :
sudo apt purge nvidia*
# Installer les nouveaux driver 
sudo apt install nvidia-driver -y
#Ajout des binaires nécéssaires a fwup
sudo apt install fwupd-signed && sudo apt install fwupd-unsigned
# Regarder si la carte graphique apparait dans les périphériques (Nvidia RTX A500) 
sudo fwupdmgr get-devices | grep 500
# Si elle n’apparait pas, mettre à jour via fwupdmgr et réafficher les périphériques
sudo fwupdmgr refresh
sudo fwupdmgr get-updates
sudo fwupdmgr update
sudo fwupdmgr get-devices | grep 500
#####################################################################################

#Retour par defaut de la version du systeme (si necessaire decommenter la ligne)
sed -i 's/VERSION_CODENAME=bullseye/VERSION_CODENAME=kali-rolling/' /usr/lib/os-release
