module FIFO_TB ();
    parameter ADD_WIDTH = 5;
    parameter DATA_WIDTH = 8;

    reg clk_read;
    reg clk_write;
    reg[ DATA_WIDTH - 1: 0 ] data_in;
    reg Wr_enable;
    reg Read_enable;
    reg a_Reset;
    wire[ DATA_WIDTH - 1: 0 ] data_out;
    integer i;

    FIFO DUT(
    .clk_read(clk_read),
    .clk_write(clk_write),
    .data_in(data_in),
    .Wr_enable(Wr_enable),
    .Read_enable(Read_enable),
    .a_Reset(a_Reset),
    .data_out(data_out)
    );

   always #50 clk_write = ~clk_write;
   always #100 clk_read = ~clk_read;

    initial begin
        clk_read= 1;
        clk_write= 1;
        Wr_enable=0;
        Read_enable=0;
        a_Reset=1;
        data_in=0;
        
        // Writing in two words Then reading once
        #100
        a_Reset = 0;
        data_in = 19;
	Wr_enable = 1;

        #100
        data_in = 20;
        #50

        Wr_enable = 0;
        Read_enable = 1;
	
	//Read When FIFO is Empty 
        #200
        Wr_enable = 0;
        Read_enable = 0;
        a_Reset = 0;
        #100
        a_Reset = 0;
        Read_enable = 1;
	// Write Till FIFO is FULL
	#200
	Wr_enable = 1;
	Read_enable = 0;
	for(i=0 ; i<34 ; i=i+1)begin
            data_in = $random;
	    #200;
	end

	// Reading Till FIFO is FULL
	#200
	Wr_enable = 0;
	Read_enable = 1;
	for(i=0 ; i<50 ; i=i+1)begin
	    #100;
	end

    end
endmodule
