#!/bin/sh
#-----------------------------------------------------------------------
# Copyright IBM Corporation 2013.  All Rights Reserved.
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has
# been deposited with the U.S. Copyright Office.
# ----------------------------------------------------------------------

#set -x 

PROD_NAME="SmartCloud Monitoring - Application Insight"
REPLY_DEFAULT="n"

CURRENT_DIR=`pwd`
TOP_DIR=$(dirname $0)

CCM_DIR=/opt/ibm/ccm
LIC_DIR=${CCM_DIR}/license
RPM_DIR=${TOP_DIR}/RPMS

JAVA=/opt/ibm/java-x86_64-70/jre/bin/java
        
ARR_B_AUTH_KEYS=(1371434277 3924814313 739016560 1836107918)
ARR_T_AUTH_KEY=(44378679 3810031815 1943315150 2296711379)
ARR_G_AUTH_KEY=(2168843300 1297984063 2563561868)
passportExists=false

OLD_BETA_LIC_DIR=${CCM_DIR}/licenses/sma110/license
SAVED_LIC_DIR=${CCM_DIR}/license_sv
PASSPORT_DIR=smai-passport.tar
NO_LIC_FILE=true
glicense=1
blicense=1
tlicense=1
FILE=${LIC_DIR}/English.txt
AUTH_KEY=1297984063

trap func_trap 0
func_trap() {
    test -d ${tempDir} && rm -rf ${tempDir}
}

# Installs the production license from passport.tar.
upgradeLicense() {

    # Check for an older beta license.
    FILE2=${OLD_BETA_LIC_DIR}/English.txt
        
    if  test -f ${FILE2} ; then
        echo -e "`./nls_replace 'CCM0009E'`\n"
        exit 1        
    else
        if [ ${blicense} == 0 ] ; then
            echo -e "`./nls_replace 'CCM0009E'`\n"
            exit 1
        fi
    fi 
           
    tar -xf ${PASSPORT_DIR}   
    mv ${LIC_DIR} ${SAVED_LIC_DIR}
    mkdir -p ${LIC_DIR}    
        
    # LAP creates the license sub-directory, so use ${CCM_DIR}. 
    ${JAVA} -jar LAPApp.jar -l LA_HOME/ -s ${CCM_DIR} -t 5 -text_only
    LAP_RC=$?
        
    if [ ${LAP_RC} -eq 9 ]; then
        echo -e "`./nls_replace 'CCM0011I'`\n"
        rm -rf ${SAVED_LIC_DIR}          
    else
        echo -e "`./nls_replace 'CCM0012E'` ${LAP_RC}"
        rm -rf ${LIC_DIR}
        mv ${SAVED_LIC_DIR} ${LIC_DIR}
    fi
}

# Shows license to accept or exit
presentLicense() {
  
    JAVA_RPM_FILE=ibm-java-x86_64-jre-7.0-4.0.x86_64.rpm
    cd ${RPM_DIR}
    [ -f ${JAVA} ] || { rpm -Uhv ${JAVA_RPM_FILE} || rpm -Uhv --replacepkgs ${JAVA_RPM_FILE} ; }
    cd ..
}

# Shows the license and installs the product.
installIT() {
    presentLicense

    mkdir -p ${LIC_DIR}    

    # LAP creates the license sub-directory, so use ${CCM_DIR}. 
    ${JAVA} -jar LAPApp.jar -l LA_HOME/ -s ${CCM_DIR} -t 5 -text_only
    
    cd ${RPM_DIR}
    rpm -Uhv --replacefiles smai-1.2-1.el6.x86_64.rpm || exit 1                
	RPM_RC=$?    
    
        
    if [ ! -z "$SMAI_1_1_INSTALLED" ] ; then
        stop fabricNode
        cd ..
        echo -e "`./nls_replace 'CCM0016I'`\n"
        tar -xf smai-config.tar -C /opt/ibm/gaian
        TAR_RC=$?
        start fabricNode
        cd ${RPM_DIR}
    fi

    rpm -Uhv smai-scr-6.1.2-1.el6.x86_64.rpm || exit 1
    restart liberty
}

