#!/bin/zsh
OSVERSION=$(sw_vers -buildVersion | cut -b 1-2)

# macOS builds :
# Mojave = 18
# Catalina = 19
# Big Sur = 20
# Monterey = 21
# Ventura = 22
# Sonoma = 23

echo "macOS Build : version $OSVERSION"

# Running macOS Sonoma or higher

if [ "$OSVERSION" -gt "22" ]; then

# in macOS Sonoma and higher we just need to comment the pam_tid.so line in /etc/pam.d/sudo_local.template

cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local.template_backup
cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local
sed -i ''  '/pam_tid.so/ s/^#//' /etc/pam.d/sudo_local

else
	
	# Running macOS Ventura or lower

	cp /etc/pam.d/sudo /etc/pam.d/sudo.backup

# in macOS Ventura and lower the pam_tid.so line does not exist so we must add it after the first comment line.
 
sed -i '' "/\#/a\ 
auth       sufficient     pam_tid.so\\
" /etc/pam.d/sudo
	
fi

exit 0
