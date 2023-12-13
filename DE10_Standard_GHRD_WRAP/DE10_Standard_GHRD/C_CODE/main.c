#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <time.h>
#include <sys/mman.h>
#include <stdbool.h>
#include "hwlib.h"
#include "socal/socal.h"
#include "socal/hps.h"
#include "socal/alt_gpio.h"
#include "hps_0.h"
#include "slave_template_macros.h"


#define HW_H2F_BRIDGE_OFST		( 0xC0000000 )				// 0xC000_0000 - Heavyweight bus
#define HW_LW_H2F_BRIDGE_OFST	( ALT_LWFPGASLVS_OFST )		// 0xFF20_0000 - Lightweight bus
#define HW_REGS_BASE			( ALT_STM_OFST )			// 0xFC00_0000 - Peripherals Region
#define HW_REGS_SPAN			( 0x04000000 )
#define HW_REGS_MASK			( HW_REGS_SPAN - 1 )
#define WRITEENABLE				( 0x00000800 )

#define FI_FIFO_IN_ACLR(data)			alt_write_word(h2f_CAM_addr + DATA_OUT_0, data)
#define FI_FIFO_IN_WR_CLK(data)			alt_write_word(h2f_CAM_addr + DATA_OUT_1, data)
#define FI_FIFO_IN_RD_REQ(data)			alt_write_word(h2f_CAM_addr + DATA_OUT_2, data)
#define FI_FIFO_IN_WR_REQ(data)			alt_write_word(h2f_CAM_addr + DATA_OUT_3, data)
#define FI_FIFO_IN1_DIN(data)			alt_write_word(h2f_CAM_addr + DATA_OUT_4, data)
#define FI_FIFO_IN2_DIN(data)			alt_write_word(h2f_CAM_addr + DATA_OUT_5, data)
#define FI_FIFO_CLK_MUX_CTL(data)		alt_write_word(h2f_CAM_addr + DATA_OUT_6, data)
#define FI_NTT_RESET(data)				alt_write_word(h2f_CAM_addr + DATA_OUT_7, data)
#define FI_NTT_MODE(data)				alt_write_word(h2f_CAM_addr + DATA_OUT_8, data)
#define FI_NTT_START(data)				alt_write_word(h2f_CAM_addr + DATA_OUT_9, data)
#define FI_NTT_WE(data)					alt_write_word(h2f_CAM_addr + DATA_OUT_10, data)
#define FI_FIFO_IN_RD_CLK(data)			alt_write_word(h2f_CAM_addr + DATA_OUT_11, data)
#define FI_FIFO_OUT_WR_CLK(data)		alt_write_word(h2f_CAM_addr + DATA_OUT_12, data)
#define FI_FIFO_OUT_ACLR(data)			alt_write_word(h2f_CAM_addr + DATA_OUT_13, data)
#define FI_FIFO_OUT_RD_CLK(data)		alt_write_word(h2f_CAM_addr + DATA_OUT_14, data)
#define FI_FIFO_OUT_RD_REQ(data)		alt_write_word(h2f_CAM_addr + DATA_OUT_15, data)

