function __fzf_git_armyknife_things_you_want_to_do
    set -l k

    # =========================================================================
    set k $k 'I want to delete all branches which have been merged'
    # =========================================================================
    set k $k 'I want to view a file in a different branch without changing branches'
    # =========================================================================
    set k $k 'I want to get just one file from another branch'
    # =========================================================================

    for key in $k
        echo $key
    end
end

function fzf_git_armyknife -d 'fzf source of the swiss army knife for Git operation'
    git rev-parse --is-inside-work-tree >/dev/null ^/dev/null

    if not test $status -eq 0
        return
    end

    set -l k
    set -l v

    # =========================================================================
    set k $k 'I want to delete all branches which have been merged'
    set v $v 'git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'
    # =========================================================================
    set k $k 'I want to view a file in a different branch without changing branches'
    set v $v 'git show <branch>:<file>'
    # =========================================================================
    set k $k 'I want to get just one file from another branch'
    set v $v 'git checkout <branch> -- <file>'
    # =========================================================================

    __fzf_git_armyknife_things_you_want_to_do | fzf | read thing_you_want_to_do

    if test -n "$thing_you_want_to_do"
        if set -l index (contains -i -- "$thing_you_want_to_do" $k)
            commandline $v[$index]
        end
    end
end
