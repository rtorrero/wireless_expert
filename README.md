# Sistema Experto de Redes Inalámbricas

Un sistema experto basado en CLIPS para diagnosticar y proporcionar recomendaciones para problemas de conectividad de redes Wi-Fi.

## Descripción General

Este sistema experto analiza varios dispositivos conectados a Wi-Fi y sus condiciones de red para proporcionar información de diagnóstico y recomendaciones para mejorar la conectividad inalámbrica. Tiene en cuenta factores como:

- Fuerza de la señal
- Distancia del enrutador
- Niveles de interferencia
- Banda Wi-Fi (2.4GHz vs 5GHz)
- Estado de conexión

## Características

- Diagnostica problemas de conexión para múltiples dispositivos
- Proporciona recomendaciones específicas basadas en las condiciones del dispositivo
- Analiza la selección óptima de banda (2.4GHz vs 5GHz)
- Monitorea la fuerza de la señal y los umbrales de distancia
- Evalúa los niveles de interferencia

## Requisitos del Sistema

- Entorno CLIPS (Sistema de Producción Integrado en Lenguaje C)
- Cualquier IDE o interfaz de línea de comandos compatible con CLIPS

## Uso

1. Iniciar el entorno CLIPS
2. Cargar el sistema experto:
```bash
(load "wireless-expert.clp")

```
3. Reiniciar el sistema:
```bash
(reset)
```
4. Ejecutar el análisis:
```bash
(run)
```

## Conjunto de Reglas

El sistema incluye múltiples reglas de diagnóstico:

- Verificación de conectividad del dispositivo
- Análisis de la fuerza de la señal
- Recomendaciones basadas en la distancia
- Detección de interferencias
- Optimización de la selección de banda
- Evaluación de la calidad de la conexión


## Estructura de Datos de Entrada

Cada dispositivo se representa con los siguientes atributos:

- id: Identificador del dispositivo
- ssid: Nombre de la red
- connected: Estado de conexión (sí/no)
- intensidad: Signal strength (0-100)
- banda: Banda Wi-Fi (2.4GHz/5GHz)
- distancia: Distancia del enrutador (metros)
- interferencia: Nivel de interferencia (baja/media/alta)
