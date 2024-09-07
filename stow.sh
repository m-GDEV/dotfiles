# dry run first, if it fails quit
stow -n -v -t $HOME .

if [ "$?" != 0 ]; then
    echo "Error occured, fix it and try again"
    exit
fi

read -p "Press enter to continue (make sure there are no issues)"

stow -v -t $HOME .
