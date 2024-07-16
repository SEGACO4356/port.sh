# Port Scanner Tool

## Descripción

Esta herramienta de reconocimiento y escaneo de puertos utiliza `nmap` para identificar puertos abiertos en una dirección IP específica. Es útil para tareas de auditoría de seguridad y análisis de red, proporcionando información detallada sobre los servicios que se ejecutan en los puertos abiertos de un host.

## Requisitos

- [nmap](https://nmap.org) debe estar instalado en tu sistema.
- Bash Shell.

## Instalación

1. Clona este repositorio:

    ```sh
    git clone https://github.com/SEGACO4356/port.sh.git
    cd port.sh
    ```

2. Asegúrate de que el script tiene permisos de ejecución:

    ```sh
    chmod +x ports.sh
    ```

## Uso

Ejecuta el script `ports.sh` proporcionando una dirección IP como argumento:

```sh
./ports.sh
