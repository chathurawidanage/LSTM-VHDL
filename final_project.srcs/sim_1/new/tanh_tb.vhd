library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tanh_tb is
--  Port ( );
end tanh_tb;

architecture tanh_tb of tanh_tb is

    constant ClockFrequency : integer := 100e6;
    constant ClockPeriod : time := 1000 ms / ClockFrequency;
    
    signal clk : std_logic := '1';
    
    component tanh
        Port(
            A: in std_logic_vector(31 downto 0);
            O: out std_logic_vector(31 downto 0);
            CLK : in std_logic
        );
    end component;
    
    signal A : std_logic_vector(31 downto 0);
    signal O : std_logic_vector(31 downto 0);
    
begin
    
    clk <= not clk after ClockPeriod / 2;
    
    uut: tanh port map (A=>A, O=>O, CLK=>clk);
    stim_proc: process
    begin
        A<= "00111111111100011110101110000101"; --1.89
        wait for 200 ns;
    end process;
end tanh_tb;
