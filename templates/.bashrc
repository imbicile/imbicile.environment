#!/bin/bash
# Библиотека цветов https://wiki.archlinux.org/index.php/Bash/Prompt_customization_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)
# Функции и прочие примеры http://dotshare.it/category/shells/bash/
# Цвета папок dircolors https://github.com/trapd00r/LS_COLORS

# Сброс
Color_Off='\e[0m' # Text Reset

## Обычные цвета
Black='\e[0;30m'  # Black
Red='\e[0;31m'    # Red
Green='\e[0;32m'  # Green
Yellow='\e[0;33m' # Yellow
Blue='\e[0;34m'   # Blue
Purple='\e[0;35m' # Purple
Cyan='\e[0;36m'   # Cyan
White='\e[0;37m'  # White

## Жирные
BBlack='\e[1;30m'  # Black
BRed='\e[1;31m'    # Red
BGreen='\e[1;32m'  # Green
BYellow='\e[1;33m' # Yellow
BBlue='\e[1;34m'   # Blue
BPurple='\e[1;35m' # Purple
BCyan='\e[1;36m'   # Cyan
BWhite='\e[1;37m'  # White

## Подчёркнутые
UBlack='\e[4;30m'  # Black
URed='\e[4;31m'    # Red
UGreen='\e[4;32m'  # Green
UYellow='\e[4;33m' # Yellow
UBlue='\e[4;34m'   # Blue
UPurple='\e[4;35m' # Purple
UCyan='\e[4;36m'   # Cyan
UWhite='\e[4;37m'  # White

## Фоновые белый шрифт
On_WBlack='\e[40m'  # Black
On_WRed='\e[41m'    # Red
On_WGreen='\e[42m'  # Green
On_WYellow='\e[43m' # Yellow
On_WBlue='\e[44m'   # Blue
On_WPurple='\e[45m' # Purple
On_WCyan='\e[46m'   # Cyan
On_WWhite='\e[47m'  # White

## Фоновые черный шрифт
On_BBlack='\e[30;40m'  # Black
On_BRed='\e[30;41m'    # Red
On_BGreen='\e[30;42m'  # Green
On_BYellow='\e[30;43m' # Yellow
On_BBlue='\e[30;44m'   # Blue
On_BPurple='\e[30;45m' # Purple
On_BCyan='\e[30;46m'   # Cyan
On_BWhite='\e[30;47m'  # White

## Высоко Интенсивные
IBlack='\e[0;90m'  # Black
IRed='\e[0;91m'    # Red
IGreen='\e[0;92m'  # Green
IYellow='\e[0;93m' # Yellow
IBlue='\e[0;94m'   # Blue
IPurple='\e[0;95m' # Purple
ICyan='\e[0;96m'   # Cyan
IWhite='\e[0;97m'  # White

## Жирные Высоко Интенсивные
BIBlack='\e[1;90m'  # Black
BIRed='\e[1;91m'    # Red
BIGreen='\e[1;92m'  # Green
BIYellow='\e[1;93m' # Yellow
BIBlue='\e[1;94m'   # Blue
BIPurple='\e[1;95m' # Purple
BICyan='\e[1;96m'   # Cyan
BIWhite='\e[1;97m'  # White

## Высоко Интенсивные фоновые
On_IBlack='\e[0;100m'  # Black
On_IRed='\e[0;101m'    # Red
On_IGreen='\e[0;102m'  # Green
On_IYellow='\e[0;103m' # Yellow
On_IBlue='\e[0;104m'   # Blue
On_IPurple='\e[0;105m' # Purple
On_ICyan='\e[0;106m'   # Cyan
On_IWhite='\e[0;107m'  # White

# Задаем параметры истории и отображения
HISTCONTROL=ignoreboth:erasedups
PROMPT_COMMAND='history -a'
HISTSIZE=100000
HISTFILESIZE=30000

shopt -s histappend   # история команд будет добавлена в файл $HISTFILE
shopt -s checkwinsize # обновляет переменные LINES
shopt -s cmdhist      # все строки многострочной команды как одна в истории
shopt -s autocd       # переход в каталог без cd
unset MAILCHECK       # отключить инфломацию о почте

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Автодополнение bash-completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    # shellcheck source=/dev/null
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    # shellcheck source=/dev/null
    . /etc/bash_completion
  fi
