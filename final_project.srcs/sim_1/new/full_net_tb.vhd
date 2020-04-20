library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.textio.all;
use ieee.std_logic_textio.all;


entity full_net_tb is
--  Port ( );
end full_net_tb;

architecture full_net_tb of full_net_tb is

    constant ClockFrequency : integer := 500e6;
    constant ClockPeriod : time := 1000 ms / ClockFrequency;
    
    signal clk : std_logic := '1';

    component full_net
        port(
            clk: in std_logic;
            net_in: in std_logic_vector(223 downto 0);
            net_out: out std_logic_vector(31 downto 0)
        );
     end component;
     
     signal net_in : std_logic_vector(223 downto 0);
     signal net_out :  std_logic_vector(31 downto 0);
     
     file file_inputs : text;
     file file_outputs : text;
     shared variable iline : line;
     shared variable oline: line;
     shared variable read_net_in : std_logic_vector(223 downto 0);
begin

    UUT: full_net port map(net_in=>net_in, net_out=>net_out, clk=>clk);

    clk <= not clk after ClockPeriod / 2;

    stim_proc: process
    begin
    
        file_open(file_inputs, "/tmp/input_vectors.txt",  read_mode);
        file_open(file_outputs, "/tmp/output_results.txt", write_mode);
        
        while not endfile(file_inputs) loop
            readline(file_inputs, iline);
            hread(iline,read_net_in);
        
            net_in <= read_net_in;
            ---x"406089e840452e0f40460634405447bd4045d503405fff1e406c785c";
            -- 40612aae   3.5182299614
            -- 40607297   3.50699400902
            wait for 200 ns;
            
            hwrite(oline,net_out,right,32);
            writeline(file_outputs,oline);
        end loop;
        
        file_close(file_inputs);
        file_close(file_outputs);
        
        wait;
    end process;
end full_net_tb;
