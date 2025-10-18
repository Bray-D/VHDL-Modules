----------------------------------------------
-- This is a VHDL implementation of an
-- adder-subtractor using the ripple carry
-- method. Written by Brady Girard.
-- input byteA: first number
-- input byteB: second number
-- input A/S:	to add or subtract
-- input carry:	carry/borrow input
-- output byteOut: sum/difference output
-- output C/B:	carry/borrow output
----------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity adderSubber is
	generic (
		numBits: natural := 8
	);
	port (
		numA_i:		in std_logic_vector(numBits-1 downto 0);
		numB_i:		in std_logic_vector(numBits-1 downto 0);
		addSub_i:	in std_logic; -- To add or to subtract input
		CB_i:		in std_logic; -- Carry/borrow input
		result_o:	out std_logic_vector(numBits-1 downto 0);
		CB_o:		out std_logic -- Carry or borrow output
	);
end adderSubber;

architecture Behaviour of adderSubber is 
	component fullAdder is
		port (
			A:			in std_logic;
			B:			in std_logic;
			carryIn:	in std_logic;
			carryOut: 	out std_logic;
			result:		out std_logic
		);
	end component;

	signal CBs: std_logic_vector(numBits downto 0);
	signal sum: std_logic_vector(numBits-1 downto 0);

	begin
		CBs(0) <= CB_i;
		setAdders: for i in 0 to numBits-1 generate
			fullAdder_inst: fullAdder
				port map (
					A => numA_i(i) xor addSub_i,
					B => numB_i(i),
					carryIn => CBs(i) or addSub_i,
					carryOut => CBs(i + 1),
					result => sum(i)
				);
		end generate;
		result_o <= sum;
		CB_o <= CBs(numBits);
end Behaviour;