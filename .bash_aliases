# cd aliases
alias cd..='cd ..'

alias mkdir='mkdir -p'

# ls aliases
alias lla='ls -alF'

# Process management
alias psm='ps aux | awk '"'"'{print $4i"\t"$11}'"'"' | sort | uniq -c | awk '"'"'{print $2" "$1" "$3}'"'"' | sort -nr'

# Calendar aliases
alias call='~/.script/cal.py -14'
alias calle='vi ~/.calendar/calendar'
alias callb='vi ~/.calendar/birthdays'

# Volume
alias vol='~/.script/volume.sh'

# Git
alias gitUserOoz='git config user.name "ooz"; git config user.email ooz@users.noreply.github.com'

# Java / Gradle / Idea
alias gw="./gradlew $@"
alias cleanIdea='rm -rf .idea/ .settings/ .classpath *.iml .project; ./gradlew cleanIdea cleanIdeaWorkspace'
alias gradleBuild='./gradlew clean build'
alias gradleBuildIdea='./gradlew clean build idea'
alias gradleIdea='./gradlew idea'
alias gradleRefresh='./gradlew build --refresh-dependencies -PrefreshDynamicDeps'

