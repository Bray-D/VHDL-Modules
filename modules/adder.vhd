----------------------------------------------------
-- Half adder using VHDL. Written by Brady Girard 
-- input clk: master clock			(15 Oct 2025)
-- input A: 1st bit
-- input B: 2nd bit
-- output result: A + B
-- output carry: if A == B == 1
----------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity halfAdder is 
port (
	clk:	in std_logic;
	A:		in std_logic;
	B:		in std_logic;
	result: out std_logic;
	carry:	out std_logic
);
end halfAdder;

architecture Behaviour of halfAdder is
	begin
	process(clk)
		begin
		if rising_edge(clk)	then
			result <= A xor B;
			carry <= A and B;
		end if;
	end process;
end Behaviour;