#!/bin/bash

function pause {
    # $1 = Optional what to continue to
    # If the number of arguments is not zero...
    if [ $# != 0 ]
    then
        read -p "Press <ENTER> to continue... ($1)"
    else
        read -p "Press <ENTER> to continue..."
    fi
}


function check {
    # $1 = What to check
    # $2 = Next action description
    # If $2 expands to a null string, ie. not provided
    if [ -z "$2" ]
    then
        NEXT_ACTION="next section"
    else
        NEXT_ACTION=$2
    fi
    echo ""
    echo "Check: $1"
    echo "  If FAILURE, press CTRL+C to abort script."
    echo "  If SUCCESS, press <ENTER> to continue... ($NEXT_ACTION)"
    read
}


function heading  {
   # $1 = heading message
   echo -e "\n\n============================================"
   echo -e     "============================================"
   echo -e     "   $1"
   pause
}


COUNTER=0
function next_step  {
   # $1 = display message
   COUNTER=$((COUNTER + 1))
   echo -e "\n____________________________________________"
   echo -e   "   Step $COUNTER - $1"
}


function get_sudo {
    # TODO check can change ' -> "
    sudo -H -u "$VPS_NC_NAME" echo '$VPS_NC_PASS' | sudo -S echo 'Enabling sudo'
}


function line_in_file  {
    # $1 = file, $2 = line
    if grep -Fxq "$2" "$1"
    then
        echo "    --> PASS: file '$1' contains line '$2'"
    else
        echo "    --> FAILURE: file '$1' does not contain line '$2'"
    fi
    echo ""
}


function replace_print  {
    # $1 = filepath, $2 = old string, $3 = new string
   echo "    File: $1 - Replace '$2' --> '$3'"
   NEW_LINE1="\n# ____________________________________________"
   NEW_LINE2="\n#  Changed '$2' --> '$3'\n"
}


function replace_line  {
   # $1 = filepath, $2 = old string, $3 = new string
   replace_print "$1" "$2" "$3"
   sed -i -e "s|^$2|$NEW_LINE1$NEW_LINE2$3|" $1
   line_in_file "$1" "$3"
}


function replace_line_starts_with  {
   # $1 = filepath, $2 = old string, $3 = new string
   replace_print "$1" "$2" "$3"
   sed -i -e "s|^$2.*|$NEW_LINE1$NEW_LINE2$3|" $1
   line_in_file "$1" "$3"
}


function append_if {
    # Append a line only not in the file
    # $1 = file, $2 = line (must start with this line)
    # Example: append_if ~/file.txt "foo=1"
    # \Q = start of literal match, \E = end of Literal match
    echo "    File: $1 - Append line '$2'"
    grep -qP "^\Q$2\E" "$1" || echo "$2" >> "$1"
    line_in_file "$1" "$2"
}


function backup  {
    # $1 = File to backup
    if [ ! -f "$1.bak" ]; then
      cp $1 "$1.bak"
    fi
}


function dns_check {
    #1 = Display Message, $2 = Correct Value, $3 = DNS Entry
    echo ""
    echo "    DNS Entry - $1"
    echo "    --> Require: $2"
    echo "    --> Found:   $3"
}


function get_email_command {
    # $1 = to email address
    TEST_EMAIL_FULLNAME="$VPS_HOSTNAME"
    TEST_EMAIL_SENDER="no-reply@$VPS_DOMAIN"
    echo "echo \"From: $TEST_EMAIL_SENDER
To: $1
Subject: Test subject
Test body
.\" |  sendmail -F $TEST_EMAIL_FULLNAME -t $1"
}

# echo "From: no-reply@mpact.nanocube.co.za
# To: support@nanocube.co.za
# Subject: Test subject before relay server ip range
# Test body before relay server ip range
# ." |  sendmail -F "Mpact Server" -t support@nanocube.co.za

# echo "From: no-reply@mpact.nanocube.co.za
# To: test-144f682d@appmaildev.com
# Subject: Test subject before relay server ip range
# Test body before relay server ip range
# ." |  sendmail -F "Mpact Server" -t test-144f682d@appmaildev.com

function render_template {
    # Renders a file with the current ENV variables, same path just changes
    # extension to .render
    # $1 = template file, #2 = where to symlink the file to
    OUTPUT=$(echo "${1%.*}")
    OUTPUT="$OUTPUT.render"
    #cp $1 $OUTPUT
    envsubst < $1 > $OUTPUT
    #echo "$(cat $1)" > $OUTPUT
    chown $VPS_NC_NAME:$VPS_NC_NAME $OUTPUT
    chmod 770 $OUTPUT
    ln -s -f $OUTPUT $2
}