#define FO_FIFO_IN_STATUS				alt_read_word(h2f_CAM_addr + DATA_IN_0) //RD_EMPTY1,WR_FULL1,WR_FULL2,RD_EMPTY2
#define FO_FIFO_IN1_WR_USED				alt_read_word(h2f_CAM_addr + DATA_IN_1)
#define TEST_FIFO_IN2_DATA_OUT			alt_read_word(h2f_CAM_addr + DATA_IN_2)
#define FO_FIFO_IN1_RD_USED				alt_read_word(h2f_CAM_addr + DATA_IN_3)
#define TEST_NTT_ADDR_INA				alt_read_word(h2f_CAM_addr + DATA_IN_4)
#define FO_FIFO_IN2_WR_USED				alt_read_word(h2f_CAM_addr + DATA_IN_5)
#define TEST_NTT_DATA_INA				alt_read_word(h2f_CAM_addr + DATA_IN_6)
#define FO_FIFO_IN2_RD_USED				alt_read_word(h2f_CAM_addr + DATA_IN_7)
#define TEST_NTT_DATA_OUT				alt_read_word(h2f_CAM_addr + DATA_IN_8)
// #define FO_NTT_DONE						alt_read_word(h2f_CAM_addr + DATA_IN_9)
#define FO_FIFO_OUT3_WR_FULL			alt_read_word(h2f_CAM_addr + DATA_IN_10)
#define FO_FIFO_OUT3_WR_USED			alt_read_word(h2f_CAM_addr + DATA_IN_11)
#define FO_FIFO_OUT3_RD_EMPTY			alt_read_word(h2f_CAM_addr + DATA_IN_12)
#define FO_FIFO_OUT3_RD_USED			alt_read_word(h2f_CAM_addr + DATA_IN_13)
#define FO_FIFO_OUT3_RD_DATA			alt_read_word(h2f_CAM_addr + DATA_IN_14)
#define FO_NTT_STATUS					alt_read_word(h2f_CAM_addr + DATA_IN_15)
//volatile unsigned long *h2f_CAM_search = NULL;
volatile unsigned long *h2f_CAM_setting = NULL;
volatile unsigned long *h2f_CAM_addr = NULL;
uint16_t din[] = {0x0, 0xfffe, 0x0, 0x2, 0xfffe, 0xfffe, 0x1, 0xffff, 0x1, 0xffff, 0x0, 0x2, 0x0, 0x0, 0x1, 0xffff, 0x1, 0x0, 0x1, 0x2, 0xffff,\
				0x0, 0x1, 0xfffe, 0xffff, 0x0, 0xfffe, 0x1, 0xffff, 0x1, 0x0, 0x0, 0xffff, 0x0, 0x0, 0x0, 0x1, 0x0, 0xffff, 0xfffe, 0x0, 0x2,\
				0x0, 0x1, 0xffff, 0x1, 0x0, 0x1, 0x0, 0xfffe, 0x0, 0x0, 0x0, 0xffff, 0x0, 0x0, 0xfffe, 0xffff, 0x0, 0xffff, 0xfffe, 0x1, 0x0,\
				0x0, 0xffff, 0xffff, 0x0, 0x0, 0x0, 0x0, 0xfffe, 0x0, 0x0, 0x0, 0xfffe, 0xffff, 0xfffe, 0x0, 0x0, 0x2, 0x0, 0x1, 0x0, 0x0, 0x1,\
				0x1, 0xffff, 0x1, 0x0, 0x0, 0x0, 0x0, 0xffff, 0xffff, 0x1, 0xffff, 0x0, 0xfffe, 0xffff, 0x1, 0x0, 0x2, 0x2, 0x1, 0xffff, 0xffff,\
				0x0, 0x0, 0x0, 0x1, 0xffff, 0x0, 0x0, 0x0, 0x1, 0xffff, 0xffff, 0x0, 0x2, 0x0, 0x0, 0xffff, 0x0, 0x0, 0x1, 0x0, 0x1, 0xffff, 0x0,\
				0x0, 0xffff, 0x0, 0x0, 0x1, 0xffff, 0x2, 0x0, 0x1, 0x0, 0x1, 0x2, 0x0, 0x0, 0xffff, 0x0, 0xffff, 0x0, 0x1, 0x0, 0xffff, 0x0, 0x1,\
				0xffff, 0x0, 0x0, 0x0, 0x2, 0x0, 0x0, 0x1, 0x0, 0x0, 0x0, 0x0, 0xffff, 0x1, 0x1, 0xffff, 0xffff, 0x0, 0x0, 0xfffe, 0x0, 0x1, 0x0,\
				0xffff, 0x0, 0x2, 0x1, 0x1, 0xfffe, 0x1, 0x1, 0xffff, 0x0, 0x1, 0x0, 0xffff, 0xfffe, 0x0, 0x0, 0xffff, 0x0, 0x1, 0x1, 0xffff, 0xffff,\
				0x1, 0x0, 0x1, 0x0, 0x0, 0x0, 0x2, 0x1, 0x0, 0x0, 0x0, 0xffff, 0xffff, 0xfffe, 0xffff, 0x2, 0x0, 0x1, 0x2, 0x1, 0x0, 0xffff, 0x0, 0x0,\
				0xffff, 0xffff, 0x1, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff, 0x0, 0xffff, 0x0, 0xffff, 0xffff, 0xffff, 0xfffe, 0x0, 0x0, 0x1,\
				0x2, 0x0, 0x0, 0x1, 0x0, 0x1, 0xffff, 0xffff, 0x1, 0xffff, 0x1, 0x0, 0x1, 0xfffe, 0x2, 0x0};

