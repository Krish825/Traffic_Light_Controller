
# Traffic Light Controller Using Verilog HDL

## 1. Project Overview

This project implements a six-state Moore Finite State Machine (FSM) for controlling a two-road traffic light system using Verilog HDL.

The controller manages traffic for:
- North-South (NS) direction
- East-West (EW) direction

The design uses a clock, an active-low asynchronous reset, a state register, and a timer counter to control the duration of each traffic light phase.

## 2. State Sequence

S0 → S1 → S2 → S3 → S4 → S5 → S0

| State | North-South | East-West | Duration |
|---|---|---|---|
| S0 | Green | Red | 5 clock cycles |
| S1 | Yellow | Red | 2 clock cycles |
| S2 | Red | Red | 1 clock cycle |
| S3 | Red | Green | 5 clock cycles |
| S4 | Red | Yellow | 2 clock cycles |
| S5 | Red | Red | 1 clock cycle |

## 3. Output Signals

- `ns_red`, `ns_yellow`, `ns_green`
- `ew_red`, `ew_yellow`, `ew_green`

The outputs depend on the current state, following Moore FSM behavior.

## 4. Reset Behavior

The controller uses an active-low asynchronous reset (`reset_n`).

When `reset_n = 0`, the FSM returns to S0 and the timer resets to zero.

## 5. Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- Visual Studio Code

## 6. Project Structure

```text
Traffic_Light_Controller/
├── rtl/
│   ├── traffic_light_controller.v
│   └── traffic_light_controller_tb.v
├── traffic_light_controller.vcd
├── traffic_light_controller_sim.vvp
└── README.md
```

## 7. Simulation Instructions

Compile the design and testbench from the project root:

```powershell
& "C:\iverilog\bin\iverilog.exe" -g2012 -s traffic_light_controller_tb -o traffic_light_controller_sim.vvp rtl/traffic_light_controller.v rtl/traffic_light_controller_tb.v
```

Run the simulation:

```powershell
& "C:\iverilog\bin\vvp.exe" traffic_light_controller_sim.vvp
```

Open the waveform:

```powershell
& "C:\iverilog\bin\gtkwave.exe" traffic_light_controller.vcd
```

## 8. Verification Results

The testbench checks the expected output combinations for all six states.

All six output checks passed in simulation. The waveform was also inspected using GTKWave.

## 9. Learning Outcomes

- FSM design and state transitions
- Sequential logic and clocked processes
- Asynchronous reset behavior
- Timer-based state transitions
- Verilog RTL simulation and waveform analysis