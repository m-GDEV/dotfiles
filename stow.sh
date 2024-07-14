# dry run first, if it fails quit
stow -n -v -t $HOME .

if [ "$?" != 0 ];
    echo "Error occured, fix it and try again"
fi

stow -v -t $HOME .
