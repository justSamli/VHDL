--------------------------------------------------------------------------------
-- Company: ESIGELEC
-- Engineer: Samira ALI, David HERNANDEZ
--
-- Create Date:   08:37:45 05/21/2019
-- Design Name:   
-- Module Name:   /home/ise/Desktop/VHDL/Homework-Counter/cascadable/cascadable_counter/cascadable_counter_tb.vhd
-- Project Name:  cascadable_counter
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cascadable_counter
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_cascadable_counter IS
END tb_cascadable_counter;
 
ARCHITECTURE behavior OF tb_cascadable_counter IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cascadable_counter 
	 generic (
		max_count:	positive := 10
	);
	 PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         ena : IN  std_logic := '1';
         cascade_in : IN  std_logic := '1';
         cascade_out : OUT  std_logic;
         count : out  INTEGER range 0 to max_count-1
        );
    END COMPONENT;
    
   --Inputs
   signal clk : std_logic;
   signal rst : std_logic;
   signal ena : std_logic := '1';
   signal cascade_in : std_logic := '1';

 	--Outputs
   signal cascade_out : std_logic;
   signal count : INTEGER range 0 to 3;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cascadable_counter 
	generic map (max_count => 4) 
	PORT MAP (
          clk => clk,
			 rst => rst,
          ena => open,
          cascade_in => open,
          cascade_out => cascade_out,
          count => count
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		rst <= '0';
		ena <= '1';
		cascade_in <= '1';
      wait for 175 ns;
		
		rst <= '1';
		ena <= '0';
		cascade_in <= '0';
      wait for 150 ns;
		
		rst <= '1';
		ena <= '1';
		cascade_in <= '1';
      wait for 350 ns;
		
		rst <= '1';
		ena <= '1';
		cascade_in <= '0';
      wait for 350 ns;
		
		rst <= '1';
		ena <= '0';
		cascade_in <= '1';
      wait for 350 ns;
		
	for i in 1 to 10 loop
		rst <= '1';
		ena <= '0';
		wait until rising_edge(clk);
		wait for 25 ns;
		-- check for even and odd iterations
		if (i mod 2 = 0) then
			cascade_in <= '1';
		else
			cascade_in <= '0';
		end if;
	end loop;
		
	for i in 1 to 10 loop		
		rst <='1'; 
		cascade_in <= '0';
		wait until rising_edge(clk);
		wait for 25 ns;
		-- check for even and odd iterations
		if (i mod 2 = 0) then
			ena <= '1';
		else
			ena <= '0';
		end if;
	end loop;
		
	for i in 1 to 10 loop		
		rst <='1'; 
		wait until rising_edge(clk);
		wait for 25 ns;
		-- check for even and odd iterations
		if (i mod 2 = 0) then	
			cascade_in <= '1';
			ena <= '1';
		else
			cascade_in <= '0';
			ena <= '0';
		end if;
	end loop;
      wait;
		
   end process;

END;
