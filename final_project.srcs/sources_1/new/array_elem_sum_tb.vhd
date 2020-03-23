library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity array_element_sum_tb is
--  Port ( );
end array_element_sum_tb;

architecture array_element_sum_tb of array_element_sum_tb is

    constant ClockFrequency : integer := 100e6;
    constant ClockPeriod : time := 1000 ms / ClockFrequency;
    
    signal clk : std_logic := '1';
    
    component array_elem_sum
        port(
            A : in std_logic_vector(255 downto 0);
            O: out std_logic_vector(31 downto 0);
            CLK : in std_logic
        );
    end component;
    
    signal A : std_logic_vector(255 downto 0);
    signal O : std_logic_vector(31 downto 0);
begin

    uut : array_elem_sum port map (A=>A, CLK=>clk, O=>O);
    
    clk <= not clk after ClockPeriod / 2;

    stim_proc: process
    begin
        A<= "0100000011011111000000000000000001000000110111110000000000000000010000001101111100000000000000000100000011011111000000000000000001000000110111110000000000000000010000001101111100000000000000000100000011011111000000000000000001000000110111110000000000000000";
        wait for 200 ns;
    end process;

end array_element_sum_tb;
