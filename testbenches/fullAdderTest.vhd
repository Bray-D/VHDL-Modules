---------------------------------------------------
-- Custom testbench for fullAdder (fullAdder.vhd)
-- Written by Brady Girard.
-- Generates a clock with f = 100 MHz (T = 10 ns)
-- Output must be consistent with full adder logic.
---------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity fullAdderTest is
end fullAdderTest;

architecture Behaviour of fullAdderTest is
	-- Component to be used:
	component fullAdder is
	port (
		clk:	in std_logic;
		A:		in std_logic;
		B:		in std_logic;
		carryIn:in std_logic;
		carryOut: out std_logic;
		result:	out std_logic
	);
	end component;

	-- Signals and constants to test with
	constant CLOCK_PERIOD: time := 10 ns;
	signal clk: std_logic := '0';
	signal inputs: std_logic_vector(0 to 2);
	signal outC: std_logic;
	signal result: std_logic;

	begin
		fullAdder1: fullAdder
		port map (
			clk => clk,
			A => inputs(0),
			B => inputs(1),
			carryIn => inputs(2),
			carryOut => outC,
			result => result
		);
		-- end fullAdder1

		clkGen: process
		begin
			clk <= '1';
			wait for CLOCK_PERIOD/2;
			clk <= '0';
			wait for CLOCK_PERIOD/2;
		end process;

		test: process
		begin
			-- Loop all possible values of signal inputs
			inputs <= "000";
			wait for CLOCK_PERIOD*3;
			inputs <= "001";
			wait for CLOCK_PERIOD*3;
			inputs <= "010";
			wait for CLOCK_PERIOD*3;
			inputs <= "011";
			wait for CLOCK_PERIOD*3;
			inputs <= "100";
			wait for CLOCK_PERIOD*3;
			inputs <= "101";
			wait for CLOCK_PERIOD*3;
			inputs <= "110";
			wait for CLOCK_PERIOD*3;
			inputs <= "111";
			wait; -- hold program
		end process;
end Behaviour;