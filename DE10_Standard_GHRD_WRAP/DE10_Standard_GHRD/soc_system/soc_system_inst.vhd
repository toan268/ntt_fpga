	component soc_system is
		port (
			button_pio_external_connection_export      : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- export
			clk_clk                                    : in    std_logic                     := 'X';             -- clk
			dipsw_pio_external_connection_export       : in    std_logic_vector(9 downto 0)  := (others => 'X'); -- export
			hps_0_f2h_cold_reset_req_reset_n           : in    std_logic                     := 'X';             -- reset_n
			hps_0_f2h_debug_reset_req_reset_n          : in    std_logic                     := 'X';             -- reset_n
			hps_0_f2h_stm_hw_events_stm_hwevents       : in    std_logic_vector(27 downto 0) := (others => 'X'); -- stm_hwevents
			hps_0_f2h_warm_reset_req_reset_n           : in    std_logic                     := 'X';             -- reset_n
			hps_0_h2f_reset_reset_n                    : out   std_logic;                                        -- reset_n
			hps_0_hps_io_hps_io_emac1_inst_TX_CLK      : out   std_logic;                                        -- hps_io_emac1_inst_TX_CLK
			hps_0_hps_io_hps_io_emac1_inst_TXD0        : out   std_logic;                                        -- hps_io_emac1_inst_TXD0
			hps_0_hps_io_hps_io_emac1_inst_TXD1        : out   std_logic;                                        -- hps_io_emac1_inst_TXD1
			hps_0_hps_io_hps_io_emac1_inst_TXD2        : out   std_logic;                                        -- hps_io_emac1_inst_TXD2
			hps_0_hps_io_hps_io_emac1_inst_TXD3        : out   std_logic;                                        -- hps_io_emac1_inst_TXD3
			hps_0_hps_io_hps_io_emac1_inst_RXD0        : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD0
			hps_0_hps_io_hps_io_emac1_inst_MDIO        : inout std_logic                     := 'X';             -- hps_io_emac1_inst_MDIO
			hps_0_hps_io_hps_io_emac1_inst_MDC         : out   std_logic;                                        -- hps_io_emac1_inst_MDC
			hps_0_hps_io_hps_io_emac1_inst_RX_CTL      : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CTL
			hps_0_hps_io_hps_io_emac1_inst_TX_CTL      : out   std_logic;                                        -- hps_io_emac1_inst_TX_CTL
			hps_0_hps_io_hps_io_emac1_inst_RX_CLK      : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CLK
			hps_0_hps_io_hps_io_emac1_inst_RXD1        : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD1
			hps_0_hps_io_hps_io_emac1_inst_RXD2        : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD2
			hps_0_hps_io_hps_io_emac1_inst_RXD3        : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD3
			hps_0_hps_io_hps_io_qspi_inst_IO0          : inout std_logic                     := 'X';             -- hps_io_qspi_inst_IO0
			hps_0_hps_io_hps_io_qspi_inst_IO1          : inout std_logic                     := 'X';             -- hps_io_qspi_inst_IO1
			hps_0_hps_io_hps_io_qspi_inst_IO2          : inout std_logic                     := 'X';             -- hps_io_qspi_inst_IO2
			hps_0_hps_io_hps_io_qspi_inst_IO3          : inout std_logic                     := 'X';             -- hps_io_qspi_inst_IO3
			hps_0_hps_io_hps_io_qspi_inst_SS0          : out   std_logic;                                        -- hps_io_qspi_inst_SS0
			hps_0_hps_io_hps_io_qspi_inst_CLK          : out   std_logic;                                        -- hps_io_qspi_inst_CLK
			hps_0_hps_io_hps_io_sdio_inst_CMD          : inout std_logic                     := 'X';             -- hps_io_sdio_inst_CMD
			hps_0_hps_io_hps_io_sdio_inst_D0           : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D0
			hps_0_hps_io_hps_io_sdio_inst_D1           : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D1
			hps_0_hps_io_hps_io_sdio_inst_CLK          : out   std_logic;                                        -- hps_io_sdio_inst_CLK
			hps_0_hps_io_hps_io_sdio_inst_D2           : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D2
			hps_0_hps_io_hps_io_sdio_inst_D3           : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D3
			hps_0_hps_io_hps_io_usb1_inst_D0           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D0
			hps_0_hps_io_hps_io_usb1_inst_D1           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D1
			hps_0_hps_io_hps_io_usb1_inst_D2           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D2
			hps_0_hps_io_hps_io_usb1_inst_D3           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D3
			hps_0_hps_io_hps_io_usb1_inst_D4           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D4
			hps_0_hps_io_hps_io_usb1_inst_D5           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D5
			hps_0_hps_io_hps_io_usb1_inst_D6           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D6
			hps_0_hps_io_hps_io_usb1_inst_D7           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D7
			hps_0_hps_io_hps_io_usb1_inst_CLK          : in    std_logic                     := 'X';             -- hps_io_usb1_inst_CLK
			hps_0_hps_io_hps_io_usb1_inst_STP          : out   std_logic;                                        -- hps_io_usb1_inst_STP
			hps_0_hps_io_hps_io_usb1_inst_DIR          : in    std_logic                     := 'X';             -- hps_io_usb1_inst_DIR
			hps_0_hps_io_hps_io_usb1_inst_NXT          : in    std_logic                     := 'X';             -- hps_io_usb1_inst_NXT
			hps_0_hps_io_hps_io_spim0_inst_CLK         : out   std_logic;                                        -- hps_io_spim0_inst_CLK
			hps_0_hps_io_hps_io_spim0_inst_MOSI        : out   std_logic;                                        -- hps_io_spim0_inst_MOSI
			hps_0_hps_io_hps_io_spim0_inst_MISO        : in    std_logic                     := 'X';             -- hps_io_spim0_inst_MISO
			hps_0_hps_io_hps_io_spim0_inst_SS0         : out   std_logic;                                        -- hps_io_spim0_inst_SS0
			hps_0_hps_io_hps_io_spim1_inst_CLK         : out   std_logic;                                        -- hps_io_spim1_inst_CLK
			hps_0_hps_io_hps_io_spim1_inst_MOSI        : out   std_logic;                                        -- hps_io_spim1_inst_MOSI
			hps_0_hps_io_hps_io_spim1_inst_MISO        : in    std_logic                     := 'X';             -- hps_io_spim1_inst_MISO
			hps_0_hps_io_hps_io_spim1_inst_SS0         : out   std_logic;                                        -- hps_io_spim1_inst_SS0
			hps_0_hps_io_hps_io_uart0_inst_RX          : in    std_logic                     := 'X';             -- hps_io_uart0_inst_RX
			hps_0_hps_io_hps_io_uart0_inst_TX          : out   std_logic;                                        -- hps_io_uart0_inst_TX
			hps_0_hps_io_hps_io_i2c0_inst_SDA          : inout std_logic                     := 'X';             -- hps_io_i2c0_inst_SDA
			hps_0_hps_io_hps_io_i2c0_inst_SCL          : inout std_logic                     := 'X';             -- hps_io_i2c0_inst_SCL
			hps_0_hps_io_hps_io_i2c1_inst_SDA          : inout std_logic                     := 'X';             -- hps_io_i2c1_inst_SDA
			hps_0_hps_io_hps_io_i2c1_inst_SCL          : inout std_logic                     := 'X';             -- hps_io_i2c1_inst_SCL
			hps_0_hps_io_hps_io_gpio_inst_GPIO09       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO09
			hps_0_hps_io_hps_io_gpio_inst_GPIO35       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO35
			hps_0_hps_io_hps_io_gpio_inst_GPIO37       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO37
			hps_0_hps_io_hps_io_gpio_inst_GPIO40       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO40
			hps_0_hps_io_hps_io_gpio_inst_GPIO41       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO41
			hps_0_hps_io_hps_io_gpio_inst_GPIO44       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO44
			hps_0_hps_io_hps_io_gpio_inst_GPIO48       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO48
			hps_0_hps_io_hps_io_gpio_inst_GPIO53       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO53
			hps_0_hps_io_hps_io_gpio_inst_GPIO54       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO54
			hps_0_hps_io_hps_io_gpio_inst_GPIO61       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO61
			memory_mem_a                               : out   std_logic_vector(14 downto 0);                    -- mem_a
			memory_mem_ba                              : out   std_logic_vector(2 downto 0);                     -- mem_ba
			memory_mem_ck                              : out   std_logic;                                        -- mem_ck
			memory_mem_ck_n                            : out   std_logic;                                        -- mem_ck_n
			memory_mem_cke                             : out   std_logic;                                        -- mem_cke
			memory_mem_cs_n                            : out   std_logic;                                        -- mem_cs_n
			memory_mem_ras_n                           : out   std_logic;                                        -- mem_ras_n
			memory_mem_cas_n                           : out   std_logic;                                        -- mem_cas_n
			memory_mem_we_n                            : out   std_logic;                                        -- mem_we_n
			memory_mem_reset_n                         : out   std_logic;                                        -- mem_reset_n
			memory_mem_dq                              : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
			memory_mem_dqs                             : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
			memory_mem_dqs_n                           : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
			memory_mem_odt                             : out   std_logic;                                        -- mem_odt
			memory_mem_dm                              : out   std_logic_vector(3 downto 0);                     -- mem_dm
			memory_oct_rzqin                           : in    std_logic                     := 'X';             -- oct_rzqin
			reset_reset_n                              : in    std_logic                     := 'X';             -- reset_n
			f2h_sdram0_data_address                    : in    std_logic_vector(25 downto 0) := (others => 'X'); -- address
			f2h_sdram0_data_read                       : in    std_logic                     := 'X';             -- read
			f2h_sdram0_data_readdata                   : out   std_logic_vector(63 downto 0);                    -- readdata
			f2h_sdram0_data_write                      : in    std_logic                     := 'X';             -- write
			f2h_sdram0_data_writedata                  : in    std_logic_vector(63 downto 0) := (others => 'X'); -- writedata
			f2h_sdram0_data_readdatavalid              : out   std_logic;                                        -- readdatavalid
			f2h_sdram0_data_waitrequest                : out   std_logic;                                        -- waitrequest
			f2h_sdram0_data_byteenable                 : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- byteenable
			f2h_sdram0_data_burstcount                 : in    std_logic_vector(0 downto 0)  := (others => 'X'); -- burstcount
			f2h_sdram0_cntl_read                       : in    std_logic                     := 'X';             -- read
			f2h_sdram0_cntl_readdata                   : out   std_logic_vector(63 downto 0);                    -- readdata
			f2h_sdram0_cntl_write                      : in    std_logic                     := 'X';             -- write
			f2h_sdram0_cntl_writedata                  : in    std_logic_vector(63 downto 0) := (others => 'X'); -- writedata
			f2h_sdram0_cntl_byteenable                 : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- byteenable
			slave_template_0_user_interface_dataout_0  : out   std_logic_vector(31 downto 0);                    -- dataout_0
			slave_template_0_user_interface_dataout_1  : out   std_logic_vector(31 downto 0);                    -- dataout_1
			slave_template_0_user_interface_dataout_2  : out   std_logic_vector(31 downto 0);                    -- dataout_2
			slave_template_0_user_interface_dataout_3  : out   std_logic_vector(31 downto 0);                    -- dataout_3
			slave_template_0_user_interface_dataout_4  : out   std_logic_vector(31 downto 0);                    -- dataout_4
			slave_template_0_user_interface_dataout_5  : out   std_logic_vector(31 downto 0);                    -- dataout_5
			slave_template_0_user_interface_dataout_6  : out   std_logic_vector(31 downto 0);                    -- dataout_6
			slave_template_0_user_interface_dataout_7  : out   std_logic_vector(31 downto 0);                    -- dataout_7
			slave_template_0_user_interface_dataout_8  : out   std_logic_vector(31 downto 0);                    -- dataout_8
			slave_template_0_user_interface_dataout_9  : out   std_logic_vector(31 downto 0);                    -- dataout_9
			slave_template_0_user_interface_dataout_10 : out   std_logic_vector(31 downto 0);                    -- dataout_10
			slave_template_0_user_interface_dataout_11 : out   std_logic_vector(31 downto 0);                    -- dataout_11
			slave_template_0_user_interface_dataout_12 : out   std_logic_vector(31 downto 0);                    -- dataout_12
			slave_template_0_user_interface_dataout_13 : out   std_logic_vector(31 downto 0);                    -- dataout_13
			slave_template_0_user_interface_dataout_14 : out   std_logic_vector(31 downto 0);                    -- dataout_14
			slave_template_0_user_interface_dataout_15 : out   std_logic_vector(31 downto 0);                    -- dataout_15
			slave_template_0_user_interface_datain_0   : in    std_logic_vector(31 downto 0) := (others => 'X'); -- datain_0
			slave_template_0_user_interface_datain_1   : in    std_logic_vector(31 downto 0) := (others => 'X'); -- datain_1
			slave_template_0_user_interface_datain_2   : in    std_logic_vector(31 downto 0) := (others => 'X'); -- datain_2
			slave_template_0_user_interface_datain_3   : in    std_logic_vector(31 downto 0) := (others => 'X'); -- datain_3
			slave_template_0_user_interface_datain_4   : in    std_logic_vector(31 downto 0) := (others => 'X'); -- datain_4
			slave_template_0_user_interface_datain_5   : in    std_logic_vector(31 downto 0) := (others => 'X'); -- datain_5
			slave_template_0_user_interface_datain_6   : in    std_logic_vector(31 downto 0) := (others => 'X'); -- datain_6
			slave_template_0_user_interface_datain_7   : in    std_logic_vector(31 downto 0) := (others => 'X'); -- datain_7
			slave_template_0_user_interface_datain_8   : in    std_logic_vector(31 downto 0) := (others => 'X'); -- datain_8
			slave_template_0_user_interface_datain_9   : in    std_logic_vector(31 downto 0) := (others => 'X'); -- datain_9
			slave_template_0_user_interface_datain_10  : in    std_logic_vector(31 downto 0) := (others => 'X'); -- datain_10
			slave_template_0_user_interface_datain_11  : in    std_logic_vector(31 downto 0) := (others => 'X'); -- datain_11
			slave_template_0_user_interface_datain_12  : in    std_logic_vector(31 downto 0) := (others => 'X'); -- datain_12
			slave_template_0_user_interface_datain_13  : in    std_logic_vector(31 downto 0) := (others => 'X'); -- datain_13
			slave_template_0_user_interface_datain_14  : in    std_logic_vector(31 downto 0) := (others => 'X'); -- datain_14
			slave_template_0_user_interface_datain_15  : in    std_logic_vector(31 downto 0) := (others => 'X')  -- datain_15
		);
	end component soc_system;

	u0 : component soc_system
		port map (
			button_pio_external_connection_export      => CONNECTED_TO_button_pio_external_connection_export,      --  button_pio_external_connection.export
			clk_clk                                    => CONNECTED_TO_clk_clk,                                    --                             clk.clk
			dipsw_pio_external_connection_export       => CONNECTED_TO_dipsw_pio_external_connection_export,       --   dipsw_pio_external_connection.export
			hps_0_f2h_cold_reset_req_reset_n           => CONNECTED_TO_hps_0_f2h_cold_reset_req_reset_n,           --        hps_0_f2h_cold_reset_req.reset_n
			hps_0_f2h_debug_reset_req_reset_n          => CONNECTED_TO_hps_0_f2h_debug_reset_req_reset_n,          --       hps_0_f2h_debug_reset_req.reset_n
			hps_0_f2h_stm_hw_events_stm_hwevents       => CONNECTED_TO_hps_0_f2h_stm_hw_events_stm_hwevents,       --         hps_0_f2h_stm_hw_events.stm_hwevents
			hps_0_f2h_warm_reset_req_reset_n           => CONNECTED_TO_hps_0_f2h_warm_reset_req_reset_n,           --        hps_0_f2h_warm_reset_req.reset_n
			hps_0_h2f_reset_reset_n                    => CONNECTED_TO_hps_0_h2f_reset_reset_n,                    --                 hps_0_h2f_reset.reset_n
			hps_0_hps_io_hps_io_emac1_inst_TX_CLK      => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_TX_CLK,      --                    hps_0_hps_io.hps_io_emac1_inst_TX_CLK
			hps_0_hps_io_hps_io_emac1_inst_TXD0        => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_TXD0,        --                                .hps_io_emac1_inst_TXD0
			hps_0_hps_io_hps_io_emac1_inst_TXD1        => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_TXD1,        --                                .hps_io_emac1_inst_TXD1
			hps_0_hps_io_hps_io_emac1_inst_TXD2        => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_TXD2,        --                                .hps_io_emac1_inst_TXD2
			hps_0_hps_io_hps_io_emac1_inst_TXD3        => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_TXD3,        --                                .hps_io_emac1_inst_TXD3
			hps_0_hps_io_hps_io_emac1_inst_RXD0        => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_RXD0,        --                                .hps_io_emac1_inst_RXD0
			hps_0_hps_io_hps_io_emac1_inst_MDIO        => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_MDIO,        --                                .hps_io_emac1_inst_MDIO
			hps_0_hps_io_hps_io_emac1_inst_MDC         => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_MDC,         --                                .hps_io_emac1_inst_MDC
			hps_0_hps_io_hps_io_emac1_inst_RX_CTL      => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_RX_CTL,      --                                .hps_io_emac1_inst_RX_CTL
			hps_0_hps_io_hps_io_emac1_inst_TX_CTL      => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_TX_CTL,      --                                .hps_io_emac1_inst_TX_CTL
			hps_0_hps_io_hps_io_emac1_inst_RX_CLK      => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_RX_CLK,      --                                .hps_io_emac1_inst_RX_CLK
			hps_0_hps_io_hps_io_emac1_inst_RXD1        => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_RXD1,        --                                .hps_io_emac1_inst_RXD1
			hps_0_hps_io_hps_io_emac1_inst_RXD2        => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_RXD2,        --                                .hps_io_emac1_inst_RXD2
			hps_0_hps_io_hps_io_emac1_inst_RXD3        => CONNECTED_TO_hps_0_hps_io_hps_io_emac1_inst_RXD3,        --                                .hps_io_emac1_inst_RXD3
			hps_0_hps_io_hps_io_qspi_inst_IO0          => CONNECTED_TO_hps_0_hps_io_hps_io_qspi_inst_IO0,          --                                .hps_io_qspi_inst_IO0
			hps_0_hps_io_hps_io_qspi_inst_IO1          => CONNECTED_TO_hps_0_hps_io_hps_io_qspi_inst_IO1,          --                                .hps_io_qspi_inst_IO1
			hps_0_hps_io_hps_io_qspi_inst_IO2          => CONNECTED_TO_hps_0_hps_io_hps_io_qspi_inst_IO2,          --                                .hps_io_qspi_inst_IO2
			hps_0_hps_io_hps_io_qspi_inst_IO3          => CONNECTED_TO_hps_0_hps_io_hps_io_qspi_inst_IO3,          --                                .hps_io_qspi_inst_IO3
			hps_0_hps_io_hps_io_qspi_inst_SS0          => CONNECTED_TO_hps_0_hps_io_hps_io_qspi_inst_SS0,          --                                .hps_io_qspi_inst_SS0
			hps_0_hps_io_hps_io_qspi_inst_CLK          => CONNECTED_TO_hps_0_hps_io_hps_io_qspi_inst_CLK,          --                                .hps_io_qspi_inst_CLK
			hps_0_hps_io_hps_io_sdio_inst_CMD          => CONNECTED_TO_hps_0_hps_io_hps_io_sdio_inst_CMD,          --                                .hps_io_sdio_inst_CMD
			hps_0_hps_io_hps_io_sdio_inst_D0           => CONNECTED_TO_hps_0_hps_io_hps_io_sdio_inst_D0,           --                                .hps_io_sdio_inst_D0
			hps_0_hps_io_hps_io_sdio_inst_D1           => CONNECTED_TO_hps_0_hps_io_hps_io_sdio_inst_D1,           --                                .hps_io_sdio_inst_D1
			hps_0_hps_io_hps_io_sdio_inst_CLK          => CONNECTED_TO_hps_0_hps_io_hps_io_sdio_inst_CLK,          --                                .hps_io_sdio_inst_CLK
			hps_0_hps_io_hps_io_sdio_inst_D2           => CONNECTED_TO_hps_0_hps_io_hps_io_sdio_inst_D2,           --                                .hps_io_sdio_inst_D2
			hps_0_hps_io_hps_io_sdio_inst_D3           => CONNECTED_TO_hps_0_hps_io_hps_io_sdio_inst_D3,           --                                .hps_io_sdio_inst_D3
			hps_0_hps_io_hps_io_usb1_inst_D0           => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D0,           --                                .hps_io_usb1_inst_D0
			hps_0_hps_io_hps_io_usb1_inst_D1           => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D1,           --                                .hps_io_usb1_inst_D1
			hps_0_hps_io_hps_io_usb1_inst_D2           => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D2,           --                                .hps_io_usb1_inst_D2
			hps_0_hps_io_hps_io_usb1_inst_D3           => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D3,           --                                .hps_io_usb1_inst_D3
			hps_0_hps_io_hps_io_usb1_inst_D4           => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D4,           --                                .hps_io_usb1_inst_D4
			hps_0_hps_io_hps_io_usb1_inst_D5           => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D5,           --                                .hps_io_usb1_inst_D5
			hps_0_hps_io_hps_io_usb1_inst_D6           => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D6,           --                                .hps_io_usb1_inst_D6
			hps_0_hps_io_hps_io_usb1_inst_D7           => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_D7,           --                                .hps_io_usb1_inst_D7
			hps_0_hps_io_hps_io_usb1_inst_CLK          => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_CLK,          --                                .hps_io_usb1_inst_CLK
			hps_0_hps_io_hps_io_usb1_inst_STP          => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_STP,          --                                .hps_io_usb1_inst_STP
			hps_0_hps_io_hps_io_usb1_inst_DIR          => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_DIR,          --                                .hps_io_usb1_inst_DIR
			hps_0_hps_io_hps_io_usb1_inst_NXT          => CONNECTED_TO_hps_0_hps_io_hps_io_usb1_inst_NXT,          --                                .hps_io_usb1_inst_NXT
			hps_0_hps_io_hps_io_spim0_inst_CLK         => CONNECTED_TO_hps_0_hps_io_hps_io_spim0_inst_CLK,         --                                .hps_io_spim0_inst_CLK
			hps_0_hps_io_hps_io_spim0_inst_MOSI        => CONNECTED_TO_hps_0_hps_io_hps_io_spim0_inst_MOSI,        --                                .hps_io_spim0_inst_MOSI
			hps_0_hps_io_hps_io_spim0_inst_MISO        => CONNECTED_TO_hps_0_hps_io_hps_io_spim0_inst_MISO,        --                                .hps_io_spim0_inst_MISO
			hps_0_hps_io_hps_io_spim0_inst_SS0         => CONNECTED_TO_hps_0_hps_io_hps_io_spim0_inst_SS0,         --                                .hps_io_spim0_inst_SS0
			hps_0_hps_io_hps_io_spim1_inst_CLK         => CONNECTED_TO_hps_0_hps_io_hps_io_spim1_inst_CLK,         --                                .hps_io_spim1_inst_CLK
			hps_0_hps_io_hps_io_spim1_inst_MOSI        => CONNECTED_TO_hps_0_hps_io_hps_io_spim1_inst_MOSI,        --                                .hps_io_spim1_inst_MOSI
			hps_0_hps_io_hps_io_spim1_inst_MISO        => CONNECTED_TO_hps_0_hps_io_hps_io_spim1_inst_MISO,        --                                .hps_io_spim1_inst_MISO
			hps_0_hps_io_hps_io_spim1_inst_SS0         => CONNECTED_TO_hps_0_hps_io_hps_io_spim1_inst_SS0,         --                                .hps_io_spim1_inst_SS0
			hps_0_hps_io_hps_io_uart0_inst_RX          => CONNECTED_TO_hps_0_hps_io_hps_io_uart0_inst_RX,          --                                .hps_io_uart0_inst_RX
			hps_0_hps_io_hps_io_uart0_inst_TX          => CONNECTED_TO_hps_0_hps_io_hps_io_uart0_inst_TX,          --                                .hps_io_uart0_inst_TX
			hps_0_hps_io_hps_io_i2c0_inst_SDA          => CONNECTED_TO_hps_0_hps_io_hps_io_i2c0_inst_SDA,          --                                .hps_io_i2c0_inst_SDA
			hps_0_hps_io_hps_io_i2c0_inst_SCL          => CONNECTED_TO_hps_0_hps_io_hps_io_i2c0_inst_SCL,          --                                .hps_io_i2c0_inst_SCL
			hps_0_hps_io_hps_io_i2c1_inst_SDA          => CONNECTED_TO_hps_0_hps_io_hps_io_i2c1_inst_SDA,          --                                .hps_io_i2c1_inst_SDA
			hps_0_hps_io_hps_io_i2c1_inst_SCL          => CONNECTED_TO_hps_0_hps_io_hps_io_i2c1_inst_SCL,          --                                .hps_io_i2c1_inst_SCL
			hps_0_hps_io_hps_io_gpio_inst_GPIO09       => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO09,       --                                .hps_io_gpio_inst_GPIO09
			hps_0_hps_io_hps_io_gpio_inst_GPIO35       => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO35,       --                                .hps_io_gpio_inst_GPIO35
			hps_0_hps_io_hps_io_gpio_inst_GPIO37       => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO37,       --                                .hps_io_gpio_inst_GPIO37
			hps_0_hps_io_hps_io_gpio_inst_GPIO40       => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO40,       --                                .hps_io_gpio_inst_GPIO40
			hps_0_hps_io_hps_io_gpio_inst_GPIO41       => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO41,       --                                .hps_io_gpio_inst_GPIO41
			hps_0_hps_io_hps_io_gpio_inst_GPIO44       => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO44,       --                                .hps_io_gpio_inst_GPIO44
			hps_0_hps_io_hps_io_gpio_inst_GPIO48       => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO48,       --                                .hps_io_gpio_inst_GPIO48
			hps_0_hps_io_hps_io_gpio_inst_GPIO53       => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO53,       --                                .hps_io_gpio_inst_GPIO53
			hps_0_hps_io_hps_io_gpio_inst_GPIO54       => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO54,       --                                .hps_io_gpio_inst_GPIO54
			hps_0_hps_io_hps_io_gpio_inst_GPIO61       => CONNECTED_TO_hps_0_hps_io_hps_io_gpio_inst_GPIO61,       --                                .hps_io_gpio_inst_GPIO61
			memory_mem_a                               => CONNECTED_TO_memory_mem_a,                               --                          memory.mem_a
			memory_mem_ba                              => CONNECTED_TO_memory_mem_ba,                              --                                .mem_ba
			memory_mem_ck                              => CONNECTED_TO_memory_mem_ck,                              --                                .mem_ck
			memory_mem_ck_n                            => CONNECTED_TO_memory_mem_ck_n,                            --                                .mem_ck_n
			memory_mem_cke                             => CONNECTED_TO_memory_mem_cke,                             --                                .mem_cke
			memory_mem_cs_n                            => CONNECTED_TO_memory_mem_cs_n,                            --                                .mem_cs_n
			memory_mem_ras_n                           => CONNECTED_TO_memory_mem_ras_n,                           --                                .mem_ras_n
			memory_mem_cas_n                           => CONNECTED_TO_memory_mem_cas_n,                           --                                .mem_cas_n
			memory_mem_we_n                            => CONNECTED_TO_memory_mem_we_n,                            --                                .mem_we_n
			memory_mem_reset_n                         => CONNECTED_TO_memory_mem_reset_n,                         --                                .mem_reset_n
			memory_mem_dq                              => CONNECTED_TO_memory_mem_dq,                              --                                .mem_dq
			memory_mem_dqs                             => CONNECTED_TO_memory_mem_dqs,                             --                                .mem_dqs
			memory_mem_dqs_n                           => CONNECTED_TO_memory_mem_dqs_n,                           --                                .mem_dqs_n
			memory_mem_odt                             => CONNECTED_TO_memory_mem_odt,                             --                                .mem_odt
			memory_mem_dm                              => CONNECTED_TO_memory_mem_dm,                              --                                .mem_dm
			memory_oct_rzqin                           => CONNECTED_TO_memory_oct_rzqin,                           --                                .oct_rzqin
			reset_reset_n                              => CONNECTED_TO_reset_reset_n,                              --                           reset.reset_n
			f2h_sdram0_data_address                    => CONNECTED_TO_f2h_sdram0_data_address,                    --                 f2h_sdram0_data.address
			f2h_sdram0_data_read                       => CONNECTED_TO_f2h_sdram0_data_read,                       --                                .read
			f2h_sdram0_data_readdata                   => CONNECTED_TO_f2h_sdram0_data_readdata,                   --                                .readdata
			f2h_sdram0_data_write                      => CONNECTED_TO_f2h_sdram0_data_write,                      --                                .write
			f2h_sdram0_data_writedata                  => CONNECTED_TO_f2h_sdram0_data_writedata,                  --                                .writedata
			f2h_sdram0_data_readdatavalid              => CONNECTED_TO_f2h_sdram0_data_readdatavalid,              --                                .readdatavalid
			f2h_sdram0_data_waitrequest                => CONNECTED_TO_f2h_sdram0_data_waitrequest,                --                                .waitrequest
			f2h_sdram0_data_byteenable                 => CONNECTED_TO_f2h_sdram0_data_byteenable,                 --                                .byteenable
			f2h_sdram0_data_burstcount                 => CONNECTED_TO_f2h_sdram0_data_burstcount,                 --                                .burstcount
			f2h_sdram0_cntl_read                       => CONNECTED_TO_f2h_sdram0_cntl_read,                       --                 f2h_sdram0_cntl.read
			f2h_sdram0_cntl_readdata                   => CONNECTED_TO_f2h_sdram0_cntl_readdata,                   --                                .readdata
			f2h_sdram0_cntl_write                      => CONNECTED_TO_f2h_sdram0_cntl_write,                      --                                .write
			f2h_sdram0_cntl_writedata                  => CONNECTED_TO_f2h_sdram0_cntl_writedata,                  --                                .writedata
			f2h_sdram0_cntl_byteenable                 => CONNECTED_TO_f2h_sdram0_cntl_byteenable,                 --                                .byteenable
			slave_template_0_user_interface_dataout_0  => CONNECTED_TO_slave_template_0_user_interface_dataout_0,  -- slave_template_0_user_interface.dataout_0
			slave_template_0_user_interface_dataout_1  => CONNECTED_TO_slave_template_0_user_interface_dataout_1,  --                                .dataout_1
			slave_template_0_user_interface_dataout_2  => CONNECTED_TO_slave_template_0_user_interface_dataout_2,  --                                .dataout_2
			slave_template_0_user_interface_dataout_3  => CONNECTED_TO_slave_template_0_user_interface_dataout_3,  --                                .dataout_3
			slave_template_0_user_interface_dataout_4  => CONNECTED_TO_slave_template_0_user_interface_dataout_4,  --                                .dataout_4
			slave_template_0_user_interface_dataout_5  => CONNECTED_TO_slave_template_0_user_interface_dataout_5,  --                                .dataout_5
			slave_template_0_user_interface_dataout_6  => CONNECTED_TO_slave_template_0_user_interface_dataout_6,  --                                .dataout_6
			slave_template_0_user_interface_dataout_7  => CONNECTED_TO_slave_template_0_user_interface_dataout_7,  --                                .dataout_7
			slave_template_0_user_interface_dataout_8  => CONNECTED_TO_slave_template_0_user_interface_dataout_8,  --                                .dataout_8
			slave_template_0_user_interface_dataout_9  => CONNECTED_TO_slave_template_0_user_interface_dataout_9,  --                                .dataout_9
			slave_template_0_user_interface_dataout_10 => CONNECTED_TO_slave_template_0_user_interface_dataout_10, --                                .dataout_10
			slave_template_0_user_interface_dataout_11 => CONNECTED_TO_slave_template_0_user_interface_dataout_11, --                                .dataout_11
			slave_template_0_user_interface_dataout_12 => CONNECTED_TO_slave_template_0_user_interface_dataout_12, --                                .dataout_12
			slave_template_0_user_interface_dataout_13 => CONNECTED_TO_slave_template_0_user_interface_dataout_13, --                                .dataout_13
			slave_template_0_user_interface_dataout_14 => CONNECTED_TO_slave_template_0_user_interface_dataout_14, --                                .dataout_14
			slave_template_0_user_interface_dataout_15 => CONNECTED_TO_slave_template_0_user_interface_dataout_15, --                                .dataout_15
			slave_template_0_user_interface_datain_0   => CONNECTED_TO_slave_template_0_user_interface_datain_0,   --                                .datain_0
			slave_template_0_user_interface_datain_1   => CONNECTED_TO_slave_template_0_user_interface_datain_1,   --                                .datain_1
			slave_template_0_user_interface_datain_2   => CONNECTED_TO_slave_template_0_user_interface_datain_2,   --                                .datain_2
			slave_template_0_user_interface_datain_3   => CONNECTED_TO_slave_template_0_user_interface_datain_3,   --                                .datain_3
			slave_template_0_user_interface_datain_4   => CONNECTED_TO_slave_template_0_user_interface_datain_4,   --                                .datain_4
			slave_template_0_user_interface_datain_5   => CONNECTED_TO_slave_template_0_user_interface_datain_5,   --                                .datain_5
			slave_template_0_user_interface_datain_6   => CONNECTED_TO_slave_template_0_user_interface_datain_6,   --                                .datain_6
			slave_template_0_user_interface_datain_7   => CONNECTED_TO_slave_template_0_user_interface_datain_7,   --                                .datain_7
			slave_template_0_user_interface_datain_8   => CONNECTED_TO_slave_template_0_user_interface_datain_8,   --                                .datain_8
			slave_template_0_user_interface_datain_9   => CONNECTED_TO_slave_template_0_user_interface_datain_9,   --                                .datain_9
			slave_template_0_user_interface_datain_10  => CONNECTED_TO_slave_template_0_user_interface_datain_10,  --                                .datain_10
			slave_template_0_user_interface_datain_11  => CONNECTED_TO_slave_template_0_user_interface_datain_11,  --                                .datain_11
			slave_template_0_user_interface_datain_12  => CONNECTED_TO_slave_template_0_user_interface_datain_12,  --                                .datain_12
			slave_template_0_user_interface_datain_13  => CONNECTED_TO_slave_template_0_user_interface_datain_13,  --                                .datain_13
			slave_template_0_user_interface_datain_14  => CONNECTED_TO_slave_template_0_user_interface_datain_14,  --                                .datain_14
			slave_template_0_user_interface_datain_15  => CONNECTED_TO_slave_template_0_user_interface_datain_15   --                                .datain_15
		);

