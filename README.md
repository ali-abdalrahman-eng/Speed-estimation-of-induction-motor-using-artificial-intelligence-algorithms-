# Sensorless Speed Estimation of Three-Phase Induction Motors using Artificial Neural Networks (ANN) and Extended Kalman Filter (EKF)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![MATLAB](https://img.shields.io/badge/MATLAB-Simulink-blue.svg)](https://www.mathworks.com/)
[![STM32](https://img.shields.io/badge/Hardware-STM32-red.svg)](https://www.st.com/)
[![Status](https://img.shields.io/badge/Status-Completed-brightgreen.svg)]()

> 🎓 **Bachelor's Graduation Thesis Project**  
> **Author:** ALI ABD ALRAHMAN  
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
```
## ✨ Engineering Stages & Key Innovations

### 1. Dynamic Modeling & Control Simulation
* Derived non-linear state-space equations of the squirrel-cage induction motor in the synchronous rotating ($d-q$) frame using Clarke and Park transformations.
* Designed a closed-loop scalar $V/f$ speed control system in MATLAB/Simulink driven by a 3-phase Sine Pulse Width Modulation (SPWM) inverter.

### 2. AI Neural Network & EKF Architecture
* **ANN Architecture:** Custom Multi-Layer Perceptron (MLP) with a **4-10-5-1** layer structure.
* **Feature Matrix Construction:** Constructed a compact feature matrix ($M_{4 \times n}$) combining stationary frame ($\alpha-\beta$) instantaneous active power ($P$), reactive power ($Q$), voltage magnitude ($V_{\alpha\beta}$), and current magnitude ($I_{\alpha\beta}$):

$$M_{4 \times n} = \begin{bmatrix} V_{\alpha\beta} & I_{\alpha\beta} & P & Q \end{bmatrix}^T$$

* **Optimization:** Trained using **Bayesian Regularization Backpropagation** (Levenberg-Marquardt optimization) to reduce computational complexity and prevent overfitting.
### 3. Hardware Testbench & Signal Conditioning
* **Sensors:** Integrated ZMPT101B voltage transformers and ACS712 Hall-effect current sensors.
* **Filtering & Scaling:** Custom active analog low-pass filters using OP07 operational amplifiers and RC attenuation networks to eliminate switching noise from the inverter, shifting signal levels to the $0 - 3.3\text{V}$ range for MCU compatibility.

### 4. Embedded Firmware & Data Acquisition
* Programmed an **STM32** microcontroller in C to execute simultaneous multi-channel ADC sampling (2 phase voltages, 2 phase currents, and tachometer speed feedback for ground-truth validation).
* Timed with internal hardware timer interrupts and real-time data streaming over USB CDC stack at high rates.
* Collected over **72,000 real-world experimental data points** under dynamic acceleration, deceleration, frequency ramps, and step torque loading.
## 📊 Experimental Results & Performance Benchmark

### 1. Comparative Performance Overview

| Evaluation Metric / Scenario | Proposed ANN Observer (MLP 4-10-5-1) | Extended Kalman Filter (EKF) Benchmark |
| :--- | :---: | :---: |
| **Simulation Speed Estimation Error** | **$\le 3\text{ RPM}$** | $\approx 20\text{ RPM}$ |
| **Experimental Error (Real Hardware)** | **$\le 15\text{ RPM}$** | Moderate to Severe Degradation |
| **Dynamic Response Time** | Fast tracking with minimal overshoot | Lag during rapid frequency transitions |
| **Noise & Harmonic Immunity** | Robust against OP07/Inverter harmonics | Highly sensitive to noise & parameter drift |

---

### 2. Key Experimental Findings & Dynamic Behaviors

* **Steady-State Accuracy:** Under stable load conditions across nominal speed ranges, the ANN estimator maintained an absolute speed tracking error within **$\pm 15\text{ RPM}$**, leveraging the feature matrix inputs ($P, Q, V_{\alpha\beta}, I_{\alpha\beta}$).
* **Dynamic Perturbations & Step Loads:** During sudden mechanical load torque changes and dynamic acceleration/deceleration frequency ramps, the neural network demonstrated instant convergence with no cumulative drift.
* **Noise Mitigation Efficiency:** The custom active analog signal conditioning stage (OP07 active filtering and RC networks) reduced high-frequency inverter PWM switching noise, enabling accurate $12\text{-bit}$ ADC sampling on the STM32 target.
* **Dataset Scale:** Validated against a dataset comprising over **$72,000$ experimental data points** collected in real time via high-speed USB CDC streaming to MATLAB.
