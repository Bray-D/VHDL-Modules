-------------------------------------------------------
-- Custom made test bench for halfAdder (adder.vhdl)
-- Defines a clock source at 100 MHz (T = 10 ns).
-- Runs through all test cases for inputs A and B.
-- Output must be consistent with a half adder.
-------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity adderTest is 
end adderTest;

architecture Behaviour of adderTest is
	-- Declare component to use
	component halfAdder is 
		port (
			clk:	in std_logic;
			A:		in std_logic;
			B:		in std_logic;
			result: out std_logic;
			carry:	out std_logic
		);
	end component;

	-- Signals to actually test with
	signal clock: std_logic := '0';
	signal inputA: std_logic := '0';
	signal inputB: std_logic := '0';
	signal outputCarry: 	std_logic;
	signal outputResult: 	std_logic;
	constant CLOCK_PERIOD: time := 10 ns;

	begin
	adder1: halfAdder
		port map (
			clk => clock,
			A => inputA,
			B => inputB,
			carry => outputCarry,
			result => outputResult
		);
	-- end adder1

	clkGeneration: process
		begin
		clock <= '0';
		wait for CLOCK_PERIOD/2;
		clock <= '1';
		wait for CLOCK_PERIOD/2;
	end process;

	testInputs: process
		begin 
		-- Inputs are already zero, no need to set it
		-- Wait for three clock cycles to check A = B = 0
		wait for CLOCK_PERIOD*3;

		inputA <= '1';
		-- No need for inputB <= '0' as it is 0 already
		wait for CLOCK_PERIOD*3;

		inputA <= '0';
		inputB <= '1';
		wait for CLOCK_PERIOD*3;

		inputA <= '1';
		-- No need for inputB <= '1' as it is 1 already
		wait;	-- Halt program here

	end process;

end Behaviour;