# Optimizando Imágenes Docker
###### Sergio Guillén Mantilla
###### @donkeysharp

`:() { :|:& }; :`

---

<!-- 
TODO: 
para el público:
+ provisionar 10 servidores con docker instalado
+ tener descargado gitbash para windows por si acaso :)
+ dar acceso a los servidores

* Mi necesidad?
* alpine
  * musl
  * glibc
* Recordando los layers en Docker
* recomendaciones generales
  * encadenar cosas en run
  * borrar cache
  * imagenes base
* Creando Dockerfiles (debian, alpine)
  * caso python
  * cosas para postgresql  
  * caso java
-->
# Agenda
* Mi necesidad
* Alpine
* Layers en Docker
* Reduciendo una imágen Docker

---
# Mi necesidad

`no space left on device`

### Una solución correcta por una razón incorrecta

|Antes|Después|
|:-:|:-:|
| Basada en Debian | Basada en Alpine|
|`FROM tomcat:7.0-jre8`|`FROM tomcat:7.0-jre8-alpine`|


---
<center>

# ![](alpine.png)
<h1>Alpine</h1>

</center>

---
# Alpine
Alpine es una distro GNU/Linux

* Musl (libc)
* Busybox
* Gestor de paquetes

```
$ apk update \
  && apk add bash jq curl
  && apk del jq bash
```
---
# Layers en Docker

---
# Layers en Docker
<!--
https://docs.docker.com/engine/userguide/storagedriver/imagesandcontainers/#related-information
-->
Una imágen Docker está compuesta por una serie de layers
```
FROM ubuntu:15.10
COPY . /app
RUN make /app
CMD python /app/app.py
```

---
# ![](layers1.jpg)

---
# ¿Y por qué nos interesa esto?

 ```
 $ docker pull jenkins:2.46.2
 $ docker pull jenkins:2.46.2-alpine
 ```

---

```
$ docker pull jenkins:2.46.2
10a267c67f42: Extracting
fb5937da9414: Download complete 
9021b2326a1e: Download complete 
8c6c40e9ec4f: Download complete 
7a63e1725461: Download complete 
79e8ed83f43a: Download complete 
161cbb85a481: Download complete 
a479609da9c8: Download complete 
e32f81724ea4: Download complete 
01f94cc7c760: Download complete 
eaab3977dfc1: Download complete 
ea9c5bd17543: Download complete 
8d4dea85f623: Download complete 
92b5ef980853: Download complete 
df54c33bed24: Download complete 
115a9ce3739e: Download complete 
82fb0b8c5d89: Download complete 
f9d8ee7cb2ed: Download complete 
8796fd84a6ed: Download complete 
1573f34dbac2: Download complete
```
---
```
$ docker pull jenkins:2.46.2-alpine
cfc728c1c558: Pull complete 
5b12b87f0a0e: Pull complete 
b7d6497a92f9: Extracting 
560053ce286f: Download complete 
62ab43f5fe1a: Download complete 
09fe1e20c2cb: Download complete 
a6eb45a51841: Download complete 
d58d23391729: Download complete 
4a2cb50f8c69: Download complete 
24ff401053f2: Download complete 
ad8767245015: Download complete 
f73dcea8d06c: Download complete 
e6e9b53c8e46: Download complete 
4e1d583a6678: Download complete 

```
---

# A más layers 
# el tiempo de hacer pull/build/push
# es más largo

---
# Reduciendo una imágen Docker

---
# Reduciendo una imágen Docker
<!--
* recomendaciones generales
  * borrar cache
  * imagenes base
-->
* De ser posible poner todo en una instrucción **RUN**
```
FROM alpine
RUN apk update \
    && apk add paquete1 paquete2 paquete3 ...
```
---
# Reduciendo una imágen Docker
* Dependiendo del gestor de paquete o gestor de librerías ver donde se encuentra su cache o ver la opción para evitar la cache

```
$ rm -rf /var/cache/apk/* # Para apk
$ apk add --no-cache <paquete> # Para apk
$ rm -rf $HOME/.pip # Para python-pip
$ rm -rf $HOME/.npm # Para nodejs npm
$ rm -rf $HOME/.config/composer # Para php composer
```

---
# Tener cuidado en el orden de las instrucciones

```
FROM alpine
COPY archivo_que_cambia.sh /root
RUN comandos que toman mucho tiempo
...
```
contra
```
FROM alpine
RUN comandos que toman mucho tiempo
COPY archivo_que_cambia.sh /root
...
```
---
# Usar imagenes base
```
FROM openjdk:8-jre-alpine
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME
# let "Tomcat Native" live somewhere isolated
ENV TOMCAT_NATIVE_LIBDIR $CATALINA_HOME/native-jni-lib
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}$TOMCAT_NATIVE_LIBDIR
RUN apk add --no-cache gnupg
# see https://www.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/KEYS
# see also "update.sh" (https://github.com/docker-library/tomcat/blob/master/update.sh)
ENV GPG_KEYS 05AB33110949707C93A279E3D3EFE6B686867BA6 07E48665A34DCAFAE522E5E6266191C37C037D42 47309207D818FFD8DCD3F83F1931D684307A10A5 541FBE7D8F78B25E055DDEE13C370389288584E7 61B832AC2F1C5A90F0F9B00A1C506407564C17A3 713DA88BE50911535FE716F5208B0AB1D63011C7 79F7026C690BAA50B92CD8B66A3AD3F4F22C4FED 9BA44C2621385CB966EBA586F72C284D731FABEE A27677289986DB50844682F8ACB77FC2E86E29AC A9C5DF4D22E99998D9875A5110C01C5A2F6059E7 DCFD35E0BF8CA7344752DE8B6FB21E8933C60243 F3A04C595DB5B6A5F1ECA43E3B7BBB100D811BBE F7DA48BB64BCB84ECBA7EE6935CD23C10D498E23
SION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz
...
EXPOSE 8080
CMD ["catalina.sh", "run"]

COPY ./hello-world.war /usr/local/tomcat/webapps
```

---
# Usar imagenes base
```
FROM tomcat:7.0-jre8-alpine

COPY ./hello-world.war /usr/local/tomcat/webapps
```


---
# Otras recomendaciones
* Utilizar `ONBUILD`
* Para archivos grandes mejor descargarlas

---
<center>
<img src="thats_all_folks.jpg" />
</center>