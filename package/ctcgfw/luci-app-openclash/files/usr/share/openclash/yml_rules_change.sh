#!/bin/sh

check_def=0	
if [ "$2" != 0 ]; then
   if [ ! -f /etc/openclash/"$2".yaml ]; then
      echo "${1} /etc/openclash/"$2".yaml Not Exist, Will Use Self Rules, Please Update and Try Again" >>/tmp/openclash.log
      exit 0
   else
    rulesource=$(grep '##source:' "$4" |awk -F ':' '{print $2}')
    [ "$rulesource" != "$2" ] && {
       check_def=1
    	}
    
    [ "$check_def" -ne 1 ] && {
    	grep "^##updated$" /etc/openclash/"$2".yaml 1>/dev/null
    	[ "$?" -eq "0" ] && {
    	sed -i '/^##updated$/d' /etc/openclash/"$2".yaml
        check_def=1
        }
    }

    [ "$check_def" -ne 1 ] && {
    GlobalTV=$(grep '##GlobalTV:' "$4" |awk -F ':' '{print $2}')
    AsianTV=$(grep '##AsianTV:' "$4" |awk -F ':' '{print $2}')
    Proxy=$(grep '##Proxy:' "$4" |awk -F ':' '{print $2}')
    Apple=$(grep '##Apple:' "$4" |awk -F ':' '{print $2}')
    AdBlock=$(grep '##AdBlock:' "$4" |awk -F ':' '{print $2}')
    Others=$(grep '##Others:' "$4" |awk -F ':' '{print $2}')
    Domestic=$(grep '##Domestic:' "$4" |awk -F ':' '{print $2}')
    Netease_Music=$(grep '##Netease_Music:' "$4" |awk -F ':' '{print $2}')
    Speedtest=$(grep '##Speedtest:' "$4" |awk -F ':' '{print $2}')
    Telegram=$(grep '##Telegram:' "$4" |awk -F ':' '{print $2}')

    if [ "$2" = "ConnersHua_return" ]; then
	if [ "$(uci get openclash.config.Proxy)" != "$Proxy" ]\
	 || [ "$(uci get openclash.config.Others)" != "$Others" ];then
         check_def=1
	fi
    elif [ "$2" = "ConnersHua" ]; then
       if [ "$(uci get openclash.config.GlobalTV)" != "$GlobalTV" ]\
	 || [ "$(uci get openclash.config.AsianTV)" != "$AsianTV" ]\
	 || [ "$(uci get openclash.config.Proxy)" != "$Proxy" ]\
	 || [ "$(uci get openclash.config.Apple)" != "$Apple" ]\
	 || [ "$(uci get openclash.config.AdBlock)" != "$AdBlock" ]\
	 || [ "$(uci get openclash.config.Others)" != "$Others" ]\
	 || [ "$(uci get openclash.config.Domestic)" != "$Domestic" ]; then
         check_def=1
       fi
    elif [ "$2" = "lhie1" ]; then
       if [ "$(uci get openclash.config.GlobalTV)" != "$GlobalTV" ]\
	 || [ "$(uci get openclash.config.AsianTV)" != "$AsianTV" ]\
	 || [ "$(uci get openclash.config.Proxy)" != "$Proxy" ]\
	 || [ "$(uci get openclash.config.Apple)" != "$Apple" ]\
	 || [ "$(uci get openclash.config.AdBlock)" != "$AdBlock" ]\
	 || [ "$(uci get openclash.config.Netease_Music)" != "$Netease_Music" ]\
	 || [ "$(uci get openclash.config.Speedtest)" != "$Speedtest" ]\
   || [ "$(uci get openclash.config.Telegram)" != "$Telegram" ]\
	 || [ "$(uci get openclash.config.Others)" != "$Others" ]\
	 || [ "$(uci get openclash.config.Domestic)" != "$Domestic" ]; then
         check_def=1
       fi
    fi
    }

       if [ "$check_def" -eq 1 ]; then
       GlobalTV=$(uci get openclash.config.GlobalTV 2>/dev/null)
       AsianTV=$(uci get openclash.config.AsianTV 2>/dev/null)
       Proxy=$(uci get openclash.config.Proxy 2>/dev/null)
       Apple=$(uci get openclash.config.Apple 2>/dev/null)
       AdBlock=$(uci get openclash.config.AdBlock 2>/dev/null)
       Netease_Music=$(uci get openclash.config.Netease_Music 2>/dev/null)
       Speedtest=$(uci get openclash.config.Speedtest 2>/dev/null)
       Telegram=$(uci get openclash.config.Telegram 2>/dev/null)
       Domestic=$(uci get openclash.config.Domestic 2>/dev/null)
       Others=$(uci get openclash.config.Others 2>/dev/null)
       if [ "$2" = "lhie1" ]; then
            sed -i '/^Rule:/,$d' "$4"
            cat /etc/openclash/lhie1.yaml >> "$4"
            sed -i -e "s/,GlobalTV/,${GlobalTV}#d/g" -e "/Rule:/a\##GlobalTV:${GlobalTV}"\
            -e "s/,AsianTV/,${AsianTV}#d/g" -e "/Rule:/a\##AsianTV:${AsianTV}"\
            -e "s/,Proxy/,${Proxy}#d/g" -e "/Rule:/a\##Proxy:${Proxy}"\
            -e "s/,Apple/,${Apple}#d/g" -e "/Rule:/a\##Apple:${Apple}"\
            -e "s/,AdBlock/,${AdBlock}#d/g" -e "/Rule:/a\##AdBlock:${AdBlock}"\
            -e "s/,Netease Music/,${Netease_Music}#d/g" -e "/Rule:/a\##Netease_Music:${Netease_Music}"\
            -e "s/,Speedtest/,${Speedtest}#d/g" -e "/Rule:/a\##Speedtest:${Speedtest}"\
            -e "s/,Telegram/,${Telegram}#d/g" -e "/Rule:/a\##Telegram:${Telegram}"\
            -e "s/,Domestic/,${Domestic}#d/g" -e "/Rule:/a\##Domestic:${Domestic}"\
            -e "s/,Others/,${Others}#d/g" -e "/Rule:/a\##Others:${Others}"\
            -e "s/#d//g" "$4"
       elif [ "$2" = "ConnersHua" ]; then
            sed -i '/^Rule:/,$d' "$4"
            cat /etc/openclash/ConnersHua.yaml >> "$4"
            sed -i -e "s/,GlobalMedia/,${GlobalTV}#d/g" -e "/Rule:/a\##GlobalTV:${GlobalTV}"\
            -e "s/,HKMTMedia/,${AsianTV}#d/g" -e "/Rule:/a\##AsianTV:${AsianTV}"\
            -e "s/,PROXY/,${Proxy}#d/g" -e "/Rule:/a\##Proxy:${Proxy}"\
            -e "s/,Apple/,${Apple}#d/g" -e "/Rule:/a\##Apple:${Apple}"\
            -e "s/,Hijacking/,${AdBlock}#d/g" -e "/Rule:/a\##AdBlock:${AdBlock}"\
            -e "s/,DIRECT/,${Domestic}#d/g" -e "/Rule:/a\##Domestic:${Domestic}"\
            -e "s/,Final/,${Others}#d/g" -e "/Rule:/a\##Others:${Others}"\
            -e "s/#d//g" "$4"
       else
            sed -i '/^Rule:/,$d' "$4"
            cat /etc/openclash/ConnersHua_return.yaml >> "$4"
            sed -i -e "s/,PROXY/,${Proxy}#d/g" -e "/Rule:/a\##Proxy:${Proxy}"\
            -e "s/,DIRECT/,${Others}#d/g" -e "/Rule:/a\##Others:${Others}"\
            -e "s/#d//g" "$4"
       fi
       fi
		fi
