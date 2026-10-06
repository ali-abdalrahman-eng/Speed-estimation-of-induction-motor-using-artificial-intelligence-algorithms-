# Sensorless Speed Estimation of Three-Phase Induction Motors using Artificial Neural Networks (ANN) and Extended Kalman Filter (EKF)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![MATLAB](https://img.shields.io/badge/MATLAB-Simulink-blue.svg)](https://www.mathworks.com/)
[![STM32](https://img.shields.io/badge/Hardware-STM32-red.svg)](https://www.st.com/)
[![Status](https://img.shields.io/badge/Status-Completed-brightgreen.svg)]()

> 🎓 **Bachelor's Graduation Thesis Project**  
> **Author:** Ali Abdulrahman  
> **Institution:** Higher Institute for Applied Sciences and Technology (HIAST), Damascus, Syria  
> **Supervisors:** Dr. Alaa Marouf, Eng. Ahmad Al-Aissa, Eng. Taha Ibrahim  
> **Evaluation Score:** 84% (Class of 2025)  
> 📄 **Full Thesis Document:** Available in [`docs/Speed_Estimation_Induction_Motor_Graduation_Report.pdf`](./docs/)

---

## 📌 Project Overview

This project presents an end-to-end, high-precision **sensorless speed estimation** framework for three-phase squirrel-cage induction motor drives. It combines electrical machine theory, custom active signal conditioning hardware, embedded STM32 firmware, and **Artificial Neural Networks (ANN)** optimized with Bayesian Regularization. The performance of the proposed ANN observer is evaluated against a classical **Extended Kalman Filter (EKF)** benchmark under both simulation and real-world noise-contaminated experimental scenarios.

```text
+-----------------------------------------------------------------------+
|                           SYSTEM ARCHITECTURE                         |
|                                                                       |
|  +-----------------+      +--------------------+      +------------+  |
|  | 3-Phase Induction| ---> | Signal Conditioning| ---> |   STM32    |  |
|  |     Motor       |      | (ZMPT101B/ACS712)  |      | Microcontroller|
|  +-----------------+      +--------------------+      +------------+  |
|          ^                                                  |         |
|          |                  Closed-Loop V/f         USB CDC Real-Time |
|          |                  SPWM Inverter Drive         Stream        |
|  +-----------------+                                  +------------+  |
|  |   Power Stage   | <------------------------------- | MATLAB /   |  |
|  |   (3-Phase PWM) |                                  | Simulink   |  |
|  +-----------------+                                  (ANN / EKF)     |
+-----------------------------------------------------------------------+
