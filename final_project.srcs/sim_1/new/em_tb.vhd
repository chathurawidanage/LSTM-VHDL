library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity em_tb is
--  Port ( );
end em_tb;

architecture Behavioral of em_tb is
    component em
        port(
            A,B : in std_logic_vector(255 downto 0);
            O : out std_logic_vector(255 downto 0);
            CLK : in std_logic
        );
     end component;
     
     signal A,B : std_logic_vector(255 downto 0);
     signal O :  std_logic_vector(255 downto 0);
     signal CLK : std_logic;
begin

    UUT: em port map(A=>A, B=>B, O=>O, CLK=>CLK);
    stim_proc: process
    begin
        CLK <= '0';
        A<= "0100000011011111000000000000000001000000110111110000000000000000010000001101111100000000000000000100000011011111000000000000000001000000110111110000000000000000010000001101111100000000000000000100000011011111000000000000000001000000110111110000000000000000";
        B<= "1011111010101111000000000110100110111110101011110000000001101001101111101010111100000000011010011011111010101111000000000110100110111110101011110000000001101001101111101010111100000000011010011011111010101111000000000110100110111110101011110000000001101001";   
        wait for 200 ns;
        CLK <= '1';
        wait for 200ns;
        CLK <= '0';
        wait for 200 ns;
        CLK <= '1';
        wait for 200ns;
        CLK <= '0';
    
        std.env.stop;
    end process;
end Behavioral;
