# Wireless Network Expert System

A CLIPS-based expert system for diagnosing and providing recommendations for Wi-Fi network connectivity issues.

## Overview

This expert system analyzes various Wi-Fi connected devices and their network conditions to provide diagnostic information and recommendations for improving wireless connectivity. It takes into account factors such as:

- Signal strength
- Distance from router
- Interference levels
- Wi-Fi band (2.4GHz vs 5GHz)
- Connection status

## Features

- Diagnoses connection issues for multiple devices
- Provides specific recommendations based on device conditions
- Analyzes optimal band selection (2.4GHz vs 5GHz)
- Monitors signal strength and distance thresholds
- Evaluates interference levels

## System Requirements

- CLIPS (C Language Integrated Production System) environment
- Any CLIPS-compatible IDE or command-line interface

## Usage

1. Start CLIPS environment
2. Load the expert system:
```bash
(load "wireless-expert.clp")
```
3. Reset the system:
```bash
(reset)
```
4. Run the analysis:
```bash
(run)
```

## Rule set

The system includes multiple diagnostic rules:

- Device connectivity check
- Signal strength analysis
- Distance-based recommendations
- Interference detection
- Band selection optimization
- Connection quality assessment


## Input Data Structure

Each device is represented with the following attributes:

- id: Device identifier
- ssid: Network name
- connected: Connection status (yes/no)
- intensidad: Signal strength (0-100)
- banda: Wi-Fi band (2.4GHz/5GHz)
- distancia: Distance from router (meters)
- interferencia: Interference level (baja/media/alta)
