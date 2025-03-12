#! /bin/sh

# Will exit script if we would use an uninitialised variable:
set -o nounset
# Will exit script when a simple command (not a control structure) fails:
set -o errexit

# Variables

# defualt to the IP_VERSION environment variable, or 6 if not set
ipVersion=${IP_VERSION:-6}

subscription="033186f6-96b0-429c-98a6-98ad3dc9ab4c"
resourceGroup="home"
zoneName="adarosa.net"
recordSetName="blathers"

# cmn_die message ...
#
# Writes the given messages in red letters to standard error and exits with
# error code 1.
#
# Example:
# cmn_die "An error occurred."
#
function cmn_die {
  local red=$(tput setaf 1)
  local reset=$(tput sgr0)
  echo >&2 -e "${red}$@${reset}"
  exit 1
}

# helper to 

if [ $ipVersion -eq 4 ]; then
  recordType="A"
elif [ $ipVersion -eq 6 ]; then
  recordType="AAAA"
else
  cmn_die "Invalid IP version."
fi


# Get the current IP address
publicIp=$(curl -Ss "-$ipVersion" ip.me)

echo "Public IP: $publicIp"

# Add the new IPv6 address, if i have one
if [ -z "$publicIp" ]; then
  cmn_die "No IPv6 address found."
fi

az network dns record-set $recordType add-record \
--subscription $subscriptionId \
--resource-group $resourceGroup \
--zone-name $zoneName \
--record-set-name $recordSetName \
"--ipv$ipVersion-address" $publicIp

