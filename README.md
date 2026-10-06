# Sensorless Speed Estimation of Three-Phase Induction Motors using Artificial Neural Networks (ANN) and Extended Kalman Filter (EKF)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![MATLAB](https://img.shields.io/badge/MATLAB-Simulink-blue.svg)](https://www.mathworks.com/)
[![STM32](https://img.shields.io/badge/Hardware-STM32-red.svg)](https://www.st.com/)
[![Status](https://img.shields.io/badge/Status-Completed-brightgreen.svg)]()

> 🎓 **Bachelor's Graduation Thesis Project**  
> **Author:** ALI ABD ALRAHMAN  
> **Institution:** Higher Institute for Applied Sciences and Technology (HIAST), Damascus  
> 📄 **Full Graduation Thesis Report (90 Pages in Arabic):** Available in [`docs/Speed_Estimation_Induction_Motor_Graduation_Report.pdf`](./docs/)

---

## 📌 Project Overview

This project focuses on the **sensorless speed estimation** of a three-phase induction motor using **Artificial Neural Networks (ANN)** and compares its dynamic performance against the classical **Extended Kalman Filter (EKF)**.

By eliminating mechanical speed sensors (encoders/tachometers), the system enhances reliability, reduces physical footprint, and lowers overall system costs in demanding industrial drives.

```text
+-----------------------------------------------------------------------+
|                           SYSTEM ARCHITECTURE                         |
|                                                                       |
|  +-----------------+      +--------------------+      +------------+  |
|  | 3-Phase Induction| ---> | Signal Conditioning| ---> |   STM32    |  |
|  |     Motor       |      |     Hardware       |      | Microcontroller|
|  +-----------------+      +--------------------+      +------------+  |
|          ^                                                  |         |
|          |                  V/f Control / Data          USB / Serial  |
|          |                        Loop                      v         |
|  +-----------------+                                  +------------+  |
|  |   Inverter /    | <------------------------------- | MATLAB /   |  |
|  |   Power Stage   |                                  | Simulink   |  |
|  +-----------------+                                  +------------+  |
|                                                         (ANN / EKF)   |
+-----------------------------------------------------------------------+
---

## ✨ Key Features & Technical Highlights

* **Dynamic Motor Modeling:** Implementation of three-phase induction motor state equations in the stationary and synchronous rotating ($d-q$) reference frames.
* **Neural Network Estimator:** 
  * Multi-layer Perceptron (MLP) architecture trained using **Bayesian Regularization** and **Levenberg-Marquardt** backpropagation.
  * Inputs: Measured stator voltages ($V_\alpha, V_\beta$) and stator currents ($I_\alpha, I_\beta$).
  * Output: Estimated rotor speed ($\hat{\omega}_r$).
* **Comparative Estimator (EKF):** Full state estimation incorporating non-linear Kalman filtering for real-time speed and flux tracking.
* **Hardware Acquisition & Signal Conditioning:**
  * Custom analog signal conditioning circuits for filtering and scaling high-voltage/current signals.
  * **STM32** MCU firmware utilizing embedded timers and ADCs for high-frequency sampling.
  * Real-time USB data stream to PC environment.
* **Control Strategy:** Closed-loop Scalar Control ($V/f$) with estimated speed feedback.

---

## 📁 Repository Structure

```text
.
├── docs/               # Full graduation thesis report (PDF format in Arabic)
├── src/
│   ├── matlab_simulink/# MATLAB scripts, training routines, and Simulink models
│   └── stm32_firmware/ # STM32 firmware code (CubeMX .ioc, Core, USB middleware)
├── hardware/
│   └── schematics/     # Circuit schematics for signal conditioning and PCB layouts
├── data/               # Experimental datasets used for ANN training and validation
└── README.md           # Project documentation
