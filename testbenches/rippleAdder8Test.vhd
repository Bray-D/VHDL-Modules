-----------------------------------------------
-- Testing for single byte ripple adder
-- Written by Brady Girard.
-----------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rippleAdder8Test is 
end rippleAdder8Test;

architecture Behaviour of rippleAdder8Test is
	-- Module to test:
	component rippleAdder8 is
		generic (
			numBits: natural
		);
		port (
			carryIn:	in std_logic;
			byteA:		in std_logic_vector(numBits-1 downto 0);
			byteB:		in std_logic_vector(numBits-1 downto 0);
			outputByte:	out std_logic_vector(numBits-1 downto 0);
			carryOut:	out std_logic
		);
	end component;

	-- Signals, variables, etc
	constant BYTE_LENGTH: integer := 8;
	signal inByteA: std_logic_vector(BYTE_LENGTH-1 downto 0) := X"00";
	signal inByteB: std_logic_vector(BYTE_LENGTH-1 downto 0) := X"00";
	signal outByte: std_logic_vector(BYTE_LENGTH-1 downto 0) := X"00";
	signal carryOut: std_logic;
	signal carryIn:	std_logic;
	constant CLOCK_PERIOD: time := 10 ns;

	begin
	rippleAdder1: rippleAdder8
		generic map (
			numBits => BYTE_LENGTH
		)
		port map (
			carryIn => carryIn,
			byteA => inByteA,
			byteB => inByteB,
			outputByte => outByte,
			carryOut => carryOut
		);

	test: process
		begin
		inByteA <= X"03";
		inByteB <= X"FF";
		carryIn <= '1';
		wait for CLOCK_PERIOD*3;
		inByteA <= std_logic_vector(to_unsigned(255, inByteA'length));
		inByteB <= std_logic_vector(to_unsigned(255, inByteA'length));
		wait for CLOCK_PERIOD*3;
		inByteA <= std_logic_vector(to_unsigned(128, inByteA'length));
		inByteB <= std_logic_vector(to_unsigned(128, inByteA'length));
		carryIn <= '0';
		wait for CLOCK_PERIOD*3;
		inByteA <= std_logic_vector(to_unsigned(47, inByteA'length));
		inByteB <= std_logic_vector(to_unsigned(255, inByteA'length));
		wait;
	end process;
end Behaviour;