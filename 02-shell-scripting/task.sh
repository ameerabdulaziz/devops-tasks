#! /usr/bin/bash

# This script includes all topics that we discussed in DevOps (Senior Steps Course) after finishing shell scription part

# Include all contacts info
CONTACTS_DATABASE='contacts.txt'


# Print welcome message
show_welcome_message () {
	echo "* Welcome to Contacts Program *"
}


# Print exit message
show_exit_message () {
	echo "* Thank you for using Contacts Program *"
}


# Print decoration
# $1 is the number of loops
# $2 is the symbol that will be printed.
show_decoration () {
	if [ "$2" = - ]; then
		printf -- "$2%.0s" $(seq $1); printf "\n"
	else
		printf "$2%.0s" $(seq $1); printf "\n"
	fi
}


# Read file and show its content
# $1 is the file name
read_file_show_content () {
	awk '$0' $1
}


# Read "menu.txt" file which include all features of Contacts Program and print them line by line to the user
show_menu () {
	read_file_show_content menu.txt
}	


# Read contact data from user and save it inside 'contacts.txt' file
add_new_contact () {
	read -p "First Name: " first_name
	read -p "Last Name: " last_name
	read -p "Email: " email
	read -p "Phone Number: " phone_number
	echo $first_name, $last_name, $email, $phone_number >> $CONTACTS_DATABASE
}


# Print all contacts inside 'contacts.txt' file
view_all_contacts () {
	# Check file size if it is greater than 0 bytes will read file content or print no contacts message
	if [ -s $CONTACTS_DATABASE ]
	then
		read_file_show_content $CONTACTS_DATABASE
	else
		echo "No contacts are added yet"
	fi
}


# Search for contact inside 'contacts.txt' file
search_for_contact () {
	read -p "Please enter pattern related to contact you want to search for " pattern
	awk -v pat=$pattern '$0~pat' $CONTACTS_DATABASE
}


# Delete all contacts
delete_all_contacts () {
	sed -i d $CONTACTS_DATABASE
	echo "All Contacts are deleted!"
}


# Delete specific contact
delete_contact () {
	read -p "Please enter pattern related to contact you want to delete " pattern
	sed -i "/$pattern/d" $CONTACTS_DATABASE
	echo "$pattern contact is deleted!"
}


# Show warning input message
show_warning_message () {
	show_decoration 65 '!'
	printf "WARNING - $1 is not one of the above $2, please try again!\n"
	show_decoration 65 '!'
}


# Ask user to choose one of the option whether to continue in the program or exit
choose_option () {
	while :
	do
		read -p "Would you like to return to the main menu press m or q for exit? " option
		case $option in
			m)
				return 1
				;;
			q)
				return 0
				;;
			*)
				show_warning_message $option options
				continue
				;;
		esac
	done
}


# Allow user to choose one of Contacts Program features
choose_feature () {
	while :
	do
		show_menu
		show_decoration 42 "="
		read -p "Please choose one of the above features: " feature
		show_decoration 42 "-"
		case $feature in 
			i)
				add_new_contact
			     	show_decoration 42 "="
			      	if choose_option == 0; then break; fi
			      	;;
			v)
			      	view_all_contacts
			      	show_decoration 42 "="
			      	if choose_option == 0; then break; fi
			      	;;
			s)
			      	search_for_contact
			      	show_decoration 42 "="
			      	if choose_option == 0; then break; fi
			      	;;
			e)
			      	delete_all_contacts
			      	show_decoration 42 "="
			      	if choose_option == 0; then break; fi
			      	;;
			d)
			      	delete_contact
			      	show_decoration 42 "="
			      	if choose_option == 0; then break; fi
			      	;;
			q)
			      	break
			      	;;
			*)
				show_warning_message $feature features
			      	;;
		esac
	done
}


# Run main Contacts Program
main () {
	show_decoration 31 "*"
	show_welcome_message
	show_decoration 31 "*"
	choose_feature
	show_decoration 40 "*"
	show_exit_message
	show_decoration 40 "*"
}


main
