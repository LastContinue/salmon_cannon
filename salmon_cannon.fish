#! /bin/env fish
function salmon_cannon -d "Tool to allow for interatctive fish_user_paths management"

    function add_path
        set -U fish_user_paths $argv[1] $fish_user_paths
        set_color green
        echo "Added '$argv[1]' to \$fish_user_paths"
        set_color normal
        echo ''
        print_fish_user_paths
    end

    function delete_path
        set -l deleted_path $fish_user_paths[$argv[1]]
        set -e fish_user_paths[$argv[1]]
        set_color red
        echo "Deleted '$deleted_path' from \$fish_user_paths"
        set_color normal
        echo ''
        print_fish_user_paths
    end

    function display_options
        read -l -P 'Options: a [add], d [delete], any key other key to [quit] ' options

        switch $options
            case a A add Add add
                read -l -P 'Enter path to add: ' path
                add_path $path
                display_options
            case d D delete Delete del
                read -l -P 'Enter NUMBER OF PATH to delete: ' index
                delete_path $index
                display_options
            case '*'
                echo " "
        end
    end

    if set -q argv
        switch $argv[1]
            case -a --add
                add_path $argv[2]
            case -d --delete
                delete_path $argv[2]
            case -l --list
                print_fish_user_path
            case -h --help
                echo "OVERVIEW: Tool to allow for interatctive fish_user_paths management "
                echo " "
                echo "USAGE: salmon_cannon [options] - running with NO OPTIONS will enter into an interactive mode"
                echo "       (which is recomended for at least the first few usages)"
                echo " "
                echo "OPTIONS:"
                echo "    -a --add <arg> add a path to fish_user_paths"
                echo "    -d --delete <index> delete a path from fish_user_paths BASED ON INDEX. Not sure of the index?"
                echo "                        Run `salmon_cannon` (no options) and it will display the list"
                echo "    -l --list displays the current fish_user_paths in a list format"
                echo "    -h --help shows this help"
            case '*'
                print_fish_user_paths
                display_options
        end
    end
end
