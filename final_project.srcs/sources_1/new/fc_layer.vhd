
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fc_layer is
    port(
        clk: in std_logic;
        input: in std_logic_vector(255 downto 0);
        output: out std_logic_vector(31 downto 0)
    );
end fc_layer;

architecture fc_layer of fc_layer is
    
    component stock_weights
        port(
        
            clk : in std_logic;
            bi: out std_logic_vector(255 downto 0);
            wih: out std_logic_vector(2047 downto 0);
            wig: out std_logic_vector(255 downto 0);
    
            bf: out std_logic_vector(255 downto 0);
            wfh: out std_logic_vector(2047 downto 0);
            wfg: out std_logic_vector(255 downto 0);
    
            bo: out std_logic_vector(255 downto 0);
            woh: out std_logic_vector(2047 downto 0);
            wog: out std_logic_vector(255 downto 0);
    
            wmh: out std_logic_vector(2047 downto 0);
            wmc: out std_logic_vector(255 downto 0);
            bm: out std_logic_vector(255 downto 0);
            
            wfc: out std_logic_vector(255 downto 0);
            bfc: out std_logic_vector(31 downto 0)
            
        );
    end component;

    component em
        Port (
            A,B : in std_logic_vector(255 downto 0);
            O : out std_logic_vector(255 downto 0);
            CLK : in std_logic)
        ;    
    end component;

    component array_elem_sum
        Port (
            A : in std_logic_vector(255 downto 0);
            O: out std_logic_vector(31 downto 0);
            CLK : in std_logic
        );
    end component;

    component float_adder
        port(
            clk: in std_logic;
            f1: in std_logic_vector(31 downto 0);
            f2: in std_logic_vector(31 downto 0);
            out1: out std_logic_vector(31 downto 0)
        );
    end component;

    signal wfc: std_logic_vector(255 downto 0);
    signal bfc: std_logic_vector(31 downto 0);
    signal em1_out: std_logic_vector(255 downto 0);
    signal as1_out: std_logic_vector(31 downto 0);


begin

    w: stock_weights port map(
        clk => clk,
        wfc => wfc,
        bfc => bfc
    );

    em1: em port map (
        A => wfc,
        B => input,
        CLK => clk,
        O => em1_out
    );

    as1: array_elem_sum port map(
        A => em1_out,
        CLK => clk,
        O => as1_out
    );

    fa1: float_adder port map(
        clk => clk,
        f1 => as1_out,
        f2 => bfc,
        out1 => output
    );
end fc_layer;
