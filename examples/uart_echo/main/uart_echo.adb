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

procedure Uart_Echo
   with No_Return
is
   use type Uart.Uart_Data_Index;

   Uart_Port : constant Uart.Port_Num := 0;
   Buffer_Size : constant := 1024;

   subtype Data_Index is Uart.Uart_Data_Index range 0 .. Buffer_Size-1;
   Data : Uart.Uart_Data (Data_Index);
   Len  : Data_Index := 0;
begin
   --  GPIO.Configure_All
   --    (((Pad       => Led,
   --       IO_MUX    => GPIO.GPIO_Matrix,
   --       Direction => GPIO.Output,
   --       Output    => GPIO.GPIO_Out),  --  for Set_Level
   --      (Pad       => Button,
   --       IO_MUX    => GPIO.GPIO_Matrix,
   --       Direction => GPIO.Input,
   --       Interrupt => GPIO.Disabled,
   --       Input     => GPIO.None)));    --  for Get_Level

   loop
      Uart.Read_Bytes (Uart_Port, Data, Len, 20);
      if Len > 0 then
         UART.Write_Bytes (Uart_Port, Data (0..Len-1));
      end if;
   end loop;

   --  Make sure that main subprogram doen't return in a real project!
end Uart_Echo;
