library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity m2_1n_to_nn is
    Port ( 
        A: in std_logic_vector(255 downto 0);
        B: in std_logic_vector(2047 downto 0);
        O : out std_logic_vector(255 downto 0);
        CLK : in std_logic
    );
end m2_1n_to_nn;

architecture m2_1n_to_nn of m2_1n_to_nn is

begin
    sync_stuff: process (CLK, A, B)
    begin
    
    
    end process;
end m2_1n_to_nn;
    