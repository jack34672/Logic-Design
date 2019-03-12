module ssd_test(
    output [0:8-1]display,
    input [4-1:0]bcd
    );
    
    reg [0:8-1]display;
    
    always @(bcd)
    case(bcd)
        4'd0: display = 8'b00000011;
        4'd1: display = 8'b10011111;
        4'd2: display = 8'b00100101;
        4'd5: display = 8'b01001001;
        default: display = 8'b1111111_1;
    endcase
    
endmodule