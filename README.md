# Trabajo Practico N°3 Modo Protegido

### Integrantes:

* Santiago Colque
* Joaquin Pary
* Jorge Angeloff

## Resumen

## Desafio UEFI y coreboot
### ¿Qué es UEFI? ¿como puedo usarlo? Mencionar además una función a la que podría llamar usando esa dinámica.  

La UEFI (Interfaz de Firmware Extensible Unificado) es una especificacion (conjunto de normas y directrices) que define una interfaz entre el sistema operativo y el firmware.

Para usar UEFI generalmente no hace falta mucho trabajo, ya que esta interfaz se encarga del proceso de inicio y de establecer la comunicación inicial entre el hardware y el sistema operativo. Sin embargo uno tiene la opción de acceder a la configuración de UEFI durante el arranque de su computadora. Para esto, hace falta reiniciarla y durante el inicio, presionar la tecla especifica del equipo (F2, F10, F12, Escape,etc.) para acceder al menú de configuración de UEFI. 

Una función específica a la que se puede  acceder a través de esta configuración es el "Secure Boot" (Arranque Seguro). Esta característica de seguridad sirve para prevenir la carga de software no autorizado durante el proceso de inicio. Desde la configuración de UEFI,se puede habilitar o deshabilitar Secure Boot y preferencias de seguridad,según sea necesario. 

### Menciona casos de bugs de UEFI que puedan ser explotados

* Vulnerabilidad de sobreescritura de memoria: Permitía a un atacante sobrescribir la memoria durante el arranque del sistema, lo que podría conducir a la ejecución de código malicioso.

* Desbordamiento de búfer en bibliotecas de UEFI: Se han reportado casos de desbordamiento de búfer en bibliotecas de código abierto utilizadas en UEFI, lo que podría permitir la ejecución de código arbitrario.

* Vulnerabilidad de escalada de privilegios en interfaces de gestión: Algunas implementaciones de UEFI han sido afectadas por vulnerabilidades que permiten a los atacantes obtener acceso privilegiado al sistema.

* Bugs en la implementación de Secure Boot: Se han encontrado bugs que afectan la implementación de Secure Boot, lo que puede resultar en problemas de compatibilidad y vulnerabilidades que permiten cargar código no autorizado durante el arranque.

* Vulnerabilidades en protocolos de red implementados en UEFI: Algunas implementaciones de UEFI han sido afectadas por vulnerabilidades en protocolos de red, lo que podría permitir ataques remotos durante el arranque del sistema.



###  ¿Qué es Converged Security and Management Engine (CSME), the Intel Management Engine BIOS Extension (Intel MEBx)?

El CSME es un componente ubicado en el procesador, que cumple funciones relacionadas con la seguridad y gestion de plataformas de hardware. Por ejemplo, puede administrar de forma remota el sistema, autenticar el SecureBoot o prevenir ataques de firmware. Todo esto desde el mismo hardware independientemente del sistema operativo.

Intel MEBx es una extencion del BIOS que le proporciona al usuario una interfaz para configurar y administrar algunas funciones de la Intel ME al arrancar el sistema. Este chip basicamente controla el procesador y cabe recalcar que no se tiene informacion suficiente brindada por Intel, ademas de que su firmware esta protegido.


### ¿Qué es coreboot? ¿Qué productos lo incorporan? ¿Cuales son las ventajas de su utilización?

Coreboot es un proyecto de firmware de código abierto diseñado para reemplazar el BIOS o UEFI tanto en computadoras como en otros dispositivos electrónicos. Algunos productos que lo utilicen son:

* Dispositivos embebidos, como enrutadores, dispositivos IoT y sistemas de almacenamiento en red.
* Placas base de codigo abierto, Fundacion RISC-V por ejemplo.
* Google Chromebook.

Las ventajas que posee frente a BIOS y UEFI:

* Codigo abierto y transparencia, al tener su codigo fuente disponible para que cualquiera pueda leerlo y modificarlo se vuelve posible que la seguridad de este mejore gracias a su comunidad.
* Arranque rapido, uno mas rapido y optimizado, lo que tambien lo vuelve mas eficiente.
* Flexibilidad y personalizacion, es compatible con gran cantidad de hardware y su firmware es configurable a gusto del usuario.

## Desafio Linker

### ¿Que es un linker? ¿que hace ? 
Un linker es un programa que se utiliza en el proceso de compilación de programas de computadora. Este toma uno o mas archivos objeto, generados por un compilador o ensabmlador en el proceso de compilacion, y los combina para formar un archivo ejecutable o una biblioteca.

![Linker svg](https://github.com/angeloff-07/SC_Practico-3_Modo_Protegido-/assets/84982752/c9b4a8a6-e63f-4a47-83d5-ddd6715afd2a)


### ¿Que es la dirección que aparece en el script del linker?¿Porqué es necesaria ?
La dirección que aparece en el script del linker, denominada Load Address, es la ubicación de memoria donde se cargará el programa ejecutable o la biblioteca en la memoria del sistema cuando se ejecute. Hace falta esta direccion para asegurar que el programa se cargue correctamente y se ejecute sin conflictos con otras partes del sistema.

### ¿Para que se utiliza la opcion --oformat binary en el linker
Esta opcion indica al linker que debe producir un archivo de salida en formato binario. En este caso, se esta ensamblando y enlazando un programa de arranque para el sector de arranque del BIOS, este formato es apropiado ya que el sector de arranque del DIO debe ser una imagen binaria.

## Desafio Modo Protegido

