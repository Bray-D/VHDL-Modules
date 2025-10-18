

library IEEE;
use IEEE.stD_logic_1164.all;

entity addSubber_tb is
end addSubber_tb;

architecture Behaviour of addSubber_tb is
	-- Module to test:
	component adderSubber is
		generic (
			numBits: natural
		);
		port (
			numA_i:		in std_logic_vector(numBits-1 downto 0);
			numB_i:		in std_logic_vector(numBits-1 downto 0);
			addSub_i:	in std_logic; -- To add or to subtract input
			CB_i:		in std_logic; -- Carry/borrow input
			result_o:	out std_logic_vector(numBits-1 downto 0);
			CB_o:		out std_logic -- Carry or borrow output
		);
	end component;

	constant DATA_LENGTH: integer := 16;
	constant CLOCK_PERIOD: time := 10 ns;
	signal numberA: std_logic_vector(DATA_LENGTH-1 downto 0);
	signal numberB: std_logic_vector(DATA_LENGTH-1 downto 0);
	signal toAddSub: std_logic;
	signal numberOut: std_logic_vector(DATA_LENGTH-1 downto 0);
	signal carryBorrow: std_logic;
	signal CB_output: std_logic;

	begin 
		addSub: adderSubber
			generic map ( numBits => DATA_LENGTH )
			port map (
				numA_i => numberA,
				numB_i => numberB,
				addSub_i => toAddSub,
				CB_i => carryBorrow,
				result_o => numberOut,
				CB_o => CB_output
			);

		test: process
			begin
			-- 0x4EAA + 0xF00 + 1
			numberA <= X"4EAA";
			numberB <= x"0F00";
			toAddSub <= '0';
			carryBorrow <= '1';
			wait for CLOCK_PERIOD*3;

			-- 0xFFFF - 0x1E1E
			numberA <= X"FFFF";
			numberB <= x"1E1E";
			toAddSub <= '1';
			carryBorrow <= '0';
			wait for CLOCK_PERIOD*3;

			-- 0xFF45 - 0xFF45
			numberA <= X"FF45";
			numberB <= X"FF45";
			toAddSub <= '1';
			wait for CLOCK_PERIOD*3;

			-- 0x3216 + 0x5065 + 1
			numberA <= X"3216";
			numberB <= X"5065";
			toAddSub <= '0';
			carryBorrow <= '1';
			wait for CLOCK_PERIOD*3;

			-- 0xFFFF - 0xFFFF - 1
			numberA <= X"FFFF";
			numberB <= X"FFFF";
			toAddSub <= '1';
			wait for CLOCK_PERIOD*3;
		end process;
end Behaviour;