
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_net is
    port(
        clk: in std_logic;
        net_in: in std_logic_vector(223 downto 0);
        net_out: out std_logic_vector(31 downto 0)
    );
end full_net;

architecture full_net of full_net is
    
    component lstm_layer
        port(
            clk: in std_logic;
            c_in: in std_logic_vector(255 downto 0);
            h_in: in std_logic_vector(255 downto 0);
            x: in std_logic_vector(223 downto 0);
            c_out: out std_logic_vector(255 downto 0);
            h_out: out std_logic_vector(255 downto 0)
        );
    end component;

    component fc_layer
        port(
            clk: in std_logic;
            input: in std_logic_vector(255 downto 0);
            output: out std_logic_vector(31 downto 0)
        );
    end component;
    
    signal lstm_out: std_logic_vector(255 downto 0); 
    signal c_in : std_logic_vector(255 downto 0) := (others => '0');
    signal h_in : std_logic_vector(255 downto 0) := (others => '0'); 
    
begin
    lstm1: lstm_layer port map (
        clk => clk,
        c_in => c_in,
        h_in => h_in,
        x => net_in,
        h_out => lstm_out
    );

    fc1: fc_layer port map(
        clk => clk,
        input => lstm_out,
        output => net_out
    );
    
end full_net;
