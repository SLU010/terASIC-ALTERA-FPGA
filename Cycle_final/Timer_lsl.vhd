library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity Timer_lsl is
port(CLKIN		:in std_logic;   
	K1			:in std_logic;
	K2			:in std_logic;
	CLKOUT		:out std_logic;
	CLKOUT1		:out std_logic;
	CLKOUT2		:out std_logic;
	CLKOUTc1	:out std_logic;
	CLKOUTc2	:out std_logic;
	N:out INTEGER range -2 to 2
);
end Timer_lsl;
architecture bhv of Timer_lsl is    

	signal clk_data,clk1_data,clkc1_data,clk2_data,clkc2_data:std_logic:='0';
	SIGNAL NUM1 :INTEGER range -100 to 100 :=0;	--NUM1作为K1按下的响应
	SIGNAL NUM2 :INTEGER range -100 to 100 :=0;	--NUM2作为K2按下的响应
	SIGNAL SUM :INTEGER range -2 to 2 :=0;			--SUM统计K1、K2的共同响应
  begin
  CLKOUT <= clk_data; 
  CLKOUT1 <= clk1_data;
  CLKOUTc1 <= clkc1_data;
  CLKOUT2 <= clk2_data;
  CLKOUTc2 <= clkc2_data;	
  SUM <= NUM1+NUM2;
  N <= SUM;											--分频器一共输出五个时钟信号，输出到五选一数据选择器，通过N也就是（SUM)，选择出其中一个时钟信号作为有限状态机的时钟输入
   REGz: PROCESS(K1)									--对K1的响应进程
      BEGIN
      IF K1 = '0' and K1'event then			
      if SUM < 2 then						--当SUM不超过2时才可以加1
      NUM1 <= NUM1+1;
      end if;
      END IF;
	  END PROCESS;
 REGc: PROCESS(K2)									--对K2的响应进程
      BEGIN
      IF K2 = '0' and K2'event then
      if SUM > -2 then
      NUM2 <= NUM2-1;
      end if;
      END IF;
	  END PROCESS;
 clk: process(CLKIN,SUM)								--以下为五个分频进程
  variable  count:integer range 0 to 10000000;
  begin 
  if SUM = 0 THEN						--对SUM的值（即速度的档位进行判断
	  if CLKIN'event and CLKIN='1' then 
	   if count=10000000 then         
		count:=0;    
		clk_data<=not clk_data;
	   else count:=count+1; 
		end if;
	  end if;
  END IF;
      end process;
 clk1: process(CLKIN,SUM)
  variable  count1:integer range 0 to 5000000;
  begin  
  IF SUM = 1 THEN 
	  if CLKIN'event and CLKIN='1' then 
	   if count1=5000000 then         
		count1:=0;    
		clk1_data<=not clk1_data;
		
	   else count1:=count1+1; 
		end if;
	  end if;
  END IF;
      end process;
 clk2: process(CLKIN,SUM)
  variable  count2:integer range 0 to 2500000;
  begin  
  IF SUM = 2 THEN 
	  if CLKIN'event and CLKIN='1' then 
	   if count2=2500000 then         
		count2:=0;    
		clk2_data<=not clk2_data;
		
	   else count2:=count2+1; 
		end if;
	  end if;
  END IF;
      end process;
 clkc1: process(CLKIN,SUM)
  variable  countc1:integer range 0 to 20000000;
  begin  
  IF SUM = -1 THEN 
	  if CLKIN'event and CLKIN='1' then 
	   if countc1=20000000 then         
		countc1:=0;    
		clkc1_data<=not clkc1_data;
		
	   else countc1:=countc1+1; 
		end if;
	  end if;
  END IF;
      end process;
 clkc2: process(CLKIN,SUM)
  variable  countc2:integer range 0 to 40000000;
  begin  
  IF SUM = -2 THEN 
	  if CLKIN'event and CLKIN='1' then 
	   if countc2=40000000 then         
		countc2:=0;    
		clkc2_data<=not clkc2_data;
		
	   else countc2:=countc2+1; 
		end if;
	  end if;
  END IF;
      end process;    
      end bhv;