#!/bin/bash
# VPS Post Install SetUp - v0.1
# By @AlternativeSec
#
# This script sets up a fresh Ubuntu Linux OS with a few
# additonal tools which I aid in phishing enagements.
#
# License---------------------------------------------------------------------------#
#
# "THE BEER O'CLOCK LICENSE" (Version 0.1):
#
# As long as you retain this notice you can do
# whatever you want with this stuff. If we meet some day, and you think
# this stuff is worth it, you can buy me a beer in return.
#
# ----------------------------------------------------------------------------------#


##### (Cosmetic) Colour output
RED="\033[01;31m"      # Issues/Errors
GREEN="\033[01;32m"    # Success
YELLOW="\033[01;33m"   # Warnings/Information
BLUE="\033[01;34m"     # Heading
BOLD="\033[01;01m"     # Highlight
RESET="\033[00m"       # Normal

STAGE=0                                                         # Where are we up to
TOTAL=$( grep '(${STAGE}/${TOTAL})' $0 | wc -l );(( TOTAL-- )) # How many things have we got todo

#### Additonal Tools
additional_tools="unzip bc tor python3-pip libssl-dev libffi-dev python-dev build-essential"

# ----------------------------------------------------------------------------------#


##### ROOT User Check - Just incase You're Running a Non-Root User
if [[ "${UID}" -ne 0 ]]; then
  echo -e ' '${RED}'[!]'${RESET}" This script must be ${RED}run as root${RESET}" 1>&2
  echo -e ' '${RED}'[!]'${RESET}" Quitting..." 1>&2
  exit 1
else
  echo -e "${BLUE}[*]${RESET} ${BOLD}SE VPS Post Install SetUp Script${RESET}"
  sleep 3s
fi
echo
echo

##### Check Internet Access
(( STAGE++ )); echo -e "${YELLOW}[!]${RESET} (${STAGE}/${TOTAL}) ${YELLOW}Checking Internet Access.${RESET}\n"

#--- Pinging Google for Confirmation
if ping -q -c 1 -W 1 google.com; then
  echo -en "\n${GREEN}[!]${RESET} ${BOLD}We have internet access. ${BOLD}${GREEN}Continuing${RESET} ${BOLD}SE VPS Post Install SetUp Script${RESET}\n"
else
  echo -en "\n${RED}[!]${RESET} ${BOLD}Internet access is ${RED}DOWN${RESET}. ${BOLD}Aborting SE VPS Post Install SetUp Script${RESET}\n\n"
  exit 1
fi


###Time and Date That Script Starts
echo
(( STAGE++ )); echo -en "${GREEN}[+]${RESET} (${STAGE}/${TOTAL})${GREEN}Start time: ${RESET}" && date
echo

#### Go Make a Coffee
echo -en "${BLUE}Go make a coffee.\n"
echo
echo -en "${BLUE}No seriously, go make a coffee!\n"
echo
echo -en "${BLUE}It might not take long, but coffee touches the soul ....\n${RESET}"
echo


#### Update & Upgrade Instance Repo's
(( STAGE++ )); echo -en "${YELLOW}[+]${RESET} (${STAGE}/${TOTAL})${YELLOW} *** Beginning OS update ***${RESET}\n"
echo
apt-get update && apt-get upgrade -y
echo
echo

#### Installing Addtional Items:
(( STAGE++ ));echo -en "${YELLOW}[+]${RESET} (${STAGE}/${TOTAL})${YELLOW} *** Installing Additional Items ***${RESET}\n"
echo
apt-get install $additional_tools -y
echo
echo

#### Change to OPT Directory
(( STAGE++ )); echo -en "${YELLOW}[+]${RESET} (${STAGE}/${TOTAL})${YELLOW} *** Changing to OPT Directory ***${RESET}\n"
echo
echo -en "${BLUE}[*]${RESET} ${BOLD}cd /opt/${RESET}\n"
echo
cd /opt/
echo


#### Installing Git Repos to '/opt' Directory
(( STAGE++ )); echo -en "${YELLOW}[+]${RESET} (${STAGE}/${TOTAL})${YELLOW} *** Install Git Repos To /OPT ***${RESET}\n"
echo
echo -en "${BLUE}[*]${RESET} ${BOLD}Installing Lets Encrypt CertBots${RESET}\n"
echo -en "${BLUE}[*]${RESET} ${BOLD}Installing GoPhish${RESET}\n"
echo -en "${BLUE}[*]${RESET} ${BOLD}Installing lgandx's Responder${RESET}\n"
echo -en "${BLUE}[*]${RESET} ${BOLD}Installing PowerShell Empire${RESET}\n"
echo -en "${BLUE}[*]${RESET} ${BOLD}Installing TrustedSec's Unicorn${RESET}\n"
echo -en "${BLUE}[*]${RESET} ${BOLD}Installing MDSec's SharpeShooter${RESET}\n"
echo -en "${BLUE}[*]${RESET} ${BOLD}Installing metasploit-framework${RESET}\n"
echo

#### Adding Additional Tools
(( STAGE++ )); echo -en "${YELLOW}[+]${RESET} (${STAGE}/${TOTAL})${YELLOW} *** Installing Additional Tools ***${RESET}\n"
echo
echo -en "${BOLD}Installing new tools to:${RESET} ${BOLD}/opt/${RESET}\n"

git clone https://github.com/certbot/certbot.git
wget https://github.com/gophish/gophish/releases/download/v0.6.0/gophish-v0.6.0-linux-64bit.zip
# Note: The above GoPhish release was current stable version as of 20/Aug/2018.
# ** Please Check version release and amend prior to running script if superceeded **
git clone https://github.com/lgandx/Responder.git
git clone https://github.com/EmpireProject/Empire.git
git clone https://github.com/trustedsec/unicorn
git clone https://github.com/mdsecactivebreach/SharpShooter.git
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall &&  chmod 755 msfinstall &&  ./msfinstall
echo
echo -en "${YELLOW}[!]${RESET} ${BOLD}Please Note: That Additional Setup is Required For the Downloaded Tools!!${YELLOW}[!]${RESET}\n"
echo -en "${YELLOW}[!]${RESET} ${BOLD}Additional Configuration Changes Through Your VPS Management Console Maybe Required${YELLOW}[!]${RESET}\n"
echo -en "${YELLOW}[!]${RESET} ${BOLD}To Allow Inbound Connections On Your VPS Firewall ${YELLOW}\n\n"
echo


#### We're Done Message ...
echo -en "${GREEN}... And we're done!\n"
sleep 1s
echo
echo -en "${GREEN}But we are haxors and haxors do cool thingz with terminals\n"
sleep 1s
echo
echo -en "${GREEN}${BOLD}Hack The Planet!!${RESET}\n"
sleep 1s
echo
echo -en "${BOLD}Completion time: ${RESET}" && date
echo

exit 0
