----------------------------------------------------------------------------------
-- Company: 		 ESIGELEC
-- Engineer: 		 Samira ALI, David HERNANDEZ
-- 
-- Create Date:    09:49:02 02/25/2019 
-- Design Name: 
-- Module Name:    cascadable_counter - Behavioral 
-- Project Name:   cascadable_counter
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cascadable_counter is
	generic (
		max_count:	positive := 10
	);

    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           ena : in  STD_LOGIC;
           cascade_in : in  STD_LOGIC;
           cascade_out : out  STD_LOGIC;
           count : out  INTEGER range 0 to max_count-1);
end cascadable_counter;

architecture Behavioral of cascadable_counter is
	signal count_temp: integer range 0 to max_count-1;
	signal cascade_temp: STD_LOGIC;
begin

	count <= count_temp;
	cascade_out <= cascade_temp;
	
counting: process (rst, clk) is
	begin
		if (rst = '0') then
			count_temp <= 0;
		elsif rising_edge(clk) AND(ena = '1') AND (cascade_in = '1') then
			if (count_temp = (max_count-1)) then
				count_temp <= 0;
			else
				count_temp <= count_temp + 1;
			end if;
		end if;
	end process counting;
	
cascade_process: process (cascade_in, count_temp) is
		begin
			if (cascade_in = '1') and (count_temp = (max_count-1)) then
				cascade_temp <= '1';
			else
				cascade_temp <= '0';
			end if;
		end process cascade_process;
		
end Behavioral;