fi

# Пути до исполняемых файлов профиля ~/.bin
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

# Пути до исполняемых файлов профиля ~/.local/bin
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

# Включаем дополнительный файл алисов если такой есть ~/.bashrc_aliases
if [ -f "$HOME/.bashrc_aliases" ]; then
  # shellcheck source=/dev/null
  . "$HOME/.bashrc_aliases"
fi

{% if env_ps1_style == "modern" %}
# Конфигурация для локльного ПК с git
parse_git_branch() {
  git branch 2>/dev/null | grep "\*" | awk '{print " 🛠  "$2" "}'
}
show_git="${On_BPurple}\$(parse_git_branch)${Color_Off}"

# Задаем приглашение для пользователя и опеределение рута
if [ "$(id -un)" = root ]; then
  PS1="┌ ${On_BRed} 🔓 \u ${Color_Off}${On_BYellow} 💻 \H ${Color_Off}${On_BCyan} 📂 \w ${Color_Off}${show_git}\n└─ > "
else
  PS1="┌ ${On_BGreen} 🏠 \u ${Color_Off}${On_BYellow} 💻 \H ${Color_Off}${On_BCyan} 📂 \w ${Color_Off}${show_git}\n└─ > "
fi
{% endif %}
{% if env_ps1_style == "simple" %}
# Конфигурация без значков
parse_git_branch() {
  git branch 2>/dev/null | grep "\*" | awk '{print "~>["$2"]"}'
}
show_git="${IPurple}\$(parse_git_branch)${Color_Off}"

if [ "$(id -un)" = root ]; then
  PS1="┌─╼[${IRed}\u${Color_Off}]╾╼[${IYellow}\H${Color_Off}]╾╼[${ICyan}\w${Color_Off}]${show_git}\n└───╼ "
else
  PS1="┌─╼[${IGreen}\u${Color_Off}]╾╼[${IYellow}\H${Color_Off}]╾╼[${ICyan}\w${Color_Off}]${show_git}\n└───╼ "
fi
{% endif %}
{% if env_ps1_style == "shell" %}
# Конфигурация imbicile/shell_colors 
parse_git_branch() {
  git branch 2>/dev/null | grep "\*" | awk '{print "["$2"]"}'
}
show_git="${On_Purple}\$(parse_git_branch)${Color_Off}"

# Задаем приглашение для пользователя и опеределение рута
if [ "$(id -un)" = root ]; then
  PS1="┌ [${IRed}\u${Color_Off}][${IYellow}\H${Color_Off}][${ICyan}\w${Color_Off}]$show_git\n└─ > "
else
  PS1="┌ [${IGreen}\u${Color_Off}][${IYellow}\H${Color_Off}][${ICyan}\w${Color_Off}]$show_git\n└─ > "
fi
{% endif %}
{% if env_ps1_style == "server" %}
# Конфигурация для серверов.
if [ "$(id -un)" = root ]; then
  PS1="[${IRed}\u${Color_Off}][${IYellow}\H${Color_Off}][${ICyan}\w${Color_Off}]\n# "
else
  PS1="[${IGreen}\u${Color_Off}][${IYellow}\H${Color_Off}][${ICyan}\w${Color_Off}]\n# "
fi
{% endif %}

# Предотвращает случайное удаление файлов.
alias mkdir='mkdir -p'

# Подключаем dircolors
if [ -x /usr/bin/dircolors ]; then
  if [ -r ~/.dircolors ]; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi

  # Цвета auto
  alias ls='ls --color=auto'
  alias dmesg='dmesg --color=auto'
  alias gcc='gcc -fdiagnostics-color=auto'
  alias dir='dir --color=auto'
  alias diff='diff --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Раскрашиваем man
