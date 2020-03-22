library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity m2_1n_to_nn_tb is
--  Port ( );
end m2_1n_to_nn_tb;

architecture m2_1n_to_nn_tb of m2_1n_to_nn_tb is

    constant ClockFrequency : integer := 100e6;
    constant ClockPeriod : time := 1000 ms / ClockFrequency;

    component m2_1n_to_nn
        Port ( 
            A: in std_logic_vector(255 downto 0);
            B: in std_logic_vector(2047 downto 0);
            O : out std_logic_vector(255 downto 0);
            CLK : in std_logic
        );
    end component;
    
    signal CLK: std_logic := '0';
    signal A: std_logic_vector(255 downto 0);
    signal B: std_logic_vector(2047 downto 0);
    signal O : std_logic_vector(255 downto 0);
begin

    CLK <= not CLK after ClockPeriod / 2;
    
    uut: m2_1n_to_nn port map (CLK=>CLK, A=>A, B=>B, O=>O);
    stim_proc: process
    begin
    A <= x"3e8000003e8000003e8000003e8000003e8000003e8000003e8000003fa00000"; -- 0.25
    B <= x"3e8000003e8000003e8000003e8000003e8000003e8000003e8000003fa000003e8000003e8000003e8000003e8000003e8000003e8000003e8000003fa000003e8000003e8000003e8000003e8000003e8000003e8000003e8000003fa000003e8000003e8000003e8000003e8000003e8000003e8000003e8000003fa000003e8000003e8000003e8000003e8000003e8000003e8000003e8000003fa000003e8000003e8000003e8000003e8000003e8000003e8000003e8000003fa000003e8000003e8000003e8000003e8000003e8000003e8000003e8000003fa000003e8000003e8000003e8000003e8000003e8000003e8000003e8000003fa00000"; -- 1.25
    
    wait for 1000 ns;
    std.env.stop;
    end process;
end m2_1n_to_nn_tb;
