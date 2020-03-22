library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity m2_1n_to_nn is
    Port ( 
        A: in std_logic_vector(255 downto 0);
        B: in std_logic_vector(2047 downto 0);
        O : out std_logic_vector(255 downto 0);
        CLK : in std_logic
    );
end m2_1n_to_nn;

architecture m2_1n_to_nn of m2_1n_to_nn is

component em
   Port (
        A,B : in std_logic_vector(255 downto 0);
        O : out std_logic_vector(255 downto 0);
        CLK : in std_logic
    );    
end component;

component array_elem_sum
    Port (
        A : in std_logic_vector(255 downto 0);
        O: out std_logic_vector(31 downto 0);
        CLK : in std_logic
     );
end component;

signal B_T: std_logic_vector(2047 downto 0);
signal B_T_MUL: std_logic_vector(2047 downto 0);

shared variable i,j: integer := 0;

begin
               
   row_loop:
    for i in 7 downto 0 generate
        col_loop:
        for j in 7 downto 0 generate
            B_T(((256*j)+(32*(i+1))) - 1 downto ((256*j)+(32*i))) <= B(((256*i)+(32*(j+1))) - 1 downto ((256*i)+(32*j)));
        end generate col_loop;
        emx: em port map (A=>B_T((256*i) + 255 downto (256*i)), B=>A, O=> B_T_MUL((256*i) + 255 downto (256*i)), CLK=>CLK);
        smx: array_elem_sum port map(CLK=>CLK, A=>B_T_MUL((256*i) + 255 downto (256*i)), O=>O((32*i) + 31 downto (32*i)));
    end generate row_loop;
end m2_1n_to_nn;
    
