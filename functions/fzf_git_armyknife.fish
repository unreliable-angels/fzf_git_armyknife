function __fzf_git_armyknife_things_you_want_to_do -d '<keys>'
    for key in $argv
        echo $key
    end
end

function fzf_git_armyknife -d 'fzf source of the swiss army knife for Git operation'
    git rev-parse --is-inside-work-tree >/dev/null 2>&1

    if not test $status -eq 0
        command echo 'fzf_git_armyknife: Not a git repository'
        commandline -f execute
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
    set k $k 'I want to find the commit which cause a particular regression'
    set v $v 'git bisect start <bad-commit> <good-commit>'
    # =========================================================================
    set k $k 'I want to get submodule in already cloned repo without "recursive"'
    set v $v 'git submodule update --init --recursive'
    # =========================================================================
    set k $k 'I want to create an empty commit'
    set v $v 'git commit --allow-empty'
    # =========================================================================
    set k $k 'I want to rebase a branch onto another one'
    set v $v 'git rebase --onto <new-base> <current-base> <branch>'
    # =========================================================================
    set k $k 'I want to checkout origin master branch to local with new name'
    set v $v 'git checkout -b <local-branch-name> origin/master'
    # =========================================================================

    __fzf_git_armyknife_things_you_want_to_do $k | fzf | read thing_you_want_to_do

    if test -n "$thing_you_want_to_do"
        if set -l index (contains -i -- "$thing_you_want_to_do" $k)
            commandline $v[$index]
        end
    end
end
