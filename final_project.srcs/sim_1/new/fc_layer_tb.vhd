library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fc_layer_tb is
--  Port ( );
end fc_layer_tb;

architecture fc_layer_tb of fc_layer_tb is

    constant ClockFrequency : integer := 100e6;
    constant ClockPeriod : time := 1000 ms / ClockFrequency;
    
    signal clk : std_logic := '1';

    component fc_layer
        port(
            clk: in std_logic;
            input: in std_logic_vector(255 downto 0);
            output: out std_logic_vector(31 downto 0)
        );
     end component;
     
     signal input : std_logic_vector(255 downto 0);
     signal output :  std_logic_vector(31 downto 0);
begin

    UUT: fc_layer port map(input=>input, output=>output, clk=>clk);

    clk <= not clk after ClockPeriod / 2;

    stim_proc: process
    begin
        
        input <= x"bf08edf73f50cfda3f1f31d4bf445c02bf2bcf38bf1337e9beffdae93f2992f5";
        -- 4073313e
        wait for 200 ns;
        wait;
    end process;
end fc_layer_tb;
