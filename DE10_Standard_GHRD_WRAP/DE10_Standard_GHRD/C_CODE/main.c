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
		uint32_t fifo_in;
		uint32_t i;
	
		int enable;
		//int32_t rule_tcam;
		
		/*int search;*/

		//uint32_t ID;
		

		// Open bridge
		//h2f_CAM_setting = virtual_base_hw + (unsigned long)(CAM_SETTING_CONTROL_0_BASE);
		//h2f_CAM_search = virtual_base_hw + (unsigned long)(CAM_SEARCH_CONTROL_0_BASE);
		h2f_CAM_addr = virtual_base_lw + ((unsigned long)(HW_LW_H2F_BRIDGE_OFST + SLAVE_TEMPLATE_0_BASE) & (unsigned long)(HW_REGS_MASK));
		
		// Console Data input
		printf("=============================================\n");
		printf("========                           ==========\n");
		printf("========   CAM's Comtroller Test   ==========\n");
		printf("========       - Segmentation      ==========\n");
		printf("========       - Comparation       ==========\n");
		printf("========                           ==========\n");
		printf("=============================================\n");
		alt_write_word(h2f_CAM_addr +	DATA_OUT_1, 1);
		alt_write_word(h2f_CAM_addr +	DATA_OUT_2, 1);
		alt_write_word(h2f_CAM_addr +	DATA_OUT_0, 0);
		usleep(10);
		alt_write_word(h2f_CAM_addr +	DATA_OUT_1, 0);
		alt_write_word(h2f_CAM_addr +	DATA_OUT_2, 0);		
		alt_write_word(h2f_CAM_addr +	DATA_OUT_0, 1);
		
		printf("FIFO_DATA_OUT = %x \n",alt_read_word(h2f_CAM_addr + DATA_IN_0));
		//usleep(100);
		//alt_write_word(h2f_CAM_addr +	DATA_OUT_0, 0);
		//usleep(100);
		enable = alt_read_word(h2f_CAM_addr + DATA_IN_2);
		while(1){
			printf("FIFO_DATA_OUT = %x \n",alt_read_word(h2f_CAM_addr + DATA_IN_0));
			i++;
			if (i==1000){break;} 
		}
		//alt_write_word(h2f_CAM_addr +	DATA_OUT_0, 0);
		while(1){
			if(enable == 1){
				printf("FIFO_DATA_OUT = %x \n",alt_read_word(h2f_CAM_addr + DATA_IN_0));
			}
			else {
				break;
			}
		}
		printf("FIFO_DATA_OUT = %x \n",alt_read_word(h2f_CAM_addr + DATA_IN_0));
		//sleep(100);
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
