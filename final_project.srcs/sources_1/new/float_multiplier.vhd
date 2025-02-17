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
    variable x_sign: std_logic;
    variable x_exponent: std_logic_vector(8 downto 0);
    variable x_mantissa: std_logic_vector(23 downto 0);

    variable y_sign: std_logic;
    variable y_exponent: std_logic_vector(8 downto 0);
    variable y_mantissa: std_logic_vector(23 downto 0);

    -- output variables
    variable z_sign: std_logic;
    variable z_exponent: std_logic_vector(7 downto 0);
    variable z_mantissa: std_logic_vector(22 downto 0);

    variable mantissa_mul : std_logic_vector(47 downto 0);

    variable sum_exponent : STD_LOGIC_VECTOR (8 downto 0);
	variable carry : STD_LOGIC:='0';
	variable carry1 : STD_LOGIC:='0';
	variable temp1: STD_LOGIC_VECTOR (8 downto 0) ;
	variable temp : STD_LOGIC_VECTOR (8 downto 0) ;
	variable temp_multiply : STD_LOGIC_VECTOR (47 downto 0) ;
	variable multiply_store : STD_LOGIC_VECTOR (47 downto 0) ;
	variable multiply_store_temp : STD_LOGIC_VECTOR (47 downto 0) ;
	variable multiply_rounder : STD_LOGIC_VECTOR (22 downto 0);

    begin
        if rising_edge(CLK) then
           -- assigning values to the variables
           x_sign := A(31);
           y_sign := B(31);
           z_sign := x_sign xor y_sign;

           x_exponent(7 downto 0) := A(30 downto 23);
           y_exponent(7 downto 0) := B(30 downto 23);
           x_exponent(8) := '0';
           y_exponent(8) := '0';

           x_mantissa(22 downto 0) := A(22 downto 0);
           x_mantissa(23) := '1';
           y_mantissa(22 downto 0) := B(22 downto 0);
           y_mantissa(23) := '1';

           -- handle infinity case
           if x_exponent="011111111" or y_exponent="011111111" then
            z_exponent := "11111111";
            z_mantissa := (others=>'0');

           elsif x_exponent="000000000" or y_exponent="000000000" then
            z_exponent := (others=>'0');
            z_mantissa := (others=>'0');
           else
            temp := "001111111" ; --value of temp assigned to 127
			temp1 := "000000001"; --value of temp assigned to 1
			temp_multiply := (others =>'0'); --making temp_multiply initially zero
			multiply_store := (others => '0'); --making multiply_store initially zero
			multiply_store_temp := (others => '0') ; ---making multiply_store_temp initially zero

			multiply_rounder := (others => '0');
			multiply_rounder(0) := '1'; --Making multiply_rounder eqaul to 1

			--Adding 1 as MSB to each mantissa for multiplication
			x_mantissa(23) := '1';
			y_mantissa(23) := '1';

			--Multiplying mantissas by adding and shifting
			for J in 0 to 23 loop
				temp_multiply := (others => '0'); --Making temp_multiply zero after each iteration
				if(y_mantissa(J)='1') then
					--In x_mantissa*y_mantissa assigning temp_multiply equal to x_mantissa
					--and shifting relevantly
					temp_multiply(23+J downto J) := x_mantissa;
				end if;

				--Multiplied value is stored in multiply_store
				multiply_store_temp := multiply_store;--multiply_store_temp values is equaled to multiply_store for full adder operation

				--48 bit Full adder
				for I in 0 to 47 loop
					multiply_store(I) := multiply_store_temp(I) xor temp_multiply(I) xor carry;
					carry  := ( multiply_store_temp(I) and temp_multiply(I) ) or ( multiply_store_temp(I) and carry ) or ( temp_multiply(I) and carry );
				end loop;
			end loop;

			carry := '0' ; --Reassigning to zero
			carry1 := '0'; --Reassigning to zero

			--Simply Adding x_exponent and y_exponent
			for I in 0 to 8 loop
				sum_exponent(I) := x_exponent(I) xor y_exponent(I) xor carry ;
				carry := ( x_exponent(I) and y_exponent(I) ) or ( x_exponent(I) and carry ) or ( y_exponent(I) and carry ) ;
			end loop;

			carry := '0' ; --Reassigning to zero
			carry1 := '0'; --Reassigning to zero

			if(multiply_store(47)='1') then
				--Increasing the exponent
				for I in 0 to 8 loop
					carry := sum_exponent(I) ;
					sum_exponent(I) :=  carry xor temp1(I) xor carry1 ;
					carry1 := (temp1(I) and carry ) or ( temp1(I) and carry1 ) or ( carry and carry1 ) ;
				end loop;

				--Assigning value to z's mantissa
				z_mantissa := multiply_store(46 downto 24);

				carry := '0' ; --Reassigning to zero
				carry1 := '0'; --Reassigning to zero
				multiply_rounder(0) := multiply_store(23);--can be zero or one on need

				--Rounding of mantissa
				for I in 0 to 22 loop
					carry := z_mantissa(I) ;
					z_mantissa(I) :=  carry xor multiply_rounder(I) xor carry1 ;
					carry1 := (multiply_rounder(I) and carry ) or ( multiply_rounder(I) and carry1 ) or ( carry and carry1 ) ;
				end loop;
			else
				--Assigning value to z's mantissa
				z_mantissa := multiply_store(45 downto 23);

				carry := '0' ; --Reassigning to zero
				carry1 := '0'; --Reassigning to zero
				multiply_rounder(0) := multiply_store(22);--can be zero or one on need

				--Rounding of mantissa
				for I in 0 to 22 loop
					carry := z_mantissa(I) ;
					z_mantissa(I) :=  carry xor multiply_rounder(I) xor carry1 ;
					carry1 := (multiply_rounder(I) and carry ) or ( multiply_rounder(I) and carry1 ) or ( carry and carry1 ) ;
				end loop;
			end if;

			--z_exponent:=z_exponent - 127;
			for I in 0 to 8 loop
				carry := sum_exponent(I) ;
				sum_exponent(I) :=  carry xor temp(I) xor carry1 ;
				carry1 := ( carry1 and Not carry ) or ( temp(I) and Not carry ) or (temp(I) and carry1) ;
			end loop;

			if (sum_exponent(8)='1') then
				if (sum_exponent(7)='0') then -- overflow
					z_exponent := "11111111";
					z_mantissa := (others => '0');
					z_sign := x_sign xor y_sign;
				else 									-- underflow negative representaion
					z_exponent := (others => '0');
					z_mantissa := (others => '0');
					z_sign := '0';
				end if;
			else								  		 -- Ok
				z_exponent := sum_exponent(7 downto 0);
				z_sign := x_sign xor y_sign;
			end if;

			z_sign := x_sign xor y_sign;
           end if;

           -- assign values to the output
           O(31)<= z_sign;
           O(30 downto 23) <= z_exponent;
           O(22 downto 0) <= z_mantissa;
        end if;
    end process;

end float_multiplier;
