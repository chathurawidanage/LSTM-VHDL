
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity float_multiplier_tb is
--  Port ( );
end float_multiplier_tb;

architecture float_multiplier_tb of float_multiplier_tb is
    constant ClockFrequency : integer := 100e6;
    constant ClockPeriod : time := 1000 ms / ClockFrequency;
    
    signal clk : std_logic := '1';
    
    component float_multiplier
        port(
        CLK: in std_logic;
        A: in std_logic_vector(31 downto 0);
        B: in std_logic_vector(31 downto 0);
        O: out std_logic_vector(31 downto 0)
        );
    end component;
    signal f1: std_logic_vector(31 downto 0) := (others => '0');
    signal f2: std_logic_vector(31 downto 0) := (others => '0');
    signal out1: std_logic_vector(31 downto 0) := (others => '0');
begin
    FM: float_multiplier port map (
        A => f1,
        B => f2,
        O => out1,
        CLK => clk
    );
    
    clk <= not clk after ClockPeriod / 2;
    
    process is
    begin
        f1 <= x"3fa00000"; -- 1.25
        f2 <= x"3e800000"; -- 0.25
        
        wait for 60 ns;
        f1 <= x"3e800000";
        f2 <= x"3fa00000";
    
        wait for 60 ns;
        
        f1 <= x"3fa00000";  -- 1.25 
        f2 <= x"3c23d70a";  -- 0.01
    
        wait for 60 ns;
        
        f1 <= x"3fa00000";  -- 1.25 
        f2 <= x"bc23d70a";  -- -0.01
    
        wait for 60 ns;
        
        
        f1 <= x"bfa00000";  -- -1.25 
        f2 <= x"bc23d70a";  -- -0.01
    
        wait for 60 ns;
   
        f1 <= x"bfa00000";  -- -1.25 
        f2 <= x"3c23d70a";  -- 0.01
    
        wait for 60 ns;
        
        wait;
    end process;

end float_multiplier_tb;
