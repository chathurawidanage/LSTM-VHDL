library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity array_elem_sum is
    Port (
        A : in std_logic_vector(255 downto 0);
        O: out std_logic_vector(31 downto 0);
        CLK : in std_logic
     );
end array_elem_sum;

architecture array_elem_sum of array_elem_sum is
    component float_adder
    port(
        clk: in std_logic;
        f1: in std_logic_vector(31 downto 0);
        f2: in std_logic_vector(31 downto 0);
        out1: out std_logic_vector(31 downto 0)
    );
    end component;


shared variable i: integer :=0;     
signal ints: std_logic_vector(191 downto 0);
signal clks: std_logic_vector(5 downto 1);

begin
    process (CLK)
    begin
        clk_loop:
        for i in 5 downto 1 loop
            if (i mod 2)=0 then
                    clks(i) <= CLK;
            else
                    clks(i) <= not CLK;
            end if;
        end loop clk_loop;
    end process;
    ad0 : float_adder port map (clk=>CLK, f1=>A(255 downto 224), 
        f2=>A(223 downto 192), out1=>ints(191 downto 160));
    elem_sums:
        for i in 5 downto 1 generate
            adx: float_adder port map (clk=>clks(i), 
                f1=>A((i*32)+31 downto (i*32)),
                f2=>ints((i*32)+31 downto (i*32)),
                out1=>ints(((i-1)*32)+31 downto ((i-1)*32))
            );
    end generate elem_sums;
    
    ad7:float_adder port map (clk=>CLK, f1=>A(31 downto 0), 
        f2=>ints(31 downto 0), out1=>O);
end array_elem_sum;
