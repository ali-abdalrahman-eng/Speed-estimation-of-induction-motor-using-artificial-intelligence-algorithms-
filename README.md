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
✨ Engineering Stages & Key Innovations1. Dynamic Modeling & Control SimulationDerived non-linear state-space equations of the squirrel-cage induction motor in the synchronous rotating ($d-q$) frame using Clarke and Park transformations.Designed a closed-loop scalar $V/f$ speed control system in MATLAB/Simulink driven by a 3-phase Sine Pulse Width Modulation (SPWM) inverter.2. AI Neural Network & EKF ArchitectureANN Architecture: Custom Multi-Layer Perceptron (MLP) with a 4-10-5-1 layer structure.Feature Matrix Construction: Constructed a compact feature matrix ($M_{4 \times n}$) combining stationary frame ($\alpha-\beta$) instantaneous active power ($P$), reactive power ($Q$), voltage magnitude ($V_{\alpha\beta}$), and current magnitude ($I_{\alpha\beta}$):$$M_{4 \times n} = \begin{bmatrix} V_{\alpha\beta} & I_{\alpha\beta} & P & Q \end{bmatrix}^T$$Optimization: Trained using Bayesian Regularization Backpropagation (Levenberg-Marquardt optimization) to reduce computational complexity and prevent overfitting.3. Hardware Testbench & Signal ConditioningSensors: Integrated ZMPT101B voltage transformers and ACS712 Hall-effect current sensors.Filtering & Scaling: Custom active analog low-pass filters using OP07 operational amplifiers and RC attenuation networks to eliminate switching noise from the inverter, shifting signal levels to the $0 - 3.3\text{V}$ range for MCU compatibility.4. Embedded Firmware & Data AcquisitionProgrammed an STM32 microcontroller in C to execute simultaneous multi-channel ADC sampling (2 phase voltages, 2 phase currents, and tachometer speed feedback for ground-truth validation).Timed with internal hardware timer interrupts and real-time data streaming over USB CDC stack at high rates.Collected over 72,000 real-world experimental data points under dynamic acceleration, deceleration, frequency ramps, and step torque loading
