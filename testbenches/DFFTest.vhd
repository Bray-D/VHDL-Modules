----------------------------------------------
-- Testbench for D flip flop (DFF.vhd).
-- Written by Brady Girard.
-- Defines a clock source at 100 MHz (10 ns)
----------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity DFFTest is
end DFFTest;

architecture Behaviour of DFFTest is
	component DFF is 
		port (
			clk:	in std_logic;
			D:		in std_logic;
			Q:		out std_logic
		);
	end component;

	-- Signals to test with
	signal clk: std_logic := '0';
	signal dataIn: std_logic := '0';
	signal dataOut: std_logic;
	constant CLOCK_PERIOD: time := 10ns;

	begin
	flipFlop: DFF
		port map (
			clk => clk,
			D => dataIn,
			Q => dataOut
		);
	-- end flipFlop

	clkGeneration: process
		begin
		clk <= '0';
		wait for CLOCK_PERIOD/2;
		clk <= '1';
		wait for CLOCK_PERIOD/2;
	end process;

	test: process
		begin
		-- Create a pulse train for dataIn
		for i in 0 to 5 loop
			dataIn <= not dataIn;
			wait for CLOCK_PERIOD*5;
		end loop;

		-- test with bit stream '00110100'
		dataIn <= '0';
		wait for CLOCK_PERIOD*2;
		dataIn <= '1';
		wait for CLOCK_PERIOD*2;
		dataIn <= '0';
		wait for CLOCK_PERIOD;
		dataIn <= '1';
		wait for CLOCK_PERIOD;
		dataIn <= '0';
		wait for CLOCK_PERIOD*2;

		-- test with pulse with shorter than CLOCK_PERIOD
		dataIn <= '1';
		wait for CLOCK_PERIOD/4;
		dataIn <= '0';
		wait for CLOCK_PERIOD/2;
		dataIn <= '1';
		wait;
	end process;
end Behaviour;