library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity Timer_lsl is
port(CLKIN	:in std_logic;   
	 CLKOUT	:out std_logic
);
end Timer_lsl;
architecture bhv of Timer_lsl is
	signal count:integer range 0 to 10000000;     
	signal clk_data:std_logic;
  begin
  process(CLKIN,count)
  begin  
  if CLKIN'event and CLKIN='1' then 
   if count=10000000 then         
    count<=0;    
    clk_data<=not clk_data;
   else count<=count+1; 
    end if;
  end if;
      CLKOUT<=clk_data;
      end process;
      end bhv;
