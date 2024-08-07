# Role Name

<div align="center">
<img src="./img/work.png" width="90%" />
<br><br>
</div>

imbicile.environment

## Role Information

Add config for root and new users

## Role vars

```yml
# Вид строки bash
# Возможные варианты
# modern - стиль со значками без фона
# on_modern - стиль со значками с фоном
# simple - стиль без значков
# server - рекомендован для серверов
# shell - тема из imbicile/shell_colors

env_ps1_style: server
```

## Example Playbook

```yml
---
- name: Server environment
  hosts:
    - all

  vars:
    env_ps1_style: server

  roles:
    - role: imbicile.environment
      become: true
      tags: env
```

## Example Local Playbook

```yml
---
- name: Local env
  hosts: 127.0.0.1
  connection: local
  become: true

  vars:
    env_ps1_style: modern

  roles:
    - role: imbicile.environment
      tags: env
```

## Example ansible.cfg

https://docs.ansible.com/ansible/2.4/intro_configuration.html

```yml
[defaults]
deprecation_warnings=false
host_key_checking = false
inventory = inventory
roles_path = roles
collections_path = collections
interpreter_python=/usr/bin/python3
ansible_python_interpreter=/usr/bin/python3
force_valid_group_names = ignore
callbacks_enabled=ansible.posix.profile_tasks, ansible.posix.timer
forks=30
gathering = smart
fact_caching = jsonfile
fact_caching_connection = cache/facts
fact_caching_timeout = 3600
internal_poll_interval = 0.001
ansible_managed = Ansible managed: modified on %d-%m-%Y %H:%M:%S
remote_tmp = /tmp
ansible_remote_tmp = /tmp

[callback_profile_tasks]
sort_order = none
task_output_limit = 500

[inventory]
cache = true
cache_plugin = jsonfile
cache_connection = cache/
cache_timeout = 300

[ssh_connection]
control_path = %(directory)s/%%C
retries = 2
ssh_args = -o ControlMaster=auto -o ControlPersist=60s
pipelining = true
scp_if_ssh=true
```

## FILES

```bash
.
├── ansible.cfg
├── cache
│   └── facts
├── inventory
├── playbooks
│   ├── env.yml
└── roles
    └── imbicile.environment
```

## ! ПЕРДУПРЕЖДЕНИЕ !

При физической работе в консоли символны не отображаются а git может быть не установлен

### Рекомендованная конфигурация **server** , **shell** или **modern**

```bash
if [ "$(id -un)" = root ]; then
  PS1="[${IRed}\u${Color_Off}][${IYellow}\H${Color_Off}][${ICyan}\w${Color_Off}]\n# "
else
  PS1="[${IGreen}\u${Color_Off}][${IYellow}\H${Color_Off}][${ICyan}\w${Color_Off}]\n# "
fi
```

В теме **modern** реализовано переключение на основе определения tty

## Author Information

https://imbicile.pp.ru
