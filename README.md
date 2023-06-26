# Addressbook
Create an addressbook program using the bourne or bourne-again shell.
It should use functions to perform the required tasks
Users can use the script to store/modify personal information

## How to use
```shell=
bash main.sh
```

## Specification
### Menu
The menu will display when the user execute the script.
You can execute some task based on the menu.

```shell=
-----Address Book-----
1. Add
2. Remove
3. Edit
4. Search
5. Show
6. Exit
Address Book [./addressbook]
What to you want to do ? 
```
### Add
When the user want to add records.
If it appears to be a duplicate, it will edit the existing record.
Save the record into the data file when the user confirms.

```shell=
Usage: add
```

### Remove
When the user want to down some records.
Input the `name` and confirm, then remove the record.
```shell=
Usage: remove
```

### Edit
When the user want to modify some records like phone or e-mail.
Input the the old record you want to modify and input the new record you want to replace.
Confirm, then edit the existing record.
```shell=
Usage: edit
```

### Search
When the user forgot some records, he/she can use `search` to find all information
Input `name`, the terminal will display the record.
```shell=
Usage: search
```

### Show
When the user want to see all records.
```shell=
Usage: show
```

