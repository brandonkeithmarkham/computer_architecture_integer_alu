# 🖥️ ALU Computer Architecture Project

This repository contains the Verilog code and documentation for a parameterizable **Arithmetic Logic Unit (ALU)** designed in **CS 3339: Computer Architecture** at Texas State University. The project integrated multiple bitwise and arithmetic modules into a single top-level ALU and verified functionality using EDA Playground waveforms.

## 📄 Project Overview
The goal of this project was to design a behavioral-level ALU capable of performing both **bitwise logic** and **arithmetic operations** on inputs of variable width. All modules were integrated into a top-level ALU with a control opcode for operation selection. Testing included widths of 4, 8, 16, and 32 bits to demonstrate scalability.

## 🛠 Tools & Methods
- **Language**: Verilog (behavioral-level design)
- **Environment**: EDA Playground (online HDL editor & waveform generator)
- **Modules Implemented**:
  - Bitwise: AND, NAND, OR, NOR, XOR, XNOR, NOT  
  - Arithmetic: Add, Subtract, Multiply, Divide  
  - Shifting: Multi-bit logical shifts with fill & overflow outputs  
- **Verification**:
  - Custom Verilog testbench with opcode-controlled operation selection  
  - Waveform analysis across 4, 8, 16, and 32-bit input widths  

## 📊 Key Outcomes
- Successfully designed and integrated a **scalable ALU** with 12 operations  
- Verified functionality using **parameterized testbenches** and waveform outputs  
- Demonstrated **opcode-controlled routing** via Verilog case statements  
- Extended testing to **higher bit-widths (32-bit)** for robustness  
- Gained practical experience with **hardware description languages** and testbench-driven validation:contentReference[oaicite:1]{index=1}  

## 📄 Documentation
Full project documentation, including Verilog code listings, testbench, and waveform results, can be found here:  
👉 [**Final Report**](./Turing%20Machine-ProjectStep3/Computer_Architecture_Project__Final_Report.pdf)

## 🔖 Notes
- Each module was implemented as a standalone component, then instantiated in the ALU.  
- The testbench used Verilog’s replication operator to generate scalable input vectors.  
- Extra outputs (`carryout`, `remainder`, `overflow`) were mapped to a secondary bus for clarity.  

## 📝 Authors
Brandon Markham, Paul Henson, Sam Arshad  

## 📫 Contact
[LinkedIn](https://www.linkedin.com/) | [Email](mailto:youremail@example.com)
