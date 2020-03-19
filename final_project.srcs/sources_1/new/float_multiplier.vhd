----------------------------------------------------------------------------------
-- Company: Indiana University
-- Engineer: Chathura Widanage
-- 
-- Create Date: 03/10/2020 10:33:13 PM
-- Design Name: 
-- Module Name: float_adder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity float_multiplier is
    Port ( 
        A, B: in std_logic_vector(31 downto 0);
        O : out std_logic_vector(31 downto 0);
        CLK : in std_logic
    );
end float_multiplier;

architecture float_multiplier of float_multiplier is

   
begin
    sync_stuff: process (CLK, A, B)
    -- declaring variables
    variable a_sign: std_logic;
    variable a_exponent: std_logic_vector(7 downto 0);
    variable a_mantissa: std_logic_vector(23 downto 0);
    
    variable b_sign: std_logic;
    variable b_exponent: std_logic_vector(7 downto 0);
    variable b_mantissa: std_logic_vector(23 downto 0);
    
    -- output variables
    variable o_sign: std_logic;
    variable o_exponent: std_logic_vector(7 downto 0);
    variable o_mantissa: std_logic_vector(22 downto 0);
    
    variable mantissa_mul : std_logic_vector(47 downto 0);
    
    variable x,y: integer;
    variable z: integer;
    
    begin
        if rising_edge(CLK) then
           -- assigning values to the variables
           a_sign := A(31);
           b_sign := B(31);
           o_sign := a_sign xor b_sign;
           
           a_exponent(7 downto 0) := A(30 downto 23);
           b_exponent(7 downto 0) := B(30 downto 23);
           
           a_mantissa(22 downto 0) := A(22 downto 0);
           a_mantissa(23) := '1';
           b_mantissa(22 downto 0) := B(22 downto 0);
           b_mantissa(23) := '1';
           
           -- handle infinity case
           if a_exponent="011111111" or b_exponent="011111111" then
            o_exponent := "11111111";
            o_mantissa := (others=>'0');
            
           elsif a_exponent="000000000" or b_exponent="000000000" then
            o_exponent := (others=>'0');
            o_mantissa := (others=>'0');
           else
            x := to_integer(unsigned(a_mantissa));
            y := to_integer(unsigned(b_mantissa));
            z := x*y;
            mantissa_mul := std_logic_vector(to_unsigned(z, mantissa_mul'length));
            o_mantissa := mantissa_mul(46 downto 24);
            
            o_exponent := std_logic_vector(to_signed(to_integer(unsigned(a_exponent)) + to_integer(unsigned(b_exponent)) - 127, o_exponent'length));
           end if;
           
           -- assign values to the output
           O(31)<= o_sign;
           O(30 downto 23) <= o_exponent;
           O(22 downto 0) <= o_mantissa;
        end if;
    end process;

end float_multiplier;