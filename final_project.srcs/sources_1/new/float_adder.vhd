

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity float_adder is
    port (
    clk: in std_logic;
    f1: in std_logic_vector(31 downto 0);
    f2: in std_logic_vector(31 downto 0);
    out1: out std_logic_vector(31 downto 0)
    );
end float_adder;

architecture float_adder of float_adder is

begin
    process(clk) is
    variable e1: unsigned(7 downto 0) := (others => '0');
    variable e2: unsigned(7 downto 0) := (others => '0');
    variable newe: unsigned(7 downto 0) := (others => '0');
    variable m1: std_logic_vector(22 downto 0) := (others => '0');
    variable m2: std_logic_vector(22 downto 0) := (others => '0');
    
    variable newm1: unsigned(24 downto 0) := (others => '0');
    variable newm2: unsigned(24 downto 0) := (others => '0');
    variable addm: std_logic_vector(24 downto 0) := (others => '0');
    variable newm: std_logic_vector(22 downto 0) := (others => '0');

    variable dif: integer := 0;
    
    variable over: integer := 1;
    variable shift: integer := 0;
    variable mval: std_logic_vector(24 downto 0) := (others => '0');
    
    variable tempe: integer := 0;

    variable sign: std_logic := '0';
    begin
        if rising_edge(clk) then
             e1 := unsigned(f1(30 downto 23));
             e2 := unsigned(f2(30 downto 23));
             m1 := f1(22 downto 0);
             m2 := f2(22 downto 0);
             
             -- Determine the smallest exponent and shift mantessa
             if e1 < e2 then
                 dif := to_integer(e2 - e1);
                
                 newm1 := shift_right(unsigned("01" & m1), dif);
                 newm2 := unsigned("01" & m2);
                 
                 newe := e2;
             else
                 dif := to_integer(e1 - e2);
                 
                 newm1 := unsigned("01" & m1);
                 newm2 := shift_right(unsigned("01" & m2), dif);
                 
                 newe := e1;
             end if;
             
             -- Derrive final sign and mantessa
             if f1(31) = '1' then
                if f2(31) = '1' then
                    sign := '1';
                    addm := std_logic_vector(newm1 + newm2);
                else
                    if newm1 < newm2 then
                        sign := '0';
                        addm := std_logic_vector(newm2 - newm1);    
                    else
                        sign := '1';
                        addm := std_logic_vector(newm1 - newm2);
                    end if;
                end if;
             else
                if f2(31) = '1' then
                    if newm1 < newm2 then
                        sign := '1';
                        addm := std_logic_vector(newm2 - newm1);
                    else
                        sign := '0';
                        addm := std_logic_vector(newm1 - newm2);
                    end if;
                else
                    sign := '0';
                    addm := std_logic_vector(newm1 + newm2);
                end if;
             end if;
                       
             -- Normalize the mantessa          
             over := 1;
             shift := 0;
             for i in 24 downto 0 loop
                --report "Logic " & std_logic'image(m(i));
                 if addm(i) = '1' then
                     exit;
                 end if; 
                 over := over - 1;
                 shift := shift + 1;   
             end loop;
            
             addm := std_logic_vector(shift_left(unsigned(addm), shift));
            
             newm := addm(23 downto 1);

             tempe := to_integer(newe) + over;

             if tempe > -1 then
                newe := to_unsigned(tempe, 8);
             end if;
             
             -- Creating final output sign + exponent + mantessa
             out1 <= sign & std_logic_vector(newe) & newm;
        end if;
    end process;

end float_adder;
