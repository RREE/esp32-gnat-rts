--  SPDX-FileCopyrightText: 2021 Max Reznik <reznikmm@gmail.com>
--
--  SPDX-License-Identifier: MIT
-------------------------------------------------------------

--  Rewrite of the uart_echo example in esp-idf. It echos any data it
--  receives on configured UART back to the sender, with hardware flow
--  control turned off. It does not use UART driver event queue.

-- with Ada.Real_Time;
with ESP32; use ESP32;
with ESP32.GPIO;
with ESP32.UART;
with ESP32.UART_Types;
with Interfaces;   use Interfaces;

procedure Uart_Echo
   with No_Return
is
   use type Uart.Uart_Data_Index;
   use Uart_Types;

   Uart_Port : constant Uart.Port_Num := 0;
   Buffer_Size : constant := 1024;

   Uart_Config      : Uart_Config_T;
   Echo_Baud_Rate   : constant := 115_200;
   Echo_Rx_Pin      : constant := 3;
   Echo_Tx_Pin      : constant := 1;
   Intr_Alloc_Flags : Unsigned_32;


   subtype Data_Index is Uart.Uart_Data_Index range 0 .. Buffer_Size-1;
   Data : Uart.Uart_Data (Data_Index);
   Len  : Data_Index := 0;
begin
   Uart_Config := (Baud_Rate  => Echo_Baud_Rate,
                   Data_Bits  => Data_8_Bits,
                   Parity     => Parity_Disable,
                   Stop_Bits  => Stop_Bits_1,
                   Flow_Ctrl  => Hw_Flowctrl_Disable,
                   Rx_Flow_Ctrl_Thresh => 0,
                   Source_Clk => Sclk_Apb);

   Uart.Driver_Install (Port             => Uart_Port,
                        Rx_Buffer_Size   => Buffer_Size*2,
                        Tx_Buffer_Size   => 0,
                        Queue_Size       => 0,
                        -- Event_Queue        => No_Event,
                        Intr_Alloc_Flags => Intr_Alloc_Flags);
   Uart.Param_Config (Uart_Port, Uart_Config);
   Uart.Set_Pin (Uart_Port, Echo_Tx_Pin, Echo_Rx_Pin);

   loop
      --  Uart.Read_Bytes (Uart_Port, Data, Len, 20);
      --  if Len > 0 then
      --     UART.Write_Bytes (Uart_Port, Data (0..Len-1));
      --  end if;
      Data := (16#30#, 16#39#, others => 16#64#);
      Uart.Write_Bytes (Uart_Port, Data (1 ..2));
   end loop;

   --  Make sure that main subprogram doen't return in a real project!
end Uart_Echo;
