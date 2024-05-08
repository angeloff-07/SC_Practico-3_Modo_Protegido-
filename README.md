# Trabajo Practico N°3 Modo Protegido

## Integrantes:

* Santiago Colque
* Joaquin Pary
* Jorge Angeloff

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


### ¿Qué es Converged Security and Management Engine (CSME), the Intel Management Engine BIOS Extension (Intel MEBx)?

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

## Linker

![hello_debug1](/img/hello_world_debug_1.png)
![hello_debug2](/img/hello_world_debug_2.png)
![hello_debug3](/img/hello_world_debug_3.png)
### ¿Que es un linker? ¿que hace ? 
Un linker es un programa que se utiliza en el proceso de compilación de programas de computadora. Este toma uno o mas archivos objeto, generados por un compilador o ensabmlador en el proceso de compilacion, y los combina para formar un archivo ejecutable o una biblioteca.

![Linker svg](https://github.com/angeloff-07/SC_Practico-3_Modo_Protegido-/assets/84982752/c9b4a8a6-e63f-4a47-83d5-ddd6715afd2a)


### ¿Que es la dirección que aparece en el script del linker?¿Porqué es necesaria ?
La dirección que aparece en el script del linker, denominada Load Address, es la ubicación de memoria donde se cargará el programa ejecutable o la biblioteca en la memoria del sistema cuando se ejecute. Hace falta esta direccion para asegurar que el programa se cargue correctamente y se ejecute sin conflictos con otras partes del sistema.

### Compare la salida de objdump con hd, verifique donde fue colocado el programa dentro de la imagen
![hd_vs_objdump](/img/hd_vs_objdump.png)
La diferencia entre usar `hd` o usar `objdump` radica en la forma que se muestra la informacion, `objdump` es una herramienta que desensambla archivos `elf` (Executable and Linkable Format). Con la flag `-d` se puede desensamblar en leguaje `assembler` con su correspondien valor en `hexadecimal` por lo que es util para ver la instrucciones que se ejecutaran y seguir el flujo del programa.

En cambio `hd` muestra los archivos binarios en formato `hexadecimal` y `ASCII`. Al usarlo con el mismo archivo `.elf` se puede ver la representacion en `hex` de los bytes que componen el archivo.

Comparando ambos se puede ver donde fue colocado el programa dentro de la imagen, va desde la direccion `0x00000c00` hasta la `0x00000c39` y de ahi solo se ve `66` `90` que corresponde a un `nop` (No Operation). Es decir, La secuencia de intrucciones en `hexadecimal` es la siguente:

`fa` `ea` `06` `7c` `00` `00` `31` `c0` ............ `72` `6c` `64` `00` 
### ¿Para que se utiliza la opcion --oformat binary en el linker
Esta opcion indica al linker que debe producir un archivo de salida en formato binario. En este caso, se esta ensamblando y enlazando un programa de arranque para el sector de arranque del BIOS, este formato es apropiado ya que el sector de arranque del DIO debe ser una imagen binaria.

## Modo Protegido

### Crea un codigo assembler que pueda pasar a modo protegido (sin macros)
### ¿Cómo sería un programa que tenga dos descriptores de memoria diferentes, uno para cada segmento (código y datos) en espacios de memoria diferenciados? 
Se podria realizar definiendo 2 tablas de descriptores:
```assembler
gdt_start_code: 
gdt_null_code:
    .long 0x0
    .long 0x0
gdt_code:
    .word 0xffff     
    .word 0x0          
    .byte 0x0         
    .byte 0b10011010   
    .byte 0b11001111  
    .byte 0x0               
gdt_end_code:
gdt_descriptor_code:
    .word gdt_end_code - gdt_start_code 
    .long gdt_start_code
```
De igual manera para el `data segment`

Y luego modificando a donde apuntan:
```assembler
.code32
protected_mode:
    mov $DATA_SEG, %ax
    mov %ax, %ds
    mov $CODE_SEG, %ax
    mov %ax, %es
```
### Cambiar los bits de acceso del segmento de datos para que sea de solo lectura,  intentar escribir, ¿Que sucede? ¿Que debería suceder a continuación? (revisar el teórico) Verificarlo con gdb
Para cambiar los bits de acceso del segmento de datos para que sea de solo lectura, se debe modificar la tabla de la siguente manera:
```assembler
gdt_data:
    .word 0xffff        
    .word 0x0          
    .byte 0x0           
    .byte 0b10010000    
    .byte 0b11001111    
    .byte 0x0          
```
### En modo protegido, ¿Con qué valor se cargan los registros de segmento ? ¿Porque?

En el modo protegido, los registros de segmento (CS, DS, SS, ES, FS, GS) se cargan con selectores de segmento. Cada selector de segmento es un numero de 16 bits qeu se utiliza para indexar una tabla de descriptores de segmento, como la GDT. La razon principal de usarlos es, que proporcionan `flexibilidad` y `segurirdad` en el acceso a la memoria. Utilizando selectores de segmento, el sistema puede cambiar facilmente el mapeo de segmentos de memoria simplemente actualizando los descriptores de segmento en la GDT. Ademas que los descriptes de segmento en la GDT permiten especificar permisos de acceso para cada segmento.