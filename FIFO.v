module FIFO #(
    parameter ADD_WIDTH = 5,
    parameter DATA_WIDTH = 8
) (
    input clk_read,
    input clk_write,
    input[ DATA_WIDTH - 1: 0 ] data_in,
    input Wr_enable,
    input Read_enable,
    input a_Reset,
    output reg[ DATA_WIDTH - 1: 0 ] data_out
);

    reg IsFull,IsEmpty;
    reg[ ADD_WIDTH - 1: 0 ] FIFO_Cnt;
    reg [ DATA_WIDTH-1 : 0 ] FIFO_MEM [ 0 : (2**ADD_WIDTH) - 1 ]; // The Actual FIFO Memory
    reg [ ADD_WIDTH-1 : 0 ] Wr_ptr,Rd_ptr; // WrPtr==Head pointer ...... RdPtr===Tail Pinter
    integer i;

	assign FIFO_Cnt = 0;
    always @(FIFO_Cnt) begin
        IsEmpty = 0;
        IsFull = 0;
        if(FIFO_Cnt == 0) begin
            IsEmpty = 1;// No Read
        end
        else if(FIFO_Cnt == (2**ADD_WIDTH) - 1)begin
            IsFull = 1; // No Write
        end
    end

   always @(posedge clk_read or posedge clk_write) begin
        if( !Wr_enable && !Read_enable  || Wr_enable && Read_enable)begin
            FIFO_Cnt <= FIFO_Cnt;
        end
   end

    //Empty the Whole FIFO
    always @(posedge a_Reset) begin
        i = 0;
        for (i = 0 ;i<(2**ADD_WIDTH) ; i = i+1 ) begin
            FIFO_MEM [i] <= 0;
        end
    end

    // Write Operation
    always @(posedge clk_write or posedge a_Reset) begin
        if (a_Reset) begin
            Wr_ptr <= 0;
        end
        else if(Wr_enable && !IsFull) begin
            FIFO_MEM[Wr_ptr] <= data_in;
	    FIFO_Cnt <= FIFO_Cnt + 1;
            if (Wr_ptr == (2**ADD_WIDTH) - 1) begin
                Wr_ptr = 0;
            end
            else begin
                Wr_ptr = Wr_ptr + 1;
            end
        end
        else begin
            FIFO_MEM[Wr_ptr] = FIFO_MEM[Wr_ptr];
        end
    end

    //Read Operation
    always @(posedge clk_read or posedge a_Reset ) begin
            if (a_Reset) begin
                Rd_ptr <= 0;
                data_out <= 0;
            end
            else if(Read_enable && !IsEmpty) begin
                data_out <= FIFO_MEM[Rd_ptr];
		FIFO_Cnt <= FIFO_Cnt - 1;
                if (Rd_ptr == (2**ADD_WIDTH) - 1) begin
                    Rd_ptr = 0;
                end
                else begin
                    Rd_ptr = Rd_ptr + 1;
                end
            end
            else begin
                FIFO_MEM[Rd_ptr] = FIFO_MEM[Rd_ptr];
            end
    end
        


endmodule