---------------------------------------------
-- Implements an 8 bit ripple adder in VHDL
-- Written by Brady Girard.
-- input clk: clock input
-- input A0-A7: first byte
-- input B0-B7: second byte
-- output result0-7: output byte
-- output carry: carry output
---------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity rippleAdder8 is
generic (
	numBits: natural := 8
);
port (
	carryIn:	in std_logic;
	byteA:		in std_logic_vector(numBits-1 downto 0);
	byteB:		in std_logic_vector(numBits-1 downto 0);
	outputByte:	out std_logic_vector(numBits-1 downto 0);
	carryOut:	out std_logic
);
end rippleAdder8;

architecture Behaviour of rippleAdder8 is
	-- Internal values
	signal carries: std_logic_vector(numBits downto 0);
	signal internalSum: std_logic_vector(numBits - 1 downto 0) := X"00";

	-- Other 7 bits need full adder
	component fullAdder is
	port (
		A:			in std_logic;
		B:			in std_logic;
		carryIn:	in std_logic;
		carryOut: 	out std_logic;
		result:		out std_logic
	);
	end component;

	begin
	carries(0) <= carryIn;
	setAdders: for i in 0 to numBits-1 generate 
		fullAdder_inst: fullAdder
		port map (
			A => byteA(i),
			B => byteB(i),
			carryIn => carries(i),
			result => internalSum(i),
			carryOut => carries(i + 1)
		);
	end generate;
	outputByte <= internalSum;
	carryOut <= carries(numBits);
end Behaviour;