int main(int argc, char **argv) {
	void *virtual_base_lw;
	void *virtual_base_hw;
	int fd;

	// map the address space for the LED registers into user space so we can interact with them.
	// we'll actually map in the entire CSR span of the HPS since we want to access various registers within that span
	if ((fd = open("/dev/mem", (O_RDWR | O_SYNC))) == -1) {
		printf("ERROR: could not open \"/dev/mem\"...\n");
		return(1);
	}
	
	// Lightweight bus
	virtual_base_lw = mmap(NULL, HW_REGS_SPAN, (PROT_READ | PROT_WRITE), MAP_SHARED, fd, HW_REGS_BASE);
	if (virtual_base_lw == MAP_FAILED) {
		printf("ERROR: mmap() lightweight failed...\n");
		close(fd);
		return(1);
	}

	// Heavyweight bus
	virtual_base_hw = mmap(NULL, HW_REGS_SPAN, (PROT_READ | PROT_WRITE), MAP_SHARED, fd, HW_H2F_BRIDGE_OFST);
	if (virtual_base_hw == MAP_FAILED) {
		printf("ERROR: mmap() heavyweight failed...\n");
		close(fd);
		return(1);
	}

	/* CODE BEGINS HERE */
		// uint32_t fifo_in;
		// uint32_t i;
	
		// int enable;
		//int32_t rule_tcam;
		
		/*int search;*/

		//uint32_t ID;
		

		// Open bridge
		//h2f_CAM_setting = virtual_base_hw + (unsigned long)(CAM_SETTING_CONTROL_0_BASE);
		//h2f_CAM_search = virtual_base_hw + (unsigned long)(CAM_SEARCH_CONTROL_0_BASE);
		h2f_CAM_addr = virtual_base_lw + ((unsigned long)(HW_LW_H2F_BRIDGE_OFST + SLAVE_TEMPLATE_0_BASE) & (unsigned long)(HW_REGS_MASK));
		// Console Data input
		printf("=============================================\n");
		printf("=========        NTT_TEST          ==========\n");
		printf("=============================================\n");
		// FI_FIFO_IN_ACLR(0);
		// FI_FIFO_OUT_ACLR(0);
		printf("FF_IN_STATUS=0x%x\n",FO_FIFO_IN_STATUS);
		printf("FF1_WR_USED=0x%x\n",FO_FIFO_IN1_WR_USED);
		printf("FF1_RD_USED=0x%x\n",FO_FIFO_IN1_RD_USED);
		printf("FF2_WR_USED=0x%x\n",FO_FIFO_IN2_WR_USED);
		printf("FF2_RD_USED=0x%x\n",FO_FIFO_IN2_RD_USED);
		printf("FO_NTT_STATUS=%x\n",FO_NTT_STATUS);
		printf("FO_FIFO_OUT3_WR_FULL=%x\n",FO_FIFO_OUT3_WR_FULL);
		printf("FO_FIFO_OUT3_WR_USED=0x%x\n",FO_FIFO_OUT3_WR_USED);
		printf("FO_FIFO_OUT3_RD_EMPTY=%x\n",FO_FIFO_OUT3_RD_EMPTY);
		printf("FO_FIFO_OUT3_RD_USED=0x%x\n",FO_FIFO_OUT3_RD_USED);
		printf("DATA OUT =%x\n",FO_FIFO_OUT3_RD_DATA);
		printf("=================RESET SYSTEM================\n");
		FI_NTT_START(1);
		// FI_NTT_RESET(0);
		// FI_FIFO_IN_ACLR(0);
		// FI_FIFO_OUT_ACLR(0);
		FI_NTT_RESET(1);
		FI_FIFO_IN_ACLR(1);
		FI_FIFO_OUT_ACLR(1);
		sleep(1);
		FI_NTT_RESET(0);
		FI_FIFO_IN_ACLR(0);
		FI_FIFO_OUT_ACLR(0);
		printf("FF_IN_STATUS=0x%x\n",FO_FIFO_IN_STATUS);
		printf("FF1_WR_USED=0x%x\n",FO_FIFO_IN1_WR_USED);
		printf("FF1_RD_USED=0x%x\n",FO_FIFO_IN1_RD_USED);
		printf("FF2_WR_USED=0x%x\n",FO_FIFO_IN2_WR_USED);
		printf("FF2_RD_USED=0x%x\n",FO_FIFO_IN2_RD_USED);
		printf("FO_NTT_STATUS=%x\n",FO_NTT_STATUS);
		printf("FO_FIFO_OUT3_WR_FULL=%x\n",FO_FIFO_OUT3_WR_FULL);
		printf("FO_FIFO_OUT3_WR_USED=0x%x\n",FO_FIFO_OUT3_WR_USED);
		printf("FO_FIFO_OUT3_RD_EMPTY=%x\n",FO_FIFO_OUT3_RD_EMPTY);
		printf("FO_FIFO_OUT3_RD_USED=0x%x\n",FO_FIFO_OUT3_RD_USED);
		printf("DATA OUT =%x\n",FO_FIFO_OUT3_RD_DATA);
		sleep(10);
		printf("FF_IN_STATUS=0x%x\n",FO_FIFO_IN_STATUS);
		printf("FF1_WR_USED=0x%x\n",FO_FIFO_IN1_WR_USED);
		printf("FF1_RD_USED=0x%x\n",FO_FIFO_IN1_RD_USED);
		printf("FF2_WR_USED=0x%x\n",FO_FIFO_IN2_WR_USED);
		printf("FF2_RD_USED=0x%x\n",FO_FIFO_IN2_RD_USED);
		printf("FO_NTT_STATUS=%x\n",FO_NTT_STATUS);
		printf("FO_FIFO_OUT3_WR_FULL=%x\n",FO_FIFO_OUT3_WR_FULL);
		printf("FO_FIFO_OUT3_WR_USED=0x%x\n",FO_FIFO_OUT3_WR_USED);
		printf("FO_FIFO_OUT3_RD_EMPTY=%x\n",FO_FIFO_OUT3_RD_EMPTY);
		printf("FO_FIFO_OUT3_RD_USED=0x%x\n",FO_FIFO_OUT3_RD_USED);
		printf("DATA OUT =%x\n",FO_FIFO_OUT3_RD_DATA);
		// FI_FIFO_IN_RD_REQ(0);
		// FI_FIFO_IN_WR_REQ(0);
		// FI_FIFO_OUT_RD_REQ(0);
		// FI_FIFO_CLK_MUX_CTL(0);
		uint16_t i;
		// for (i=1; i<=3; i++)
		// {
		// 	FI_FIFO_IN_WR_CLK(0);
		// 	FI_FIFO_OUT_RD_CLK(0);
		// 	// sleep(1);
		// 	FI_FIFO_IN_WR_CLK(1);
		// 	FI_FIFO_OUT_RD_CLK(1);
		// 	// sleep(1);
		// }
		// FI_FIFO_IN_WR_CLK(0);
		// FI_FIFO_OUT_RD_CLK(0);
		FI_FIFO_IN_WR_REQ(1);
		sleep(1);
		uint16_t in_cnt;
		printf("=========Data in===========\n");
		for (in_cnt=0; in_cnt<128; in_cnt++)
		{
			uint16_t cnt1 = in_cnt*2;
			uint16_t cnt2 = in_cnt*2+1;
			int32_t data1 = cnt1<<16|din[cnt1];
			int32_t data2 = cnt2<<16|din[cnt2];
			// uint16_t t;
			FI_FIFO_IN_WR_CLK(0);
			// sleep(1);
			FI_FIFO_IN1_DIN(data1);
			// printf("0x%x \n",data1);
			FI_FIFO_IN2_DIN(data2);
			// printf("0x%x \n",data2);
			FI_FIFO_IN_WR_CLK(1);
			// for(t=0;t<100;t++);
			// if (in_cnt == 126)
			// {
			// printf("========Print Data 253&254=========\n");
			// printf("FF_IN_STATUS=0x%x\n",FO_FIFO_IN_STATUS);
			// printf("FF1_WR_USED=0x%x\n",FO_FIFO_IN1_WR_USED);
			// printf("FF1_RD_USED=0x%x\n",FO_FIFO_IN1_RD_USED);
			// printf("FF2_WR_USED=0x%x\n",FO_FIFO_IN2_WR_USED);
			// printf("FF2_RD_USED=0x%x\n",FO_FIFO_IN2_RD_USED);
			// printf("FO_NTT_STATUS=%x\n",FO_NTT_STATUS);
			// }
			// if (in_cnt == 127)
			// {
			printf("========Print Data %d&%d=========\n",cnt1,cnt2);
			printf("FF_IN_STATUS=0x%x\n",FO_FIFO_IN_STATUS);
			printf("FF1_WR_USED=0x%x\n",FO_FIFO_IN1_WR_USED);
			printf("FF1_RD_USED=0x%x\n",FO_FIFO_IN1_RD_USED);
			printf("FF2_WR_USED=0x%x\n",FO_FIFO_IN2_WR_USED);
			printf("FF2_RD_USED=0x%x\n",FO_FIFO_IN2_RD_USED);
			printf("FO_NTT_STATUS=%x\n",FO_NTT_STATUS);
			// }
			// sleep(1);
			// printf("FF1_WR_FULL=%x\n",FO_FIFO_IN1_WR_FULL);
			// printf("FF1_WR_USED=%x\n",FO_FIFO_IN1_WR_USED);
			// printf("FF1_RD_EMPTY=%x\n",FO_FIFO_IN1_RD_EMPTY);
			// printf("FF1_RD_USED=%x\n",FO_FIFO_IN1_RD_USED);
			// printf("FF2_WR_FULL=%x\n",FO_FIFO_IN2_WR_FULL);
			// printf("FF2_WR_USED=%x\n",FO_FIFO_IN2_WR_USED);
			// printf("FF2_RD_EMPTY=%x\n",FO_FIFO_IN2_RD_EMPTY);
			// printf("FF2_RD_USED=%x\n",FO_FIFO_IN2_RD_USED);
		}
		// sleep(1);
		FI_FIFO_IN_WR_CLK(0);
		FI_FIFO_IN_WR_REQ(0);
		for (i=1; i<=3; i++)
		{
			FI_FIFO_IN_WR_CLK(0);
			FI_FIFO_IN_WR_CLK(1);
		}
		FI_FIFO_IN_WR_CLK(0);
		printf("========END INPUT STAGE: WRITE to FIFO done=======\n");
		printf("FF_IN_STATUS=0x%x\n",FO_FIFO_IN_STATUS);
		printf("FF1_WR_USED=0x%x\n",FO_FIFO_IN1_WR_USED);
		printf("FF1_RD_USED=0x%x\n",FO_FIFO_IN1_RD_USED);
		printf("FF2_WR_USED=0x%x\n",FO_FIFO_IN2_WR_USED);
		printf("FF2_RD_USED=0x%x\n",FO_FIFO_IN2_RD_USED);
		printf("FO_NTT_STATUS=%x\n",FO_NTT_STATUS);
		printf("FO_FIFO_OUT3_WR_FULL=%x\n",FO_FIFO_OUT3_WR_FULL);
		printf("FO_FIFO_OUT3_WR_USED=0x%x\n",FO_FIFO_OUT3_WR_USED);
		printf("FO_FIFO_OUT3_RD_EMPTY=%x\n",FO_FIFO_OUT3_RD_EMPTY);
		printf("FO_FIFO_OUT3_RD_USED=0x%x\n",FO_FIFO_OUT3_RD_USED);
		printf("DATA OUT =%x\n",FO_FIFO_OUT3_RD_DATA);
		// printf("==========Reset NTT core==========\n");
		// FI_NTT_RESET(0);
		// sleep(1);
		// FI_NTT_RESET(1);
		// sleep(1);
		// FI_NTT_RESET(0);
		// sleep(1);
		// // printf("==========WE=0; START=1; MODE=0==========\n");
		// // FI_NTT_WE(0);
		// // FI_NTT_START(1);
		FI_NTT_MODE(0); //NTT
		// printf("FO_NTT_STATUS=%x\n",FO_NTT_STATUS);
		// printf("========WE=1=======\n");
		FI_NTT_WE(1);
		// printf("FO_NTT_STATUS=%x\n",FO_NTT_STATUS);
		FI_FIFO_IN_RD_REQ(1);
		// printf("================sleep 1s===============\n");
		while(FO_NTT_STATUS!=0x8)
		{
			printf("=============================================\n");
			printf("FO_NTT_STATUS=%x\n",FO_NTT_STATUS);
			printf("FF2_OUT=0x%x\n",TEST_FIFO_IN2_DATA_OUT);
			printf("ADDR_INA=0x%x; DATA_INA=0x%x\n",TEST_NTT_ADDR_INA,TEST_NTT_DATA_INA);
		}
		printf("FO_NTT_STATUS=%x\n",FO_NTT_STATUS);
		printf("FF2_OUT=0x%x\n",TEST_FIFO_IN2_DATA_OUT);
		printf("ADDR_INA=0x%x; DATA_INA=0x%x\n",TEST_NTT_ADDR_INA,TEST_NTT_DATA_INA);
		// // while ((FO_FIFO_IN1_RD_EMPTY==0)&&(FO_FIFO_IN2_RD_EMPTY==0))
		// // {
		// // 	printf("Waiting read process...");
		// // 	FI_FIFO_IN_WR_CLK(0);
		// // 	FI_FIFO_IN_WR_CLK(1);
		// // 	printf("NTT_IN_DONE=%x\n",FO_NTT_IN_DONE);
		// // }
		// printf("==========End Read to FPGA===========\n");
		// printf("FF_IN_STATUS=0x%x\n",FO_FIFO_IN_STATUS);
		// printf("FF1_WR_USED=0x%x\n",FO_FIFO_IN1_WR_USED);
		// printf("FF1_RD_USED=0x%x\n",FO_FIFO_IN1_RD_USED);
		// printf("FF2_WR_USED=0x%x\n",FO_FIFO_IN2_WR_USED);
		// printf("FF2_RD_USED=0x%x\n",FO_FIFO_IN2_RD_USED);
		// printf("FO_NTT_STATUS=%x\n",FO_NTT_STATUS);
		// printf("FO_NTT_STATUS=%x\n",FO_NTT_STATUS);
		// printf("FO_FIFO_OUT3_WR_FULL=%x\n",FO_FIFO_OUT3_WR_FULL);
		// printf("FO_FIFO_OUT3_WR_USED=0x%x\n",FO_FIFO_OUT3_WR_USED);
		// printf("FO_FIFO_OUT3_RD_EMPTY=%x\n",FO_FIFO_OUT3_RD_EMPTY);
		// printf("FO_FIFO_OUT3_RD_USED=0x%x\n",FO_FIFO_OUT3_RD_USED);
		// printf("DATA OUT %d=%x\n",i,FO_FIFO_OUT3_RD_DATA);
		printf("========WE=0=======\n");
		FI_FIFO_IN_RD_REQ(0);
		FI_NTT_WE(0);
		// printf("FF_IN_STATUS=0x%x\n",FO_FIFO_IN_STATUS);
		// printf("FF1_WR_USED=0x%x\n",FO_FIFO_IN1_WR_USED);
		// printf("FF1_RD_USED=0x%x\n",FO_FIFO_IN1_RD_USED);
		// printf("FF2_WR_USED=0x%x\n",FO_FIFO_IN2_WR_USED);
		// printf("FF2_RD_USED=0x%x\n",FO_FIFO_IN2_RD_USED);
		// printf("FO_NTT_STATUS=%x\n",FO_NTT_STATUS);
		// printf("FO_FIFO_OUT3_WR_FULL=%x\n",FO_FIFO_OUT3_WR_FULL);
		// printf("FO_FIFO_OUT3_WR_USED=0x%x\n",FO_FIFO_OUT3_WR_USED);
		// printf("FO_FIFO_OUT3_RD_EMPTY=%x\n",FO_FIFO_OUT3_RD_EMPTY);
		// printf("FO_FIFO_OUT3_RD_USED=0x%x\n",FO_FIFO_OUT3_RD_USED);
		// printf("DATA OUT %d=%x\n",i,FO_FIFO_OUT3_RD_DATA);
		// FI_FIFO_OUT_ACLR(0);
		// FI_FIFO_OUT_ACLR(1);
		// FI_FIFO_OUT_ACLR(0);
		// printf("=======Clear FIFO 3===============\n");
		// printf("FO_NTT_STATUS=%x\n",FO_NTT_STATUS);
		// printf("FO_FIFO_OUT3_WR_FULL=%x\n",FO_FIFO_OUT3_WR_FULL);
		// printf("FO_FIFO_OUT3_WR_USED=0x%x\n",FO_FIFO_OUT3_WR_USED);
		// printf("FO_FIFO_OUT3_RD_EMPTY=%x\n",FO_FIFO_OUT3_RD_EMPTY);
		// printf("FO_FIFO_OUT3_RD_USED=0x%x\n",FO_FIFO_OUT3_RD_USED);
		// printf("DATA OUT %d=%x\n",i,FO_FIFO_OUT3_RD_DATA);
		// 		for (i=1; i<=3; i++)
		// {
		// 	// FI_FIFO_OUT_WR_CLK(0);
		// 	FI_FIFO_OUT_RD_CLK(0);
		// 	// sleep(1);
		// 	// FI_FIFO_OUT_RD_CLK(1);
		// 	FI_FIFO_OUT_WR_CLK(1);
		// 	// sleep(1);
		// }
		// // FI_FIFO_OUT_WR_CLK(0);
		// FI_FIFO_OUT_RD_CLK(0);		
		// printf("=======FIFO 3 after clear===============\n");
		// printf("FO_NTT_STATUS=%x\n",FO_NTT_STATUS);
		// printf("FO_FIFO_OUT3_WR_FULL=%x\n",FO_FIFO_OUT3_WR_FULL);
		// printf("FO_FIFO_OUT3_WR_USED=0x%x\n",FO_FIFO_OUT3_WR_USED);
		// printf("FO_FIFO_OUT3_RD_EMPTY=%x\n",FO_FIFO_OUT3_RD_EMPTY);
		// printf("FO_FIFO_OUT3_RD_USED=0x%x\n",FO_FIFO_OUT3_RD_USED);
		// printf("DATA OUT %d=%x\n",i,FO_FIFO_OUT3_RD_DATA);
		// // printf("==============Sleep 1========\n");
		// // sleep(1);
		// FI_NTT_START(0);
		// // while (FO_NTT_INIT_DONE==0)
		// // {
		// // 	printf("Wating init done signal ...\n");
		// // }
		// // sleep(2);
		printf("========START=0=======\n");		
		FI_NTT_START(0);
		printf("==========Waiting NTT Cal Done===========\n");
		while (FO_NTT_STATUS!=0xf)
		{
			printf("FO_NTT_STATUS=%x\n",FO_NTT_STATUS);
			printf("NNT DATA OUT=0x%x\n",TEST_NTT_DATA_OUT);
		}
		
		// // FI_NTT_START(1);
		printf("FO_NTT_STATUS=%x\n",FO_NTT_STATUS);
		printf("FO_FIFO_OUT3_WR_FULL=%x\n",FO_FIFO_OUT3_WR_FULL);
		printf("FO_FIFO_OUT3_WR_USED=0x%x\n",FO_FIFO_OUT3_WR_USED);
		printf("FO_FIFO_OUT3_RD_EMPTY=%x\n",FO_FIFO_OUT3_RD_EMPTY);
		printf("FO_FIFO_OUT3_RD_USED=0x%x\n",FO_FIFO_OUT3_RD_USED);
		printf("FO_FIFO_OUT3_RD_DATA=%x\n",FO_FIFO_OUT3_RD_DATA);
		printf("========START=1=======\n");		
		for (i=1; i<=3; i++)
		{
			FI_FIFO_OUT_RD_CLK(0);
			// sleep(1);
			FI_FIFO_OUT_RD_CLK(1);
			// sleep(1);
		}
		FI_FIFO_OUT_RD_CLK(0);
		FI_FIFO_OUT_RD_REQ(1);
		printf("========Read data out=======\n");	
		for (i=1; i<=130; i++)
		{
			FI_FIFO_OUT_RD_CLK(1);
			printf("========Read block=======\n");
			printf("FO_FIFO_OUT3_WR_FULL=%x\n",FO_FIFO_OUT3_WR_FULL);
			printf("FO_FIFO_OUT3_WR_USED=0x%x\n",FO_FIFO_OUT3_WR_USED);
			printf("FO_FIFO_OUT3_RD_EMPTY=%x\n",FO_FIFO_OUT3_RD_EMPTY);
			printf("FO_FIFO_OUT3_RD_USED=0x%x\n",FO_FIFO_OUT3_RD_USED);
			printf("DATA OUT %d=%x\n",i,FO_FIFO_OUT3_RD_DATA);
			FI_FIFO_OUT_RD_CLK(0);
			// sleep(1);
		}
		for (i=1; i<=3; i++)
		{
			FI_FIFO_IN_WR_CLK(0);
			FI_FIFO_OUT_RD_CLK(0);
			// sleep(1);
			FI_FIFO_IN_WR_CLK(1);
			FI_FIFO_OUT_RD_CLK(1);
			// sleep(1);
		}
		FI_FIFO_IN_WR_CLK(0);
		FI_FIFO_OUT_RD_CLK(0);
		printf("===============print end status=========================\n");
		printf("FF_IN_STATUS=0x%x\n",FO_FIFO_IN_STATUS);
		printf("FF1_WR_USED=0x%x\n",FO_FIFO_IN1_WR_USED);
		printf("FF1_RD_USED=0x%x\n",FO_FIFO_IN1_RD_USED);
		printf("FF2_WR_USED=0x%x\n",FO_FIFO_IN2_WR_USED);
		printf("FF2_RD_USED=0x%x\n",FO_FIFO_IN2_RD_USED);
		printf("FO_NTT_STATUS=%x\n",FO_NTT_STATUS);
		printf("FO_FIFO_OUT3_WR_FULL=%x\n",FO_FIFO_OUT3_WR_FULL);
		printf("FO_FIFO_OUT3_WR_USED=0x%x\n",FO_FIFO_OUT3_WR_USED);
		printf("FO_FIFO_OUT3_RD_EMPTY=%x\n",FO_FIFO_OUT3_RD_EMPTY);
		printf("FO_FIFO_OUT3_RD_USED=0x%x\n",FO_FIFO_OUT3_RD_USED);
		printf("FO_FIFO_OUT3_RD_DATA=%x\n",FO_FIFO_OUT3_RD_DATA);
		printf("FF_IN_STATUS=0x%x\n",FO_FIFO_IN_STATUS);
		printf("FF1_WR_USED=0x%x\n",FO_FIFO_IN1_WR_USED);
		printf("FF1_RD_USED=0x%x\n",FO_FIFO_IN1_RD_USED);
		printf("FF2_WR_USED=0x%x\n",FO_FIFO_IN2_WR_USED);
		printf("FF2_RD_USED=0x%x\n",FO_FIFO_IN2_RD_USED);
		printf("FO_NTT_STATUS=%x\n",FO_NTT_STATUS);
		printf("FO_FIFO_OUT3_WR_FULL=%x\n",FO_FIFO_OUT3_WR_FULL);
		printf("FO_FIFO_OUT3_WR_USED=0x%x\n",FO_FIFO_OUT3_WR_USED);
		printf("FO_FIFO_OUT3_RD_EMPTY=%x\n",FO_FIFO_OUT3_RD_EMPTY);
		printf("FO_FIFO_OUT3_RD_USED=0x%x\n",FO_FIFO_OUT3_RD_USED);
		printf("DATA OUT =%x\n",FO_FIFO_OUT3_RD_DATA);
		printf("=================RESET SYSTEM================\n");
		FI_NTT_START(1);
		// FI_NTT_RESET(0);
		// FI_FIFO_IN_ACLR(0);
		// FI_FIFO_OUT_ACLR(0);
		FI_NTT_RESET(1);
		FI_FIFO_IN_ACLR(1);
		FI_FIFO_OUT_ACLR(1);
		sleep(1);
		FI_NTT_RESET(0);
		FI_FIFO_IN_ACLR(0);
		FI_FIFO_OUT_ACLR(0);
		printf("FF_IN_STATUS=0x%x\n",FO_FIFO_IN_STATUS);
		printf("FF1_WR_USED=0x%x\n",FO_FIFO_IN1_WR_USED);
		printf("FF1_RD_USED=0x%x\n",FO_FIFO_IN1_RD_USED);
		printf("FF2_WR_USED=0x%x\n",FO_FIFO_IN2_WR_USED);
		printf("FF2_RD_USED=0x%x\n",FO_FIFO_IN2_RD_USED);
		printf("FO_NTT_STATUS=%x\n",FO_NTT_STATUS);
		printf("FO_FIFO_OUT3_WR_FULL=%x\n",FO_FIFO_OUT3_WR_FULL);
		printf("FO_FIFO_OUT3_WR_USED=0x%x\n",FO_FIFO_OUT3_WR_USED);
		printf("FO_FIFO_OUT3_RD_EMPTY=%x\n",FO_FIFO_OUT3_RD_EMPTY);
		printf("FO_FIFO_OUT3_RD_USED=0x%x\n",FO_FIFO_OUT3_RD_USED);
		printf("DATA OUT =%x\n",FO_FIFO_OUT3_RD_DATA);
		sleep(10);
		printf("FF_IN_STATUS=0x%x\n",FO_FIFO_IN_STATUS);
		printf("FF1_WR_USED=0x%x\n",FO_FIFO_IN1_WR_USED);
		printf("FF1_RD_USED=0x%x\n",FO_FIFO_IN1_RD_USED);
		printf("FF2_WR_USED=0x%x\n",FO_FIFO_IN2_WR_USED);
		printf("FF2_RD_USED=0x%x\n",FO_FIFO_IN2_RD_USED);
		printf("FO_NTT_STATUS=%x\n",FO_NTT_STATUS);
		printf("FO_FIFO_OUT3_WR_FULL=%x\n",FO_FIFO_OUT3_WR_FULL);
		printf("FO_FIFO_OUT3_WR_USED=0x%x\n",FO_FIFO_OUT3_WR_USED);
		printf("FO_FIFO_OUT3_RD_EMPTY=%x\n",FO_FIFO_OUT3_RD_EMPTY);
		printf("FO_FIFO_OUT3_RD_USED=0x%x\n",FO_FIFO_OUT3_RD_USED);
		printf("DATA OUT =%x\n",FO_FIFO_OUT3_RD_DATA);















		// printf("==========Sleep 20s===========\n");
		// sleep(20);
		// printf("FO_NTT_INIT_DONE=%x\n",FO_NTT_INIT_DONE);
		// printf("FO_NTT_IN_DONE=%x\n",FO_NTT_IN_DONE);
		// printf("FO_NTT_DONE=%x\n",FO_NTT_DONE);
		// printf("FO_FIFO_OUT3_WR_FULL=%x\n",FO_FIFO_OUT3_WR_FULL);
		// printf("FO_FIFO_OUT3_WR_USED=0x%x\n",FO_FIFO_OUT3_WR_USED);
		// printf("FO_FIFO_OUT3_RD_EMPTY=%x\n",FO_FIFO_OUT3_RD_EMPTY);
		// printf("FO_FIFO_OUT3_RD_USED=0x%x\n",FO_FIFO_OUT3_RD_USED);
		// printf("FO_FIFO_OUT3_RD_DATA=%x\n",FO_FIFO_OUT3_RD_DATA);
		// printf("========START=0=======\n");		
		// FI_NTT_START(0);
		// printf("==========Sleep 20s===========\n");
		// sleep(20);
		// printf("FO_NTT_INIT_DONE=%x\n",FO_NTT_INIT_DONE);
		// printf("FO_NTT_IN_DONE=%x\n",FO_NTT_IN_DONE);
		// printf("FO_NTT_DONE=%x\n",FO_NTT_DONE);
		// printf("FO_FIFO_OUT3_WR_FULL=%x\n",FO_FIFO_OUT3_WR_FULL);
		// printf("FO_FIFO_OUT3_WR_USED=0x%x\n",FO_FIFO_OUT3_WR_USED);
		// printf("FO_FIFO_OUT3_RD_EMPTY=%x\n",FO_FIFO_OUT3_RD_EMPTY);
		// printf("FO_FIFO_OUT3_RD_USED=0x%x\n",FO_FIFO_OUT3_RD_USED);
		// printf("FO_FIFO_OUT3_RD_DATA=%x\n",FO_FIFO_OUT3_RD_DATA);
		
		// while(FO_NTT_DONE==0)
		// {
		// 	printf("NTT_IN_DONE=%x\n",FO_NTT_IN_DONE);
		// 	FI_FIFO_OUT_RD_CLK(1);
		// 	printf("Waiting read NTT done...");
		// 	printf("FFO3_WR_FULL=%x\n",FO_FIFO_OUT3_WR_FULL);
		// 	printf("FFO3_WR_USED=%x\n",FO_FIFO_OUT3_WR_USED);
		// 	printf("FFO3_RD_EMPTY=%x\n",FO_FIFO_OUT3_RD_EMPTY);
		// 	printf("FFO3_RD_USED=%x\n",FO_FIFO_OUT3_RD_USED);
		// 	printf("FFO3_DATA_OUT=%x\n",FO_FIFO_OUT3_RD_DATA);
		// 	FI_FIFO_OUT_RD_CLK(0);
		// }
		// FI_FIFO_OUT_RD_REQ(1);
		// while (FO_FIFO_OUT3_RD_EMPTY==0)
		// {
		// 	printf("Waiting read process...");
		// 	FI_FIFO_OUT_RD_CLK(0);
		// 	FI_FIFO_OUT_RD_CLK(1);
		// 	printf("FFO3_WR_FULL=%x\n",FO_FIFO_OUT3_WR_FULL);
		// 	printf("FFO3_WR_USED=%x\n",FO_FIFO_OUT3_WR_USED);
		// 	printf("FFO3_RD_EMPTY=%x\n",FO_FIFO_OUT3_RD_EMPTY);
		// 	printf("FFO3_RD_USED=%x\n",FO_FIFO_OUT3_RD_USED);
		// 	printf("FFO3_DATA_OUT=%x\n",FO_FIFO_OUT3_RD_DATA);
		// }
		// FI_FIFO_OUT_RD_CLK(0);

		
		// int function;
		// bool running=true;
		// uint32_t DATA_write=1;        
		// while(running)
		// {
		// 	printf("Input (1-13), 0 to exit: ");
		// 	scanf("%d", &function);
		// 	switch(function)
		// 	{
		// 		case 1:
		// 			printf("WR_CLK_0\n");
		// 			FI_FIFO_IN_WR_CLK(0);
		// 			break;
		// 		case 2:
		// 			printf("WR_CLK_1\n");
		// 			FI_FIFO_IN_WR_CLK(1);
		// 			break;
		// 		case 3:
		// 			printf("WR_REQ_0\n");
		// 			FI_FIFO_IN_WR_REQ(0);
		// 			break;
		// 		case 4:
		// 			printf("WR_REQ_1\n");
		// 			FI_FIFO_IN_WR_REQ(1);
		// 			break;
		// 		case 5:
		// 			printf("RD_CLK_0\n");
		// 			FI_FIFO_IN_RD_CLK(0);
		// 			break;
		// 		case 6:
		// 			printf("RD_CLK_1\n");
		// 			FI_FIFO_IN_RD_CLK(1);
		// 			break;
		// 		case 7:
		// 			printf("RD_REQ_0\n");
		// 			FI_FIFO_IN_RD_REQ(0);
		// 			break;
		// 		case 8:
		// 			printf("RD_REQ_1\n");
		// 			FI_FIFO_IN_RD_REQ(1);
		// 			break;
		// 		case 9:
		// 			printf("ACLR_0\n");
		// 			FI_FIFO_IN_ACLR(0);
		// 			break;
		// 		case 10:
		// 			printf("ACLR_1\n");
		// 			FI_FIFO_IN_ACLR(1);
		// 			break;
		// 		case 11:
		// 			printf("Write data %d\n",DATA_write);
		// 			FI_FIFO_IN1_DIN(DATA_write++);
		// 			break;
		// 		case 12:
		// 			printf("FF1_WR_FULL=%x\n",FO_FIFO_IN1_WR_FULL);
		// 			printf("FF1_WR_USED=%x\n",FO_FIFO_IN1_WR_USED);
		// 			printf("FF1_RD_EMPTY=%x\n",FO_FIFO_IN1_RD_EMPTY);
		// 			printf("FF1_RD_USED=%x\n",FO_FIFO_IN1_RD_USED);
		// 			printf("FF2_WR_FULL=%x\n",FO_FIFO_IN2_WR_FULL);
		// 			printf("FF2_WR_USED=%x\n",FO_FIFO_IN2_WR_USED);
		// 			printf("FF2_RD_EMPTY=%x\n",FO_FIFO_IN2_RD_EMPTY);
		// 			printf("FF2_RD_USED=%x\n",FO_FIFO_IN2_RD_USED);
		// 			break;
		// 		case 13:
		// 			printf("FF3_WR_FULL=%x\n",FO_FIFO_OUT3_WR_FULL);
		// 			printf("FF3_WR_USED=%x\n",FO_FIFO_OUT3_WR_USED);
		// 			printf("FF3_RD_DATA=%d\n",FO_FIFO_OUT3_RD_DATA);
		// 			printf("FF3_RD_EMPTY=%x\n",FO_FIFO_OUT3_RD_EMPTY);
		// 			printf("FF3_RD_USED=%x\n",FO_FIFO_OUT3_RD_USED);
		// 			break;				
		// 		case 0:
		// 			printf("Exit program\n");
		// 			running=false;
		// 			break;
		// 		default:
		// 			printf("Wrong input\n");
		// 		}

		// }
	//* END OF CODE */
	
	if (munmap(virtual_base_lw, HW_REGS_SPAN) != 0) {
		printf("ERROR: munmap() failed...\n");
		close(fd);
		return(1);
	}

	if (munmap(virtual_base_hw, HW_REGS_SPAN) != 0) {
		printf("ERROR: munmap() failed...\n");
		close(fd);
		return(1);
	}

	printf("END OF CODE! SUCCESSFULLY EXECUTING!\n");
	close(fd);
	return 0;
}
