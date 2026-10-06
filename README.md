# Sensorless Speed Estimation of Three-Phase Induction Motors using Artificial Neural Networks (ANN) and Extended Kalman Filter (EKF)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![MATLAB](https://img.shields.io/badge/MATLAB-Simulink-blue.svg)](https://www.mathworks.com/)
[![STM32](https://img.shields.io/badge/Hardware-STM32-red.svg)](https://www.st.com/)
[![Status](https://img.shields.io/badge/Status-Completed-brightgreen.svg)]()

> 🎓 **Bachelor's Graduation Thesis Project**  
> **Author:** Ali Abdulrahman  
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
