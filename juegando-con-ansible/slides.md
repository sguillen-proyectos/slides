
# ![](ansible.png) 
# "Juegando" con Ansible
##### Automatización o muerte :v
###### [@donkeysharp](https://twitter.com/donkeysharp)


---

## Antes que nada, la documentación se encuentra en:

[http://docs.ansible.com](http://docs.ansible.com)

## Otros sitios de mucha ayuda son los issues en GitHub:

[https://github.com/ansible/ansible/issues](https://github.com/ansible/ansible/issues)

---

# ¿Ansible:confounded:?
* Configuration Management
* Deployment de aplicaciones
* Utiliza YAML para definir las acciones
* Descentralizado 
  * No Agentes(Chef, Puppet, otros)
* No esta casado con una distro específica
* Hace todo por SSH
* Versionable
* Hecho en Python :heart:
* FOSS (Free and Open-Source Software)

---

# Instalación
Requisitos:
* Python 2.6+

```shell
$ pip install ansible
```

---

<center><h1>Todo se realiza en base a <span style="color: #3272DB">"tasks"</span></h1></center>

Un `task` es una acción a realizarse: crear un archivo, instalar un paquete, crear un enlace simbólico, etc.

Un `task` llega a ser una acción y el `module` llega a ser la herramienta que  nos ayudará a realizar esa acción.

---
# Términos importantes
* **Modules**
* Inventory
* Playbook
* Variables
* Roles

---
# Modules
Ansible cuenta con más de 720 módulos. Estos módulos se agrupan por tipos:
* Files Modules
* Packaging Modules
* System Modules
* Notification Modules
* Database Modules
* Otros

---
# Términos importantes
* Modules
* **Inventory**
* Playbook
* Variables
* Roles
---
# Inventory

```yml
web.ejemplo.com ansible_user=ansible \
ansible_password=flisol2017 \
become_password=flisol2017

db.ejemplo.com ansible_user=ansible \
ansible_password=flisol2017 \
become_password=flisol2017
```

---

# Inventory

```yml
[web]
web-01.ejemplo.com ansible_user=ansible \
ansible_password=flisol2017 \
become_password=flisol2017

web-02.ejemplo.com ...

[database]
db.ejemplo.com ansible_user=ansible \
ansible_password=flisol2017 \
become_password=flisol2017
```
---
# Términos importantes
* Modules
* Inventory
* **Playbook**
* Variables
* Roles
---
# Playbooks
Describen la forma en como se ejecutaran una serie de `tasks` en diferentes hosts definidos en nuestro `inventory`

---

# Un ejemplo rápido

---
```yml
---
# -hosts: all,web,database,localhost,192.168.1.123
- hosts: all
  become: True
  tasks:
    - name: Crear directorio foobar
      file:
        path: /tmp/foobar
        state: directory
        mode: 0755
        owner: ansible
        group: ansible
```
Equivalente a:
```shell
$ mkdir -p /tmp/foobar \
  && chmod 0755 /tmp/foobar \ 
  && chown ansible:ansible /tmp/foobar
```
---
# Términos importantes
* Modules
* Inventory
* Playbook
* **Variables**
* Roles
---
# Variables
Nuestros playbooks no siempre tendrán la misma información, por ejemplo las credenciales de un entorno de prueba serán diferentes a un entorno de producción. Las variables en Ansible nos proveen una forma flexible para trabajar con datos que serán diferentes en el tiempo. Algo importante es que estas variables pueden ser sobre escritas dependiendo el orden de procedencia.

---
# Términos importantes
* Modules
* Inventory
* Playbook
* Variables
* **Roles**
---
# Roles
Nos permiten tener organizados nuestros playbooks. En muchos se llegará al punto que existe código repetido :mask:. Es aquí que entran los roles a para crear código reutilizable.

---

# ¿Cómo ejecutar todo esto?
```
$ ansible-playbook -i inventory/inventory.yml \
playbook.yml
```

---

# DEMO 

---
# :sleeping:
# Muchas gracias...

---
```
Email:    serguimant@gmail.com
GitHub:   donkeysharp
Twitter:  @donkeysharp
Telegram: @foobarken
```