elif [ "$2" = 0 ]; then
   [ -f /etc/openclash/config.bak ] && {
      grep '##source:' "$4" 1>/dev/null
      if [ "$?" -eq "0" ]; then
         cp /etc/openclash/config.bak /etc/openclash/configrules.bak
         sed -i -n '/^Rule:/,$p' /etc/openclash/configrules.bak
         sed -i '/^Rule:/,$d' "$4"
         cat /etc/openclash/configrules.bak >> "$4"
         rm -rf /etc/openclash/configrules.bak
      fi
    	}
fi

      sed -i '/^##Custom Rules/,/^##Custom Rules End/d' "$4" 2>/dev/null
      sed -i '/^##Custom Rules/d' "$4" 2>/dev/null
      sed -i '/^##Custom Rules End/d' "$4" 2>/dev/null
      if [ "$3" = 1 ]; then
         sed -i '/^Rule:/a\##Custom Rules End##' "$4" 2>/dev/null
         sed -i '/^Rule:/a\##Custom Rules##' "$4" 2>/dev/null
         sed -i '/^##Custom Rules##/r/etc/openclash/custom/openclash_custom_rules.list' "$4" 2>/dev/null
      fi
      
      if [ "$5" = 1 ] || [ "$3" = 1 ] || [ -z "$(grep '- IP-CIDR,198.18.0.1/16,REJECT,no-resolve' "$4")" ]; then
         sed -i "s/^ \{0,\}-/-/" "$4" 2>/dev/null #??????????????????
         sed -i "s/^\t\{0,\}-/-/" "$4" 2>/dev/null #????????????tab
      fi
      
      if [ -z "$(grep '- IP-CIDR,198.18.0.1/16,REJECT,no-resolve' "$4")" ] && [ "$6" = "fake-ip" ]; then
         if [ ! -z "$(grep "^ \{0,\}- IP-CIDR,198.18.0.1/16" "$4")" ]; then
            sed -i "/^ \{0,\}- IP-CIDR,198.18.0.1\/16/c\- IP-CIDR,198.18.0.1\/16,REJECT,no-resolve" "$4"
         else
            sed -i "/^ \{0,\}- GEOIP/i\- IP-CIDR,198.18.0.1\/16,REJECT,no-resolve" "$4"
         fi
      fi