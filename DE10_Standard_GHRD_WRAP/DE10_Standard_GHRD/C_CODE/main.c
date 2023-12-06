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
#define FI_FIFO_IN_MUX_RD_CLK(data)		alt_write_word(h2f_CAM_addr + DATA_OUT_6, data)
#define FI_FIFO_OUT_MUX_WR_CLK(data)	alt_write_word(h2f_CAM_addr + DATA_OUT_7, data)
#define FI_NTT_MODE(data)				alt_write_word(h2f_CAM_addr + DATA_OUT_8, data)
#define FI_NTT_START(data)				alt_write_word(h2f_CAM_addr + DATA_OUT_9, data)
#define FI_NTT_WE(data)					alt_write_word(h2f_CAM_addr + DATA_OUT_10, data)
#define FI_FIFO_IN_RD_CLK(data)			alt_write_word(h2f_CAM_addr + DATA_OUT_11, data)
#define FI_FIFO_OUT_WR_CLK(data)		alt_write_word(h2f_CAM_addr + DATA_OUT_12, data)
#define FI_FIFO_OUT_ACLR(data)			alt_write_word(h2f_CAM_addr + DATA_OUT_13, data)
#define FI_FIFO_OUT_RD_CLK(data)		alt_write_word(h2f_CAM_addr + DATA_OUT_14, data)
#define FI_FIFO_OUT_RD_REQ(data)		alt_write_word(h2f_CAM_addr + DATA_OUT_15, data)

#define FO_FIFO_IN1_WR_FULL				alt_read_word(h2f_CAM_addr + DATA_IN_0)
#define FO_FIFO_IN1_WR_USED				alt_read_word(h2f_CAM_addr + DATA_IN_1)
#define FO_FIFO_IN1_RD_EMPTY			alt_read_word(h2f_CAM_addr + DATA_IN_2)
#define FO_FIFO_IN1_RD_USED				alt_read_word(h2f_CAM_addr + DATA_IN_3)
#define FO_FIFO_IN2_WR_FULL				alt_read_word(h2f_CAM_addr + DATA_IN_4)
#define FO_FIFO_IN2_WR_USED				alt_read_word(h2f_CAM_addr + DATA_IN_5)
#define FO_FIFO_IN2_RD_EMPTY			alt_read_word(h2f_CAM_addr + DATA_IN_6)
#define FO_FIFO_IN2_RD_USED				alt_read_word(h2f_CAM_addr + DATA_IN_7)
#define FO_NTT_IN_DONE					alt_read_word(h2f_CAM_addr + DATA_IN_8)
#define FO_NTT_DONE						alt_read_word(h2f_CAM_addr + DATA_IN_9)
#define FO_FIFO_OUT3_WR_FULL			alt_read_word(h2f_CAM_addr + DATA_IN_10)
#define FO_FIFO_OUT3_WR_USED			alt_read_word(h2f_CAM_addr + DATA_IN_11)
#define FO_FIFO_OUT3_RD_EMPTY			alt_read_word(h2f_CAM_addr + DATA_IN_12)
#define FO_FIFO_OUT3_RD_USED			alt_read_word(h2f_CAM_addr + DATA_IN_13)
#define FO_FIFO_OUT3_RD_DATA			alt_read_word(h2f_CAM_addr + DATA_IN_14)
//volatile unsigned long *h2f_CAM_search = NULL;
volatile unsigned long *h2f_CAM_setting = NULL;
volatile unsigned long *h2f_CAM_addr = NULL;

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
		// Console Data input
		printf("=============================================\n");
		printf("=========        NTT_TEST          ==========\n");
		printf("=============================================\n");
		FI_FIFO_IN_ACLR(0);
		FI_FIFO_OUT_ACLR(0);
		FI_FIFO_IN_RD_REQ(0);
		FI_FIFO_IN_WR_REQ(0);
		FI_FIFO_OUT_RD_REQ(0);
		FI_FIFO_IN_MUX_RD_CLK(0);
		FI_FIFO_OUT_MUX_WR_CLK(0);
		for (uint8_t i=1; i<=10; i++)
		{
			FI_FIFO_IN_WR_CLK(0);
			FI_FIFO_OUT_RD_CLK(0);
			sleep(1);
			FI_FIFO_IN_WR_CLK(1);
			FI_FIFO_OUT_RD_CLK(1);
			sleep(1);
		}
		// FI_FIFO_IN_WR_CLK(0);
		FI_FIFO_OUT_RD_CLK(0);
		FI_FIFO_IN_WR_REQ(1);
		sleep(1);
		for (uint16_t in_cnt=0; in_cnt<128; in_cnt++)
		{
			uint16t_t cnt1 = in_cnt*2;
			uint16t_t cnt2 = in_cnt*2+1;
			FI_FIFO_IN_WR_CLK(0);
			FI_FIFO_IN1_DIN(cnt1<<16|din[cnt1]);
			FI_FIFO_IN2_DIN(cnt2<<16|din[cnt2]);
			FI_FIFO_IN_WR_CLK(1);
		}
		sleep(1);
		FI_FIFO_IN_WR_CLK(0);
		FI_FIFO_IN_WR_REQ(0);
		for (uint8_t i=1; i<=5; i++)
		{
			FI_FIFO_IN_WR_CLK(0);
			FI_FIFO_IN_WR_CLK(1);
		}

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
		// 			printf("RD_CLK_0\n");
		// 			WRITE_RD_CLK(0);
		// 			break;
		// 		case 2:
		// 			printf("RD_CLK_1\n");
		// 			WRITE_RD_CLK(1);
		// 			break;
		// 		case 3:
		// 			printf("WR_CLK_0\n");
		// 			WRITE_WR_CLK(0);
		// 			break;
		// 		case 4:
		// 			printf("WR_CLK_1\n");
		// 			WRITE_WR_CLK(1);
		// 			break;
		// 		case 5:
		// 			printf("RD_REQ_0\n");
		// 			WRITE_RD_REQ(0);
		// 			break;
		// 		case 6:
		// 			printf("RD_REQ_1\n");
		// 			WRITE_RD_REQ(1);
		// 			break;
		// 		case 7:
		// 			printf("WR_REQ_0\n");
		// 			WRITE_WR_REQ(0);
		// 			break;
		// 		case 8:
		// 			printf("WR_REQ_1\n");
		// 			WRITE_WR_REQ(1);
		// 			break;
		// 		case 9:
		// 			printf("ACLR_0\n");
		// 			WRITE_ACLR(0);
		// 			break;
		// 		case 10:
		// 			printf("ACLR_1\n");
		// 			WRITE_ACLR(1);
		// 			break;
		// 		case 11:
		// 			printf("Write data %d\n",DATA_write);
		// 			WRITE_WR_DAT(DATA_write++);
		// 			break;
		// 		case 12:
		// 			printf("WR_FULL=%x\n",READ_WR_FULL);
		// 			printf("WR_USED=%x\n",READ_WR_USED);
		// 			break;				
		// 		case 13:
		// 			printf("RD_DAT=%d\n",READ_RD_DAT);
		// 			printf("RD_EMPTY=%x\n",READ_RD_EMPTY);
		// 			printf("RD_USED=%x\n",READ_RD_USED);
		// 			break;
		// 		case 0:
		// 			printf("Exit program\n");
		// 			running=false;
		// 			break;
		// 		default:
		// 			printf("Wrong input\n");
		// 		}
		}
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
