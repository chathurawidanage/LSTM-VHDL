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
        
--    sm0: array_elem_sum port map(CLK=>CLK, A=>B_T_MUL(255 downto 0), O=>O(31 downto 0));
--    sm1: array_elem_sum port map(CLK=>CLK, A=>B_T_MUL(511 downto 256), O=>O(63 downto 32));
--    sm2: array_elem_sum port map(CLK=>CLK, A=>B_T_MUL(767 downto 512), O=>O(95 downto 64));
--    sm3: array_elem_sum port map(CLK=>CLK, A=>B_T_MUL(1023 downto 768), O=>O(127 downto 96));
--    sm4: array_elem_sum port map(CLK=>CLK, A=>B_T_MUL(1279 downto 1024), O=>O(159 downto 128));
--    sm5: array_elem_sum port map(CLK=>CLK, A=>B_T_MUL(1535 downto 1280), O=>O(191 downto 160));
--    sm6: array_elem_sum port map(CLK=>CLK, A=>B_T_MUL(1791 downto 1536), O=>O(223 downto 192));
--    sm7: array_elem_sum port map(CLK=>CLK, A=>B_T_MUL(2047 downto 1792), O=>O(255 downto 224));
end m2_1n_to_nn;
    
