# Role Name

<div align="center">
<img src="./img/work.png" width="90%" />
<br><br>
</div>

imbicile.environment

## Role Information

Add config for root and new users

## Example Playbook

```yml
---
- hosts:
    - all
  roles:
    - { role: imbicile.environment, become: true }
```

## Example Local Playbook

```yml
---
- hosts: 127.0.0.1
  connection: local
  roles:
    - { role: imbicile.environment, become: true }
```

## Example ansible.cfg

https://docs.ansible.com/ansible/2.4/intro_configuration.html

```yml
[defaults]
deprecation_warnings=False
host_key_checking = False
roles_path = roles
interpreter_python=/usr/bin/python3
ansible_python_interpreter=/usr/bin/python3
force_valid_group_names = ignore
callback_whitelist = ansible.posix.profile_tasks

gathering = smart
fact_caching = jsonfile
fact_caching_connection = cache/facts
fact_caching_timeout = 3600

[inventory]
cache = yes
cache_plugin = jsonfile
cache_connection = cache/inventory
cache_timeout = 3600

[ssh_connection]
control_path = %(directory)s/%%C
retries = 2
```

## FILES

```
.
├── ansible.cfg
├── cache
│   └── facts
├── localpool
├── playbooks
│   ├── env.yml
└── roles
    └── imbicile.environment
```

## ! ПЕРДУПРЕЖДЕНИЕ !

При физической работе в консоли символны не отображаются а git может быть не установлен

### Рекомендованная конфигурация

````bash
if [ "$(id -un)" = root ]; then
  PS1="┌ [${IRed}\u${Color_Off}][${IYellow}\H${Color_Off}][${ICyan}\w${Color_Off}]\n└─ > "
else
  PS1="┌ [${IGreen}\u${Color_Off}][${IYellow}\H${Color_Off}][${ICyan}\w${Color_Off}]\n└─ > "
fi
```bash

## Author Information

https://imbicile.pp.ru
````
