-----------------------------------------------------
-- D flip flop using VHDL. Written by Brady Girard.
-- input clk: clock input
-- input D: data input
-- output Q: data output
-----------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity DFF is 
	port (
		clk:	in std_logic;
		D:		in std_logic;
		Q:		out std_logic
	);
end DFF;

architecture Behaviour of DFF is
	begin
	process(clk)
		begin
		if rising_edge(clk) then
			Q <= D;
		end if;
	end process;
end Behaviour;