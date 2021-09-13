LIBRARY	IEEE;
USE	IEEE.STD_LOGIC_1164.ALL;
entity mux21a is
port(c0,c1,cc1,c2,cc2:in std_logic;
		s: in integer range -2 to 2;
		y:out std_logic);
end entity mux21a;
architecture one of mux21a is
begin
process (c0,c1,cc1,c2,cc2,s)
begin
case s is
when 0 => y<=c0;
when 1 => y<=c1;
when -1 => y<=cc1;
when 2 => y<=c2;
when -2 => y<=cc2;
when others => NULL;

end case;
end process;
end one;