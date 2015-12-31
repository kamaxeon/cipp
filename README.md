# Control de Internet para Padres Preocupados

Introducción
------------

La motivación de este proyecto ha surgido con una charla con un familiar para disponer de un sistema de despliegue casero y fácil, con el fin de controlar la navegación de los miembros más jovenes de la casa.

Una cosa que no me apetece es entrar en temas morales, y entiendo que la mejor medida para proteger a los niños es la educación, pero también entiendo que hay padres que no se sientan seguros y quieran tener un control.

El hecho que se despliegue de forma fácil no quiere decir que no sea friki :-), aunque el despliegue no lo voy a hacer en una [raspberry pi](http://www.raspberrypi.org), pienso que es el dispositivo perfecto para desplegar el proyecto, apenas consume y es barato de montar.

La solución se basa en una serie de componentes que pasaré a describir.

Componentes
-----------

## Ubuntu

Por ser una de las distribucciones más usadas se ha elegido, aunque también se podía haber elegido otras como CentOS, OpenSuse ...., en esta distro se montarán todos los componentes.

## OpenDNS

OpenDNS es una empresa que ofrece un servicio en internet francamente bueno y no necesitas nada para ponerlo en marcha, simplemente es darse de alta y configurar los equipos de casa con esas DNS y automáticamente puedes evitar que se vean páginas de contenido no apropiado. Pero nada impide a un menor buscar la palabra porno en google y pulsar sobre imágenes :-(. En su versión gratuita puedes instalar un agente parecido a dyndns en un pc de casa y tendrías unas estadísticas globales de la red de casa.

En Ubuntu tendremos nuestro cliente registrado de OpenDNS y usaremos esas DNS para poder tener unas estadísticas de navegación globales en el internet.

## Postfix

Como necesitaremos enviar notificaciones por otros componentes de la solución necesitaremos un servicio de envio de correo, se ha elegido Postfix por haber mucha documentación en internet y ser fácilmente configurable.

Para evitar que nuestros envíos no lleguen correctamente por ser marcados como spam, se hará a traves de una cuenta de correo de una empresa que preste correo en la nube, es decir, nuestro servidor de correo se autenticará contra otro para hacer el envio.

Para hacerlo lo más genérico posible, se ha pensado usar con una cuenta de gmail, sólo necesitas crear una nueva cuenta de gmail para que te lleguen los avisos ;-)

## Monit

Este componente se encargará de monitorizar como se encuentra nuestro ubuntu y enviarnos alertas cuando algo no esté funcionando de la forma correcta he incluso hacer acciones correctivas.

## Squid

En el componente principal de la solución y nos hace de proxy para http y https de los equipos que deseemos.

## Danguardian

Nos ayuda a tener un listado de sitios permitidos y prohibidos que se actualizan de forma genérica.


## Sarg

En el principal componente que usarán los padres o tutores, y ahí prodrán ver los registros de navegación.

## Router `inteligente`

Para que sea todo `automático` es necesario disponer de un router que mande las peticiones de navegación hacia el Squid que estará montado en nuestra ubuntu, yo eń mi caso utilizaré un MikroTik para poder redigirir todo el tráfico. 

Sino se dispone se podría hacer de forma manual configurando el proxy en los equipos de usen los menores, pero ya no sería tan mágico.

## Nginx

  Para poder ver las estadísticas es necesario disponer de un servidor web, se ha elegido nginx por ser muy ligero y fácil de configurar, aunque no se descarta cambiarlo a [lighttpd](https://www.lighttpd.net/) en un futuro

Implementación
--------------

Aquí viene la parte más friki (la que más me gusta), para desplegar todo en nuestro sistema usaremos ansible que es un producto que nunca he usado, he oído cosas buenas de él, y me apetece hacer una pequeña inmersión, y para proyectos como éste que es un simple despliegue y nada más, encaja como una guante.

Para el desarrollo del mismo se apoya sobre [vagrant](http://www.vagrantup.com) para que sea lo más rápido y ágil posible.

Como herramienta para los test se usará server-spec, aunque me gustaría buscar una alternativa en python que es el lenguaje en el que está escrito ansible.

¿ Cómo probarlo ?
-----------------

Para probarlo solo debes clonar el proyecto y ejecutar vagrant up, con esto ya deberías tener la máquina virtual de pruebas funcionando, ahora sólo te queda cambiar tu navegador y poner el proxy a 127.0.0.1:8080

Instalación
-----------

Todavía está en desarrollo y no se ha preparado la instalación oficial, pero son playbooks de ansible con lo cual es muy muy fácil.

Autores
-------

* Antonio Masdías (amasdias@gmail.com)
* Israel Santana (isra@miscorreos.org)