export LESS_TERMCAP_mb=$'\e[0;36m' # начало мигания (Cyan)
export LESS_TERMCAP_md=$'\e[1;36m' # начало жирного шрифта (BCyan)
export LESS_TERMCAP_me=$'\e[0m'    # сброс (Color_Off)
export LESS_TERMCAP_se=$'\e[0m'    # сброс выделения (Color_Off)
export LESS_TERMCAP_so=$'\e[0;36m' # начало выделения - информация (Cyan)
export LESS_TERMCAP_ue=$'\e[0m'    # конец подчеркивания (Color_Off)
export LESS_TERMCAP_us=$'\e[0;93m' # начало подчеркивания (IYellow)

# Алиасы LS
alias ll='ls -alF'      # показать скрытые файлы с индикатором
alias la='ls -Al'       # показать скрытые файлы
alias lx='ls -lXB'      # сортировка по расширению
alias lk='ls -lSr'      # сортировка по размеру
alias lc='ls -lcr'      # сортировка по времени изменения
alias lu='ls -lur'      # сортировка по времени последнего обращения
alias lr='ls -lR'       # рекурсивный обход подкаталогов
alias lt='ls -ltr'      # сортировка по дате
alias lm='ls -al |more' # вывод через 'more'

# Цветной cat
# Посмотреть все стили
# pygmentize -L styles --json | jq
alias ccat='pygmentize -g -O full,style=dracula'

# Цветные команды
alias ping="grc --colour=auto ping"
alias traceroute="grc --colour=auto traceroute"
alias netstat="grc --colour=auto netstat"
alias stat="grc --colour=auto stat"
alias ss="grc --colour=auto ss"
alias diff="grc --colour=auto diff"
alias wdiff="grc --colour=auto wdiff"
alias last="grc --colour=auto last"
alias mount="grc --colour=auto mount"
alias ps="grc --colour=auto ps"
alias dig="grc --colour=auto dig"
alias ifconfig="grc --colour=auto ifconfig"
alias mount="grc --colour=auto mount"
alias df="grc --colour=auto df"
alias du="grc --colour=auto du"
alias ip="grc --colour=auto ip"
alias env="grc --colour=auto env"
alias iptables="grc --colour=auto iptables"
alias lspci="grc --colour=auto lspci"
alias lsblk="grc --colour=auto lsblk"
alias lsof="grc --colour=auto lsof"
alias blkid="grc --colour=auto blkid"
alias id="grc --colour=auto id"
alias fdisk="grc --colour=auto fdisk"
alias free="grc --colour=auto free"
alias systemctl="grc --colour=auto systemctl"
alias journalctl="grc --colour=auto journalctl"
alias sysctl="grc --colour=auto sysctl"
alias tcpdump="grc --colour=auto tcpdump"
alias tune2fs="grc --colour=auto tune2fs"
alias lsmod="grc --colour=auto lsmod"
alias lsattr="grc --colour=auto lsattr"
alias nmap="grc --colour=auto nmap"
alias uptime="grc --colour=auto uptime"
alias getfacl="grc --colour=auto getfacl"
alias iwconfig="grc --colour=auto iwconfig"
alias whois="grc --colour=auto whois"

# Функция распаковки extract
function extract {
  if [ -z "$1" ]; then
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
  else
    if [ -f "$1" ]; then
      case "$1" in
      *.tar.bz2) tar xvjf ./"$1" ;;
      *.tar.gz) tar xvzf ./"$1" ;;
      *.tar.xz) tar xvJf ./"$1" ;;
      *.lzma) unlzma ./"$1" ;;
      *.bz2) bunzip2 ./"$1" ;;
      *.rar) unrar x -ad ./"$1" ;;
      *.gz) gunzip ./"$1" ;;
      *.tar) tar xvf ./"$1" ;;
      *.tbz2) tar xvjf ./"$1" ;;
      *.tgz) tar xvzf ./"$1" ;;
      *.zip) unzip ./"$1" ;;
      *.Z) uncompress ./"$1" ;;
      *.7z) 7z x ./"$1" ;;
      *.xz) unxz ./"$1" ;;
      *.exe) cabextract ./"$1" ;;
      *) echo "extract: '$1' - неизвестный архив" ;;
      esac
    else
      echo "$1 - файл не существует"
    fi
  fi
}
