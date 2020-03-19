library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity float_multiplier_tb is
--  Port ( );
end float_multiplier_tb;

architecture float_multiplier_tb of float_multiplier_tb is
    component float_multiplier
    port(
        A,B : in std_logic_vector(31 downto 0);
        O: out std_logic_vector(31 downto 0);
        CLK : in std_logic
    );
    end component;
    
    signal A,B : std_logic_vector(31 downto 0);
    signal CLK: std_logic;
    signal O: std_logic_vector(31 downto 0);
begin
    UUT: float_multiplier port map(A=>A, B=>B, O=>O, CLK=>CLK);
    
    stim_proc: process
    begin
        CLK <= '0';
        A <= "01000000110111110000000000000000"; -- 6.96875
        B <= "10111110101011110000000001101001"; -- −0.3418
        wait for 10 ns;
        
        CLK <= '1';
        
        wait for 50 ns;

        std.env.stop;
    end process;
end float_multiplier_tb;
