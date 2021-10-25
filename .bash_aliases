alias cd..='cd ..'
alias mkdir='mkdir -p'
alias lla='ls -alF'

# Process management
alias psm='ps aux | awk '"'"'{print $4i"\t"$11}'"'"' | sort | uniq -c | awk '"'"'{print $2" "$1" "$3}'"'"' | sort -nr'

alias openNetworkConnections='netstat -natp'

# Calendar aliases
alias call='~/.scripts/cal.py -14'
alias calle='vi ~/.calendar/calendar'
alias callb='vi ~/.calendar/birthdays'

# Volume
alias vol='~/.scripts/volume.sh'

# Git
alias gitUserOoz='git config user.name "ooz"; git config user.email ooz@users.noreply.github.com'

alias code='codium'

# Java / Gradle / Idea
alias gw="./gradlew $@"
alias cleanIdea='rm -rf .idea/ .settings/ .classpath *.iml .project; ./gradlew cleanIdea cleanIdeaWorkspace'
alias gradleBuild='./gradlew clean build'
alias gradleBuildIdea='./gradlew clean build idea'
alias gradleIdea='./gradlew idea'
alias gradleRefresh='./gradlew build --refresh-dependencies -PrefreshDynamicDeps'
alias gradleCleanLogs="find ~/.gradle -type f -name '*.out.log' -delete"

