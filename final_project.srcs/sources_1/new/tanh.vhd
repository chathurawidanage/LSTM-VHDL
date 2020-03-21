library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tanh is
    Port (
        A: in std_logic_vector(31 downto 0);
        O: out std_logic_vector(31 downto 0);
        CLK : in std_logic
    );
end tanh;

architecture tanh of tanh is

    component float_multiplier
        Port ( 
            A, B: in std_logic_vector(31 downto 0);
            O : out std_logic_vector(31 downto 0);
            CLK : in std_logic
        );
    end component;
    
    component float_adder
        Port (
            clk: in std_logic;
            f1: in std_logic_vector(31 downto 0);
            f2: in std_logic_vector(31 downto 0);
            out1: out std_logic_vector(31 downto 0)
        );
    end component;
    
    component sigmoid
        Port ( Y : in STD_LOGIC_VECTOR (31 downto 0);
           O : out STD_LOGIC_VECTOR (31 downto 0);
           clk: in STD_LOGIC );
    end component;
     
    signal two: std_logic_vector(31 downto 0) := "01000000000000000000000000000000";
    signal neg_one: std_logic_vector(31 downto 0) := "10111111100000000000000000000000";
    signal twox: std_logic_vector(31 downto 0);
    signal sig_out: std_logic_vector(31 downto 0);
    signal two_sig: std_logic_vector(31 downto 0);
    
begin
    twox_calc: float_multiplier port map(A=> two, B=>A, CLK => CLK, O=> twox);
    sigm: sigmoid port map (Y=>twox, O=>sig_out, clk=>CLK);
    t_sig : float_multiplier port map(A=> two, B=> sig_out, O=> two_sig, CLK=>CLK);
    fin_out: float_adder port map (f1=> two_sig, f2=> neg_one, out1=>O, clk=>CLK);
end tanh;
