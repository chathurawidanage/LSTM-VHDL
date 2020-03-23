library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mult_1_x_tb is
--  Port ( );
end mult_1_x_tb;

architecture mult_1_x_tb of mult_1_x_tb is
    constant ClockFrequency : integer := 100e6;
    constant ClockPeriod : time := 1000 ms / ClockFrequency;
    
    signal clk : std_logic := '1';
    
    component mutl_1_x
        port(
        clk: in std_logic;
        x: in std_logic_vector(31 downto 0);
        y: in std_logic_vector(255 downto 0);
        x_rows: in integer;
        x_cols: in integer;
        y_rows: in integer;
        y_cols: in integer;
        o: out std_logic_vector(255 downto 0)
        );
    end component;
    signal x: std_logic_vector(31 downto 0) := (others => '0');
    signal y: std_logic_vector(255 downto 0) := (others => '0');
    signal o: std_logic_vector(255 downto 0) := (others => '0');
    signal x_rows: integer := 4;
    signal x_cols: integer := 4;
    signal y_rows: integer := 4;
    signal y_cols: integer := 4;
begin

    MM: mutl_1_x port map (
        x => x,
        y => y,
        x_rows => x_rows,
        x_cols => x_cols,
        y_rows => y_rows,
        y_cols => y_cols,
        o => o,
        clk => clk
    );
    
    clk <= not clk after ClockPeriod / 2;
    
    process is
    begin
        x <= x"3fa00000"; -- 1.25
        y <= x"3e8000003e8000003e8000003e8000003e8000003e8000003e8000003e800000"; -- 0.25
        
        wait for 60 ns;
        x <= x"3e800000";
        y <= x"3fa000003fa000003fa000003fa000003fa000003fa000003fa000003fa00000";
    
        wait for 60 ns;
        
        wait;
    end process;

end mult_1_x_tb;
