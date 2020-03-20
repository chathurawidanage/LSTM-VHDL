library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity em is
    Port (
        A,B : in std_logic_vector(255 downto 0);
        O : out std_logic_vector(255 downto 0);
        CLK : in std_logic
    );
end em;

architecture em of em is

component float_multiplier
    Port(
        A, B: in std_logic_vector(31 downto 0);
        O : out std_logic_vector(31 downto 0);
        CLK : in std_logic
    );
end component;

type a_array is array (7 downto 0) of std_logic_vector(31 downto 0);
type b_array is array (7 downto 0) of std_logic_vector(31 downto 0);
shared variable i: integer :=0;

begin
    float_muls:
        for i in 0 to 7 generate
            fmx : float_multiplier port map (CLK=>CLK, A=>A((i*32)+31 downto i*32), 
                        B=> B((i*32)+31 downto i*32), O=>O((i*32)+31 downto i*32));
    end generate float_muls;
end em;
