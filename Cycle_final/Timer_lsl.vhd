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
	SIGNAL NUM1 :INTEGER range -100 to 100 :=0;	--NUM1��ΪK1���µ���Ӧ
	SIGNAL NUM2 :INTEGER range -100 to 100 :=0;	--NUM2��ΪK2���µ���Ӧ
	SIGNAL SUM :INTEGER range -2 to 2 :=0;			--SUMͳ��K1��K2�Ĺ�ͬ��Ӧ
  begin
  CLKOUT <= clk_data; 
  CLKOUT1 <= clk1_data;
  CLKOUTc1 <= clkc1_data;
  CLKOUT2 <= clk2_data;
  CLKOUTc2 <= clkc2_data;	
  SUM <= NUM1+NUM2;
  N <= SUM;											--��Ƶ��һ��������ʱ���źţ��������ѡһ����ѡ������ͨ��NҲ���ǣ�SUM)��ѡ�������һ��ʱ���ź���Ϊ����״̬����ʱ������
   REGz: PROCESS(K1)									--��K1����Ӧ����
      BEGIN
      IF K1 = '0' and K1'event then			
      if SUM < 2 then						--��SUM������2ʱ�ſ��Լ�1
      NUM1 <= NUM1+1;
      end if;
      END IF;
	  END PROCESS;
 REGc: PROCESS(K2)									--��K2����Ӧ����
      BEGIN
      IF K2 = '0' and K2'event then
      if SUM > -2 then
      NUM2 <= NUM2-1;
      end if;
      END IF;
	  END PROCESS;
 clk: process(CLKIN,SUM)								--����Ϊ�����Ƶ����
  variable  count:integer range 0 to 10000000;
  begin 
  if SUM = 0 THEN						--��SUM��ֵ�����ٶȵĵ�λ�����ж�
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