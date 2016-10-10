#!/bin/sh
echo "Enter the servername: Gold(lgpbdgv***/lgpbdgv***) Silver(lgpbdsv***/lgpbdsv***)"
read SERVER
ssh $SERVER
cd /opt/apachetomcat/webapps
echo "Inside webapps folder.."
echo "$(ls -lrt)"
echo "Enter Jenkins .war filename need to be wgeted..."
read WGET_WAR
wget $WGET_WAR
if [ "$?" -eq "0" ] ; then
   echo "Stopping the tomcat.."
   sudo /etc/init.d/tomcat stop
     if [ "$?" -eq "0" ] ; then
        echo "$(ls -lrt)"
        echo "Enter war file need to be replaced..."
        read OLDWAR
        cp $OLDWAR ${OLDWAR}.last
        echo "copied $OLDWAR to ${OLDWAR}.last"
        cp $WGET_WAR $OLDWAR
        echo "copied wgeted war to $OLDWAR"
        WARFOLDER=$(echo $OLDWAR | cut -d '.' -f 1)
        rmdir $WARFOLDER
         if [ "$?" -eq "0" ] ; then
            echo "deleted $WARFOLDER..."
            sudo /etc/init.d/tomcat start
            while [ ! -d "$WARFOLDER" ] 
            do
            done
            echo " $WARFOLDER is created now..."
            echo "$(ls -lrt)"
            echo "Your war is successfully deployed now!!!"
         fi
     fi
fi
