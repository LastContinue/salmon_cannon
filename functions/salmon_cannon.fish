function salmon_cannon -d "Tool to allow for interatctive fish_user_paths management"

    function append_path -a path
        set -Ua fish_user_paths $path
        set_color green
        echo -e "\nAppended '$path' to \$fish_user_paths\n"
        set_color normal
        print_fish_user_paths
    end

    function delete_path -a index
        set_color red

        # Check if $index is a number, and if it is, check if is a valid index.
        # If it's a string however, see if we can find a matching index
        # and reassign $index to that index
        if string match -r -q '^[0-9]+$' $index  
        and test $index -gt 0 # Fish lists start at 1
        and test $index -le (count $fish_user_paths)
        or set index (contains -i $index $fish_user_paths)
            set -l deleted_path $fish_user_paths[$index]
            set -e fish_user_paths[$index] 
            echo -e "\nDeleted '$deleted_path' from \$fish_user_paths\n"
        else
            echo -e "\nInput didn't seem to be a valid index or path\n"
        end

        set_color normal
        print_fish_user_paths
    end

    function display_options
        read -l -P 'Options: a [append], d [delete], p [prepend], or any key other key to [quit] ' options

        switch (string lower $options)
            case a append
                read -l -P 'Enter path to add: ' path
                append_path $path
                display_options
            case d delete
                read -l -P 'Enter INDEX or PATH to delete: ' index
                delete_path $index
                display_options
            case p prepend
                read -l -P 'Enter path to add: ' path
                prepend_path $path
                display_options
            case '*'
                echo ""
        end
    end

    # Would be really great if this could be formatted just like 
    # other Fish functions, but that requires it be a MAN page first
    # If I ever run out of things to do, I might see what it takes to 
    # make an actual MAN page for this
    function help
        echo -e "\nNAME \n  salmon_cannon - easier \$fish_user_paths management\n"

        echo "SYNOPSIS"
        echo "    salmon_cannon ( -a | --append ) NEW_PATH"
        echo "    salmon_cannon ( -l | --list )"
        echo "    salmon_cannon ( -d | --delete ) #INDEX|EXISTING_PATH"
        echo -e "    salmon_cannon ( -p | --prepend ) NEW_PATH\n"

        echo "DESCRIPTION"
        echo -n "    tool to help manage entries in \$fish_user_paths. Can be started in interactive move" 
        echo -e " (no arguments) or with specified arguments for a more regular commandline program experience.\n"       

        echo "EXAMPLES"
        echo "salmon_cannon"
        echo -e "  will start the program in interactive mode\n"
        echo "salmon_cannon -a /usr/local/sbin/"
        echo -e "  will append `/usr/local/sbin` to your \$fish_users_paths\n"
        echo "salmon_cannon -l"
        echo -e "  will list out all of the path elements and their index\n"
        echo "salmon_cannon -d 1"
        echo -e "  will delete the first element in \$fish_user_paths (if it exists)\n"
        echo "salmon_cannon -d /usr/local/sbin"
        echo -e "  will delete `/usr/local/sbin` from \$fish_user_paths (if it exists)\n"
        echo "salmon_cannon -p /usr/local/sbin/"
        echo -e "  will prepend `/usr/local/sbin` to your \$fish_users_paths\n"
    end

    function prepend_path -a path
        set -Up fish_user_paths $path
        set_color green
        echo -e "\nPrepended '$path' to \$fish_user_paths\n"
        set_color normal
        print_fish_user_paths
    end

    if set -q argv
        switch $argv[1]
            case -a --append
                append_path $argv[2]
            case -d --delete
                delete_path $argv[2]
            case -l --list
                print_fish_user_paths
            case -p --prepend
                prepend_path $argv[2]
            case -h --help
                help
            case '*'
                print_fish_user_paths
                display_options
        end
    end
end
