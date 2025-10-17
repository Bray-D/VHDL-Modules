------------------------------------------------
-- Full adder implementation in VHDL.
-- Written by Brady Girard.
-- input clk: clock input
-- input A: first bit
-- input B: second bit
-- input carry: carry input from previous adder
-- output carry: carry output
-- output result: A + B + C
-------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity fullAdder is 
	port (
		A:		in std_logic;
		B:		in std_logic;
		carryIn:in std_logic;
		carryOut: out std_logic;
		result:	out std_logic
	);
end fullAdder;

architecture Behaviour of fullAdder is
	begin
	process(A, B, carryIn)
		begin
		result <= A xor B xor carryIn;
		carryOut <= (A and B) or (carryIn and (A xor B));
	end process;
end Behaviour;