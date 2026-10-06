# STM32 Data Acquisition Firmware

This directory contains the C/Embedded C firmware for the STM32 microcontroller, designed for real-time data acquisition and transmission during testbench operations.

### Key Technical Features:
- **Periodic ADC Sampling:** Configured timer interrupts to trigger synchronized multi-channel ADC sampling every $1\text{ ms}$ ($1\text{ kHz}$ sampling rate).
- **Signal Sensing:** Captures conditioned analog signals from $V_{\alpha\beta}$ and $I_{\alpha\beta}$ sensor channels ($0 - 3.3\text{ V}$ ADC range).
- **High-Speed USB Streaming:** Transmits raw sampled sensor data in real time via USB CDC (Virtual COM Port) to the host PC for post-processing and neural network validation in MATLAB.
