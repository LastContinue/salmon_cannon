#! /bin/env fish
function print_fish_user_paths -d "prints fish_user_paths in an easy-to-read format"
    set_color yellow
    echo "Current '\$fish_user_paths': "
    set_color normal
    echo " "
    echo $fish_user_paths | tr " " "\n" | nl
    echo " "
end
