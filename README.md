# Role Name

<a href="./assets/logo">
  <img src="./img/work.png" width="20%" />
</a>
<br><br>

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

## Author Information

https://imbicile.pp.ru
