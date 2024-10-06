This design aims to implement a simplified 8-bit RISC processor system that executes instructions within a single cycle. The system is streamlined for educational purposes, omitting complex features like RAM and multi-cycle instruction processing. Instead, all operations, including ALU computations, are completed in a single clock cycle, making the architecture straightforward and easy to understand.

This lab is designed to provide hands-on experience with fundamental aspects of processor architecture and design based on instruction sets developed within the RV32I. Through this simplified model, students will practically practice core concepts of computers like instructions execution and branch.

Control Signals
The controller outputs several control signals, which are used within the system. The following control signals are defined below:

•	EXE_CMD: Determines the specific ALU operation to be performed on operand data such as addition, subtraction, or logical functions.

•	Reg_W: Enables writing the result into a specified register file.

•	PCincr: Increments the Program Counter, allowing the processor to transition to the next instruction in sequence.

•	PCbranch: Updates the Program Counter with the branch address for the next instruction fetch.

•	BranchEn: Activate Branch Comparator to decide whether to compare or not.

•	ImSel: this signal determines whether the immediate value from the instruction should be used by the ALU or not.
