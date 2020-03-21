library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tanh_tb is
--  Port ( );
end tanh_tb;

architecture tanh_tb of tanh_tb is
    component tanh
        Port(
            A: in std_logic_vector(31 downto 0);
            O: out std_logic_vector(31 downto 0);
            CLK : in std_logic
        );
    end component;
    
    signal A : std_logic_vector(31 downto 0);
    signal O : std_logic_vector(31 downto 0);
    signal CLK : std_logic;
    
begin
    uut: tanh port map (A=>A, O=>O, CLK=>CLK);
    stim_proc: process
    begin
        CLK <= '0';
        A<= "00111111111100011110101110000101"; --1.89
        wait for 200 ns;
        CLK <= '1';
        wait for 200 ns;
        CLK <= '0';
        wait for 200 ns;
        CLK <= '1';
        wait for 200 ns;
        CLK <= '0';
        wait for 200 ns;
        CLK <= '1';
        wait for 200 ns;
        CLK <= '0';
        wait for 200 ns;
        CLK <= '1';
        wait for 200 ns;
        CLK <= '0';
        wait for 200 ns;
        CLK <= '1';
        wait for 200 ns;
        CLK <= '0';
        wait for 200 ns;
        CLK <= '1';
        wait for 200 ns;
        CLK <= '0';
        wait for 200 ns;
        CLK <= '1';
        wait for 200 ns;
        CLK <= '0';
        wait for 200 ns;
        CLK <= '1';
        wait for 200 ns;
        CLK <= '0';
    end process;
end tanh_tb;
