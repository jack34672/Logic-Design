`include "global.v"
module keyboard(
	input CLK,	//board clock
   input PS2_CLK,	//keyboard clock and data signals
   input PS2_DATA,
//	output reg scan_err,			//These can be used if the Keyboard module is used within a another module
//	output reg [10:0] scan_code,
//	output reg [3:0]COUNT,
//	output reg TRIG_ARR,
//	output reg [7:0]CODEWORD,
   output reg [7:0] LED,	//8 LEDs
   output reg [3:0]NUM,
   output reg [3:0]ASM
   );

//	wire [7:0] ARROW_UP = 8'h75;	//codes for arrows
//	wire [7:0] ARROW_DOWN = 8'h72;
	wire [7:0]ZERO = 8'h45;
	wire [7:0]ONE = 8'h16;
	wire [7:0]TWO = 8'h1E;
	wire [7:0]THREE = 8'h26;
	wire [7:0]FOUR = 8'h25;
	wire [7:0]FIVE = 8'h2E;
	wire [7:0]SIX = 8'h36;
	wire [7:0]SEVEN = 8'h3D;
	wire [7:0]EIGHT = 8'h3E;
	wire [7:0]NINE = 8'h46;
	wire [7:0]A = 8'h1C;
	wire [7:0]S = 8'h1B;
	wire [7:0]M = 8'h3A;
	wire [7:0]ENTER = 8'h5A;
	
	`define KEY_ZERO  8'h45;
    `define KEY_ONE  8'h16;
    `define KEY_TWO  8'h1E;
    `define KEY_THREE  8'h26;
    `define KEY_FOUR  8'h25;
    `define KEY_FIVE  8'h2E;
    `define KEY_SIX  8'h36;
    `define KEY_SEVEN  8'h3D;
    `define KEY_EIGHT  8'h3E;
    `define KEY_NINE  8'h46;
	//wire [7:0] ARROW_LEFT = 8'h6B;
	//wire [7:0] ARROW_RIGHT = 8'h74;
	//wire [7:0] EXTENDED = 8'hE0;	//codes 
	//wire [7:0] RELEASED = 8'hF0;

	reg read;				//this is 1 if still waits to receive more bits 
	reg [11:0] count_reading;		//this is used to detect how much time passed since it received the previous codeword
	reg PREVIOUS_STATE;			//used to check the previous state of the keyboard clock signal to know if it changed
	reg scan_err;				//this becomes one if an error was received somewhere in the packet
	reg [10:0] scan_code;			//this stores 11 received bits
	reg [7:0] CODEWORD;			//this stores only the DATA codeword
	reg TRIG_ARR;				//this is triggered when full 11 bits are received
	reg [3:0]COUNT;				//tells how many bits were received until now (from 0 to 11)
	reg TRIGGER = 0;			//This acts as a 250 times slower than the board clock. 
	reg [7:0]DOWNCOUNTER = 0;		//This is used together with TRIGGER - look the code

	//Set initial values
	initial begin
		PREVIOUS_STATE = 1;		
		scan_err = 0;		
		scan_code = 0;
		COUNT = 0;			
		CODEWORD = 0;
		LED = 0;
		read = 0;
		count_reading = 0;
		NUM = 4'd15;
		ASM = 4'd3;
	end

	always @(posedge CLK) begin				//This reduces the frequency 250 times
		if (DOWNCOUNTER < 249) begin			//and uses variable TRIGGER as the new board clock 
			DOWNCOUNTER <= DOWNCOUNTER + 1;
			TRIGGER <= 0;
		end
		else begin
			DOWNCOUNTER <= 0;
			TRIGGER <= 1;
		end
	end
	
	always @(posedge CLK) begin	
		if (TRIGGER) begin
			if (read)				//if it still waits to read full packet of 11 bits, then (read == 1)
				count_reading <= count_reading + 1;	//and it counts up this variable
			else 						//and later if check to see how big this value is.
				count_reading <= 0;			//if it is too big, then it resets the received data
		end
	end


	always @(posedge CLK) begin		
	if (TRIGGER) begin						//If the down counter (CLK/250) is ready
		if (PS2_CLK != PREVIOUS_STATE) begin			//if the state of Clock pin changed from previous state
			if (!PS2_CLK) begin				//and if the keyboard clock is at falling edge
				read <= 1;				//mark down that it is still reading for the next bit
				scan_err <= 0;				//no errors
				scan_code[10:0] <= {PS2_DATA, scan_code[10:1]};	//add up the data received by shifting bits and adding one new bit
				COUNT <= COUNT + 1;			//
			end
		end
		else if (COUNT == 11) begin				//if it already received 11 bits
			COUNT <= 0;
			read <= 0;					//mark down that reading stopped
			TRIG_ARR <= 1;					//trigger out that the full pack of 11bits was received
			//calculate scan_err using parity bit
			if (!scan_code[10] || scan_code[0] || !(scan_code[1]^scan_code[2]^scan_code[3]^scan_code[4]
				^scan_code[5]^scan_code[6]^scan_code[7]^scan_code[8]
				^scan_code[9]))
				scan_err <= 1;
			else 
				scan_err <= 0;
		end	
		else  begin						//if it yet not received full pack of 11 bits
			TRIG_ARR <= 0;					//tell that the packet of 11bits was not received yet
			if (COUNT < 11 && count_reading >= 4000) begin	//and if after a certain time no more bits were received, then
				COUNT <= 0;				//reset the number of bits received
				read <= 0;				//and wait for the next packet
			end
		end
	PREVIOUS_STATE <= PS2_CLK;					//mark down the previous state of the keyboard clock
	end
	end


	always @(posedge CLK) begin
		if (TRIGGER) begin					//if the 250 times slower than board clock triggers
			if (TRIG_ARR) begin				//and if a full packet of 11 bits was received
				if (scan_err) begin			//BUT if the packet was NOT OK
					CODEWORD <= 8'd0;		//then reset the codeword register
				end
				else begin
					CODEWORD <= scan_code[8:1];	//else drop down the unnecessary  bits and transport the 7 DATA bits to CODEWORD reg
				end				//notice, that the codeword is also reversed! This is because the first bit to received
			end					//is supposed to be the last bit in the codeword??
			else CODEWORD <= 8'd0;				//not a full packet received, thus reset codeword
		end
		else CODEWORD <= 8'd0;					//no clock trigger, no data??
	end
	
	always @(posedge CLK) begin
//	if (TRIGGER) begin
//		if (TRIG_ARR) begin
//		LED<=scan_code[8:1];			//You can put the code on the LEDs if you want to, that?�s up to you 
     if (CODEWORD == ONE) NUM <= 4'd1;
	    else if (CODEWORD == TWO) NUM <= 4'd2;
	    else if (CODEWORD == THREE) NUM <= 4'd3;
	    else if (CODEWORD == FOUR) NUM <= 4'd4;
	    else if (CODEWORD == FIVE) NUM <= 4'd5;
	    else if (CODEWORD == SIX) NUM <= 4'd6;
	    else if (CODEWORD == SEVEN) NUM <= 4'd7;
	    else if (CODEWORD == EIGHT) NUM <= 4'd8;
	    else if (CODEWORD == NINE) NUM <= 4'd9;
	    else if (CODEWORD == ZERO) NUM <= 4'd0;
	    else if (CODEWORD == A) ASM <= 4'd0;
	    else if (CODEWORD == S) ASM <= 4'd1;
	    else if (CODEWORD == M) ASM <= 4'd2;
	    else if (CODEWORD == ENTER) begin ASM <= 4'd3; NUM <= 4'd15; end

	       
	    


			//if (CODEWORD == EXTENDED)			//For example you can check here if specific codewords were received
			//if (CODEWORD == RELEASED)
		//end
//	end
	end

endmodule



//This code didn?�t work very well, but it was the first implementation of the module?? Maybe you can learn something from it
/*
	always @(negedge PS2_CLK) begin
		read <= 1;
		scan_err <= 0;
		scan_code[10:0] <= {PS2_DATA, scan_code[10:1]};
		if (COUNT < 11)
			COUNT <= COUNT + 1;
		else if (COUNT == 11) begin
			COUNT <= 0;
			read <= 0;
			//calculate scan_err
			if (!scan_code[10] || scan_code[0] || !(scan_code[1]^scan_code[2]^scan_code[3]^scan_code[4]
				^scan_code[5]^scan_code[6]^scan_code[7]^scan_code[8]
				^scan_code[9]))
				scan_err <= 1;
			else 
				scan_err <= 0;
		end 
		else begin
	
			if (COUNT < 11 && count_reading >= 1000000) begin
				COUNT <= 0;
				read <= 0;
			end
		end

	end

	always@(posedge CLK) begin
		if (COUNT != PREVIOUS_STATE) begin
			if (COUNT == 11) begin
				TRIG_ARR <= 1;
			end
			else begin
				TRIG_ARR <= 0;
			end
		end
		PREVIOUS_STATE <= COUNT;
	end
*/