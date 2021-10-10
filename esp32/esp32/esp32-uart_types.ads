-- #include "soc/soc_caps.h"

package ESP32.Uart_Types is
   pragma Pure;
   pragma Discard_Names;

   -- UART mode selection
   type Uart_Mode
     is (
         Mode_Uart,                   -- 0x00, regular UART mode
         Mode_Rs485_Half_Duplex,      -- 0x01, half duplex RS485 UART mode control by RTS pin
         Mode_Irda,                   -- 0x02, IRDA UART mode
         Mode_Rs485_Collision_Detect, -- 0x03, RS485 collision detection UART mode (used for test purposes)
         MODE_RS485_APP_CTRL          -- 0x04 application control RS485 UART mode (used for test purposes)
        );

   -- UART word length constants
   type Nr_Of_Data_Bits
     is (
         Data_5_Bits,  -- 0x0, word length: 5bits
         Data_6_Bits,  -- 0x1, word length: 6bits
         Data_7_Bits,  -- 0x2, word length: 7bits
         Data_8_Bits,  -- 0x3, word length: 8bits
         Data_Bits_Max -- 0x4
        );


   -- UART stop bits number
   type Nr_Of_Stop_Bits
     is (
         Stop_Bits_0,   -- dummy to get the correct representation
         Stop_Bits_1,   -- 0x1, stop bit: 1bit
         Stop_Bits_1_5, -- 0x2, stop bit: 1.5bits
         Stop_Bits_2,   -- 0x3, stop bit: 2bits
         Stop_Bits_Max  -- 0x4
        );


   -- UART parity constants
   type Parity_Mode
     is (
         Parity_Disable, -- 0x0,  --!< Disable UART parity*/
         Parity_Dummy,   -- dummy for correct representation value
         Parity_Even,    -- 0x2,  --!< Enable UART even parity*/
         Parity_Odd      -- 0x3   --!< Enable UART odd parity*/
        );

--  --*
--   * @brief UART hardware flow control modes
--   */
--  typedef enum {
--      UART_HW_FLOWCTRL_DISABLE = 0x0,   --!< disable hardware flow control*/
--      UART_HW_FLOWCTRL_RTS     = 0x1,   --!< enable RX hardware flow control (rts)*/
--      UART_HW_FLOWCTRL_CTS     = 0x2,   --!< enable TX hardware flow control (cts)*/
--      UART_HW_FLOWCTRL_CTS_RTS = 0x3,   --!< enable hardware flow control*/
--      UART_HW_FLOWCTRL_MAX     = 0x4,
--  } uart_hw_flowcontrol_t;

--  --*
--   * @brief UART signal bit map
--   */
--  typedef enum {
--      UART_SIGNAL_INV_DISABLE  =  0,            --!< Disable UART signal inverse*/
--      UART_SIGNAL_IRDA_TX_INV  = (0x1 << 0),    --!< inverse the UART irda_tx signal*/
--      UART_SIGNAL_IRDA_RX_INV  = (0x1 << 1),    --!< inverse the UART irda_rx signal*/
--      UART_SIGNAL_RXD_INV      = (0x1 << 2),    --!< inverse the UART rxd signal*/
--      UART_SIGNAL_CTS_INV      = (0x1 << 3),    --!< inverse the UART cts signal*/
--      UART_SIGNAL_DSR_INV      = (0x1 << 4),    --!< inverse the UART dsr signal*/
--      UART_SIGNAL_TXD_INV      = (0x1 << 5),    --!< inverse the UART txd signal*/
--      UART_SIGNAL_RTS_INV      = (0x1 << 6),    --!< inverse the UART rts signal*/
--      UART_SIGNAL_DTR_INV      = (0x1 << 7),    --!< inverse the UART dtr signal*/
--  } uart_signal_inv_t;

--  --*
--   * @brief UART source clock
--   */
--  typedef enum {
--      UART_SCLK_APB = 0x0,            --!< UART source clock from APB*/
--  #if SOC_UART_SUPPORT_RTC_CLK
--      UART_SCLK_RTC = 0x1,            --!< UART source clock from RTC*/
--  #endif
--  #if SOC_UART_SUPPORT_XTAL_CLK
--      UART_SCLK_XTAL = 0x2,           --!< UART source clock from XTAL*/
--  #endif
--  #if SOC_UART_SUPPORT_REF_TICK
--      UART_SCLK_REF_TICK = 0x3,       --!< UART source clock from REF_TICK*/
--  #endif
--  } uart_sclk_t;

--  --*
--   * @brief UART AT cmd char configuration parameters
--   *        Note that this function may different on different chip. Please refer to the TRM at confirguration.
--   */
--  typedef struct {
--      uint8_t  cmd_char;             --!< UART AT cmd char*/
--      uint8_t  char_num;             --!< AT cmd char repeat number*/
--      uint32_t gap_tout;             --!< gap time(in baud-rate) between AT cmd char*/
--      uint32_t pre_idle;             --!< the idle time(in baud-rate) between the non AT char and first AT char*/
--      uint32_t post_idle;            --!< the idle time(in baud-rate) between the last AT char and the none AT char*/
--  } uart_at_cmd_t;

--  --*
--   * @brief UART software flow control configuration parameters
--   */
--  typedef struct {
--      uint8_t  xon_char;      --!< Xon flow control char*/
--      uint8_t  xoff_char;     --!< Xoff flow control char*/
--      uint8_t xon_thrd;      --!< If the software flow control is enabled and the data amount in rxfifo is less than xon_thrd, an xon_char will be sent*/
--      uint8_t xoff_thrd;       --!< If the software flow control is enabled and the data amount in rxfifo is more than xoff_thrd, an xoff_char will be sent*/
--  } uart_sw_flowctrl_t;

--  --*
--   * @brief UART configuration parameters for uart_param_config function
--   */
--  typedef struct {
--      int baud_rate;                      --!< UART baud rate*/
--      uart_word_length_t data_bits;       --!< UART byte size*/
--      uart_parity_t parity;               --!< UART parity mode*/
--      uart_stop_bits_t stop_bits;         --!< UART stop bits*/
--      uart_hw_flowcontrol_t flow_ctrl;    --!< UART HW flow control mode (cts/rts)*/
--      uint8_t rx_flow_ctrl_thresh;        --!< UART HW RTS threshold*/
--      union {
--          uart_sclk_t source_clk;         --!< UART source clock selection */
--          bool use_ref_tick  __attribute__((deprecated)); --!< Deprecated method to select ref tick clock source, set source_clk field instead */
--      };
--  } uart_config_t;

end Esp32.Uart_Types;
