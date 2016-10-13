#!/bin/sh
cd /opt/apache-tomcat-7.0.55/webapps/
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
        if [ "$?" -eq "0" ] ; then
           echo "copied $OLDWAR to ${OLDWAR}.last"
		fi
		NEW_WAR=$(echo $WGET_WAR | cut -d '/' -f 12)
        cp $NEW_WAR $OLDWAR
		if [ "$?" -eq "0" ] ; then
           echo "copied wgeted war to $OLDWAR"
        fi
        WARFOLDER=$(echo $OLDWAR | cut -d '.' -f 1)
        rm -rf $WARFOLDER
         if [ "$?" -eq "0" ] ; then
            echo "deleted $WARFOLDER..."
            sudo /etc/init.d/tomcat start
            while [ ! -d "$WARFOLDER" ] 
            do
			echo " $WARFOLDER is not yet created "
            done
            echo " $WARFOLDER is created now..."
            echo "$(ls -lrt)"
            echo "Your war is successfully deployed now!!!"
         fi
     fi
fi