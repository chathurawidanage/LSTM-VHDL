
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity float_adder_tb is
--  Port ( );
end float_adder_tb;

architecture float_adder_tb of float_adder_tb is
    constant ClockFrequency : integer := 100e6;
    constant ClockPeriod : time := 1000 ms / ClockFrequency;
    
    signal clk : std_logic := '1';
    
    component float_adder
        port(
        clk: in std_logic;
        f1: in std_logic_vector(31 downto 0);
        f2: in std_logic_vector(31 downto 0);
        out1: out std_logic_vector(31 downto 0)
        );
    end component;
    signal f1: std_logic_vector(31 downto 0) := (others => '0');
    signal f2: std_logic_vector(31 downto 0) := (others => '0');
    signal out1: std_logic_vector(31 downto 0) := (others => '0');
    
begin

    FA: float_adder port map (
        f1 => f1,
        f2 => f2,
        out1 => out1,
        clk => clk
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
end float_adder_tb;