# Installs the product without showing the license.
installITpresentLicenseNO() {
    mkdir -p /tmp/license
    cp -r ${LIC_DIR}/* /tmp/license
        
    rpm -e smai-apmui smai-scr smai-oslc-pm smai-oslc-pm smai-itmcdp smai
        
    cd ${RPM_DIR}
    rpm -Uhv --replacefiles smai-1.2-1.el6.x86_64.rpm smai-itmcdp-1.2-1.el6.x86_64.rpm || exit 1
	RPM_RC=$?    
	
    if [ $RPM_RC -eq 0 ] ; then
    	cd ..
        mkdir -p ${LIC_DIR}
        cp -r /tmp/license/* ${LIC_DIR}
        rm -fr /tmp/license
        cd ${RPM_DIR}
    fi
        
    if [ ! -z "$SMAI_1_1_INSTALLED" ] ; then
    	cd ..
        stop fabricNode
        echo -e "\nRestoring configuration..."
        tar -xf smai-config.tar -C /opt/ibm/gaian
        TAR_RC=$?
        start fabricNode
        cd ${RPM_DIR}
    fi

    rpm -Uhv smai-scr-6.1.2-1.el6.x86_64.rpm || exit 1
    restart liberty
}

# Checks if the license is installed and determines which version.
determineLicense() {

    # Check if previous license exists
    if test -f ${FILE} ; then
        ID=`cksum ${FILE} | gawk '{ print $1 }'`
    else
        NO_LIC_FILE=false
    fi
        
    # Determine which license type it is,
    if $NO_LIC_FILE ; then    
        for i in "${ARR_G_AUTH_KEY[@]}"; do
            if [ "$i" == "${ID}" ] ; then
                glicense=0      
            fi
        done
        
        for i in "${ARR_B_AUTH_KEYS[@]}"; do
            if [ "$i" == "${ID}" ] ; then
                blicense=0      
            fi
        done
        
        for i in "${ARR_T_AUTH_KEY[@]}"; do
            if [ "$i" == "${ID}" ] ; then
                tlicense=0      
            fi
        done
    fi
}

determineLicense
        
# If beta or trial is detected, upgrade; don't show the license when installing a newer version.
if $NO_LIC_FILE  && [ ${glicense} == 1 ] ; then
    if [ ${blicense} == 0 ] ; then
        echo -e "`./nls_replace 'CCM0002I' "${PROD_NAME}"`\n"
    elif [ ${tlicense} == 0 ] ; then
        echo -e "`./nls_replace 'CCM0003I' "${PROD_NAME}"`\n"
    fi

    read -p "`./nls_replace 'CCM0004I' "${PROD_NAME}"`" REPLY
    REPLY="${REPLY:-$REPLY_DEFAULT}"
    echo -e "\n"

    if [ ${REPLY} == 'y' ]; then
        read -p "`./nls_replace 'CCM0005I' "${PROD_NAME}"`" REPLY
        REPLY="${REPLY:-$REPLY_DEFAULT}"
        echo -e "\n"
        if [ ${REPLY} == 'y' ] ; then
            presentLicense
            installITpresentLicenseNO
                                        
            if $passportExists ; then
                if [ ${blicense} == 0 ] ; then
                    echo -e "`./nls_replace 'CCM0006W'`\n"
                else
                    tar -xf ${PASSPORT_DIR}
                    upgradeLicense
                    restart fabricNode
                fi
            fi                              
        else
            echo -e "`./nls_replace 'CCM0007W'`\n"
            exit 1
        fi
    else
        echo -e "`./nls_replace 'CCM0007W'`\n"
        exit 1
    fi
        
# Installation of product for those already with a production license.      
 elif $NO_LIC_FILE && [ ${glicense} == 0 ] ; then       
     echo -e "`./nls_replace 'CCM0001I' "${PROD_NAME}"`\n"
     read -p "`./nls_replace 'CCM0004I' "${PROD_NAME}"`" REPLY
     REPLY="${REPLY:-$REPLY_DEFAULT}"
     echo -e "\n"
     if [ ${REPLY} == 'y' ] ; then
         presentLicense
         installITpresentLicenseNO
         if $passportExists ; then
             upgradeLicense
             restart fabricNode
         fi
     else
         echo -e "`./nls_replace 'CCM0007W'`\n"
         exit 1
     fi

# New installation.
else
    echo -e "`./nls_replace 'CCM0008I' "${PROD_NAME}"`\n"
    installIT
fi

exit 0
