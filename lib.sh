#!/bin/bash
BOOK=./addressbook
CONFIRM=""
export CONFIRM
export BOOK
add_info()
{
    info=`grep $NAME $BOOK`
    flag=0
    use_name_get_info
    if [[ -z $GET_NAME || -z $GET_PHONE || -z GET_EMAIL ]];then
        echo "Name is never used."
        flag=1
        else
        echo "Name: $GET_NAME, Phone: $GET_PHONE, E-Mail: $GET_EMAIL"
        echo "Confirm to overwrite ?"
    fi
    echo -en "Confirm [y/n]: "
    read -e CONFIRM

    while [[ `echo $CONFIRM | tr [:upper:] [:lower:]` != y && `echo $CONFIRM | tr [:upper:] [:lower:]` != n ]]
    do
        echo -en "Confirm [y/n]: "
        read -e CONFIRM
    done
    target_info=`echo $GET_NAME:$GET_PHONE:$GET_EMAIL`
    after_info=`echo $NAME:$PHONE:$EMAIL`
    if [ `echo $CONFIRM | tr [:upper:] [:lower:]` = "y" ];then
        if [[ "$flag" = 1 ]];then
            echo $after_info >> $BOOK
            else
            sed -i s/$target_info/$after_info/g $BOOK
        fi
    else
        echo "Cancell"
    fi

    sed -i '/^$/d' $BOOK

    return $?
}
remove_info()
{

    search_info
    if [[ $? =  1 ]];then
        return 1;
    fi
    echo -e "Do you want to remove ?"
    echo -en "Confirm [y/n]: "
    read -e CONFIRM
    while [[ `echo $CONFIRM | tr [:upper:] [:lower:]` != y && `echo $CONFIRM | tr [:upper:] [:lower:]` != n ]]
    do
        echo -en "Confirm [y/n]: "
        read -e CONFIRM
    done
    if [ `echo $CONFIRM | tr [:upper:] [:lower:]` = "y" ];then
        sed -i s/$GET_NAME:$GET_PHONE:$GET_EMAIL$//g $BOOK
        sed -i '/^$/d' $BOOK
    fi
    return $?
}
show_info()
{
    info=`cat $BOOK`
    printf "%-10s%-10s%-10s\n" "Name" "Phone" "E-Mail"
    for i in $info
    do
        name=`echo $i | cut -d: -f1`
        phone=`echo $i | cut -d: -f2`
        mail=`echo $i | cut -d: -f3`
        printf "%-10s%-10s%-10s\n" $name $phone $mail
    done
    return $?
}
search_info()
{
    while [ "$name_size" != 1 ]
    do
        echo -en "Name "
        read -e NAME
        name_size=$(echo -n $NAME | wc -w)
    done
    use_name_get_info
    if [[ -z $GET_NAME || -z $GET_PHONE || -z GET_EMAIL ]];then
        echo "Can't find the information in addressbook"
        return 1
    else
        echo "Name: $NAME, Phone: $phone, E-Mail: $mail"
    fi
    return $?
}
get_info()
{
    while [ "$name_size" != 1 ]
    do
        echo -en "Name "
        read -e NAME
        name_size=$(echo -n $NAME | wc -w)
    done

    while [ "$phone_size" != 1 ]
    do
        echo -en "Phone "
        read -e PHONE
        phone_size=$(echo -n $PHONE | wc -w)
    done
    while [ "$email_size" != 1 ]
    do
        echo -en "Email "
        read -e EMAIL
        email_size=$(echo -n $EMAIL | wc -w)
    done
    return $?
}
edit_info()
{
    echo "Plase input original information."
    get_info
    use_name_get_info
    if [[ -z $GET_NAME || -z $GET_PHONE || -z GET_EMAIL ]];then
        echo "Can't find the information in addressbook"
        return 1
    fi

    if [[ "$GET_NAME" != "$NAME" || "$GET_PHONE" != "$PHONE" || "$GET_EMAIL" != "$EMAIL" ]];then
        echo "Input information is not matched."
        return 1
    fi
    while [ -z $NEWPHONE ]
    do
        echo -en "PHONE [ $GET_PHONE ] "
        read NEWPHONE
    done
    while [ -z $NEWEMAIL ]
    do
        echo -en "EMAIL [ $GET_EMAIL ] "
        read NEWEMAIL
    done
    target_info=`echo $NAME:$PHONE:$EMAIL`
    after_info=`echo $NAME:$NEWPHONE:$NEWEMAIL`
    printf "%-10s%-10s%-10s            %-10s%-10s%-10s\n" NAME PHONE EMAIL NAME NEWPHONE NEWEMAIL
    printf "%-10s%-10s%-10sto          %-10s%-10s%-10s\n" $NAME $PHONE $EMAIL $NAME $NEWPHONE $NEWEMAIL
    
    echo -en "Confirm [y/n]: "
    read -e CONFIRM
    # confirm=
    while [[ `echo $CONFIRM | tr [:upper:] [:lower:]` != y && `echo $CONFIRM | tr [:upper:] [:lower:]` != n ]]
    do
        echo -en "Confirm [y/n]: "
        read -e CONFIRM
    done
    if [ `echo $CONFIRM | tr [:upper:] [:lower:]` = "y" ];then
        sed -i s/$target_info/$after_info/g $BOOK
    fi
    return $?
}
use_name_get_info()
{
    info=`grep $NAME $BOOK`
    for i in $info
    do
        name=`echo $i | cut -d: -f1`
        phone=`echo $i | cut -d: -f2`
        mail=`echo $i | cut -d: -f3`
        if [ $name == $NAME ];then
            GET_NAME=$name
            GET_PHONE=$phone
            GET_EMAIL=$mail
            break
        fi
    done
}