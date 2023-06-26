#!/bin/bash
. ./lib.sh
do_operation()
{
    op=`echo $1 | tr [:upper:] [:lower:]`
    case $op in
        add)
            get_info
            add_info
            ;;
        remove)
            remove_info
            ;;
        edit)
            edit_info
            ;;
        search)
            search_info
            ;;
        show)
            show_info
            ;;
        *)
            echo "Invalid";;
    esac
    return $?
}
show_menu()
{
    echo "-----Address Book-----"
    echo "1. Add"
    echo "2. Remove"
    echo "3. Edit"
    echo "4. Search"
    echo "5. Show"
    echo "6. Exit"
    echo "Address Book [$BOOK]"
    
    ask
    return $?
}
ask()
{
    while [ "$size" != 1 ]
    do
        echo -en "What to you want to do ? "
        read -e OPERATION
        size=$(echo -n $OPERATION | wc -w)
        if [ $size -gt 1 ];then
            echo "Too many arguments."
            continue
        fi
        if [ -z $OPERATION ];then
            continue
        fi
        if [ $OPERATION = `echo "exit" | tr [:upper:] [:lower:]` ];then
            return 0
        fi
        do_operation $OPERATION
    done
}

touch $BOOK
show_menu
# if [ $? != 0 ];then
#     echo "Something Wrong!"
# fi