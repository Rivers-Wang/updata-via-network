#! /bin/sh
set -x

SUCEESS=0
ZERO=0

filename = (0 0 0 0 0 0 0 0 0 0 0 0)
updata_flag = (0 0 0 0 0 0 0 0 0 0 0 0)
updata_dir = (0 0 0 0 0 0 0 0 0 0 0 0)


#####download updata_list to wcam#######
wget --spider https://updata_list.txt
if[ $? = $SUCCESS ]
then
     wget /etc https://updata_list  --no-check-certificate --timeout=3
     if[ $? = $SUCCESS ]
     then
         echo "#######download rupdata_list ok"
         //if[ $ZERO != ${sed -n '1p' /etc/updata_list|awk  '{print $1}'} ]
	 //then
              filename[0]=${sed -n '1p' /etc/updata_list|awk  '{print $1}'}
              updata_flag[0]=${sed -n '1p' /etc/updata_list|awk  '{print $2}'}
	      updata_dir[0]=${sed -n '1p' /etc/updata_list|awk  '{print $2}'}
	    
     else 
	 echo "#######download updata_list fail"
     fi
else
     echo "there is no updata_list found" 
fi




#####download updata file to wcam#######
if[ ${filename[0]} -ne $ZERO ]
then
	wget --spider https://${filename[0]}.tar.gz
	if[ $? = $SUCCESS ]
	then
	     wget /opt/ko/wifi https://${filename[0]}.tar.gz  --no-check-certificate --timeout=3
	     if[ $? = $SUCCESS ]
	     then
		 echo "#######download ${filename[0]}.tar.gz  ok"
		 tar xvf  ${updata_dir[0]}/${filename[0]}.tar.gz  -C   ${updata_dir[0]}
		 rm -rf   ${updata_dir[0]}/${filename[0]}.tar.gz   
	     else 
		 echo "#######download ${filename[0]}.tar.gz fail"
	     fi
	else
	     echo "there is no ${filename[0]}.tar.gz found" 
	fi
fi




