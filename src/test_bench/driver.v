module driver(CLK,RST,OPA,OPB,CMD,MODE,CIN,CE,INP_VALID);
input CLK,RST;
output reg [7:0]OPA, OPB, CMD;
output reg MODE;
output reg CIN, CE;
output reg [1:0] INP_VALID;
integer tc_no;

task apply_test;
input [7:0] t_opa;
input [7:0] t_opb;
input [3:0] t_cmd;
input t_mode, t_cin;
input [1:0] t_valid;
input t_ce;
begin
tc_no=tc_no+1;
@(negedge CLK);
OPA=t_opa;
OPB=t_opb;
CMD=t_cmd;
MODE=t_mode;
CIN=t_cin;
INP_VALID=t_valid;
CE=t_ce;

$display("Testcase %0d",tc_no);
@(posedge CLK);
end
endtask


initial begin
tc_no=0;
OPA=0;
OPB=0;
CMD=0;
MODE=1;
CIN=0;
CE=1;
INP_VALID=2'b11;
apply_test(8'h00,8'h00,4'd0 ,1'b1,1'b0,2'b00,1'b1);

@(negedge RST);
#2;
apply_test(8'h05,8'h03,4'd0 ,1'b1,1'b0,2'b11,1'b0);
apply_test(8'h07,8'h02,4'd1 ,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h00,8'h00,4'd0 ,1'b1,1'b0,2'b11,1'b1);
apply_test(8'd11,8'd11,4'd0 ,1'b1,1'b0,2'b11,1'b1);
apply_test(8'hFF,8'hFF,4'd0 ,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h01,8'h01,4'd0 ,1'b1,1'b1,2'b11,1'b1);
apply_test(8'd5 ,8'd3 ,4'd0 ,1'b1,1'b0,2'b11,1'b1);
apply_test(8'd12,8'd10,4'd0 ,1'b1,1'b0,2'b11,1'b1);
apply_test(8'd15,8'd1 ,4'd0 ,1'b1,1'b0,2'b11,1'b1);
apply_test(8'd0 , 8'd0 , 4'b0000, 1,0,2'b11,1);
apply_test(8'd11, 8'd11, 4'b0000, 1,0,2'b11,1);
apply_test(8'd255,8'd255,4'b0000, 1,0,2'b11,1);
apply_test(8'd5 , 8'd3 , 4'b0001, 1,0,2'b11,1);
apply_test(8'd3 , 8'd5 , 4'b0001, 1,0,2'b11,1);
apply_test(8'h05,8'h04,4'd1 ,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h00,8'h00,4'd1 ,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h02,8'h01,4'd1 ,1'b1,1'b1,2'b11,1'b1);
apply_test(8'h05,8'h05,4'd1 ,1'b1,1'b0,2'b11,1'b1);
apply_test(8'hFF,8'hFF,4'd1 ,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h03,8'h05,4'd1 ,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h05,8'h02,4'd2 ,1'b1,1'b1,2'b11,1'b1);
apply_test(8'hFF,8'hFF,4'd2 ,1'b1,1'b1,2'b11,1'b1);
apply_test(8'h00,8'h00,4'd2 ,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h0A,8'h05,4'd3 ,1'b1,1'b1,2'b11,1'b1);
apply_test(8'h01,8'h01,4'd3 ,1'b1,1'b1,2'b11,1'b1);
apply_test(8'h00,8'h00,4'd3 ,1'b1,1'b1,2'b11,1'b1);
apply_test(8'h01,8'h00,4'd4 ,1'b1,1'b0,2'b01,1'b1);
apply_test(8'hFF,8'h00,4'd4 ,1'b1,1'b0,2'b01,1'b1);
apply_test(8'h03,8'h00,4'd5 ,1'b1,1'b0,2'b01,1'b1);
apply_test(8'h00,8'h00,4'd5 ,1'b1,1'b0,2'b01,1'b1);

apply_test(8'h00,8'h01,4'd6 ,1'b1,1'b0,2'b10,1'b1);
apply_test(8'h00,8'hFF,4'd6 ,1'b1,1'b0,2'b10,1'b1);

apply_test(8'h00,8'h03,4'd7 ,1'b1,1'b0,2'b10,1'b1);
apply_test(8'h00,8'h00,4'd7 ,1'b1,1'b0,2'b10,1'b1);

apply_test(8'h05,8'h02,4'd8 ,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h02,8'h05,4'd8 ,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h00,8'h00,4'd8 ,1'b1,1'b0,2'b11,1'b1);

apply_test(8'h02,8'h03,4'd9 ,1'b1,1'b0,2'b11,1'b1);
repeat(3) @(posedge CLK);

apply_test(8'hFF,8'hFF,4'd9 ,1'b1,1'b0,2'b11,1'b1);
repeat(3) @(posedge CLK);
apply_test(8'h0F,8'h0F,4'd9 ,1'b1,1'b0,2'b11,1'b1);
repeat(3) @(posedge CLK);

apply_test(8'h03,8'h04,4'd9 ,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h01,8'h01,4'd0 ,1'b0,1'b0,2'b11,1'b1);
repeat(4) @(posedge CLK);

apply_test(8'h01,8'h02,4'd10,1'b1,1'b0,2'b11,1'b1);
repeat(3) @(posedge CLK);

apply_test(8'd5 ,8'd4 ,4'd11,1'b1,1'b0,2'b11,1'b1);
apply_test(8'hFD,8'hFC,4'd11,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h80,8'h80,4'd11,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h01,8'h01,4'd11,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h03,8'hFD,4'd11,1'b1,1'b0,2'b11,1'b1);

apply_test(8'hFA,8'hF7,4'd12,1'b1,1'b0,2'b11,1'b1);
apply_test(8'hF7,8'hFA,4'd12,1'b1,1'b0,2'b11,1'b1);
apply_test(8'hF7,8'hF7,4'd12,1'b1,1'b0,2'b11,1'b1);

apply_test(8'h03,8'h08,4'd12,1'b1,1'b0,2'b11,1'b1);
apply_test(8'hFA,8'h09,4'd12,1'b1,1'b0,2'b11,1'b1);
apply_test(8'hFA,8'hF7,4'd12,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h01,8'h01,4'd12,1'b1,1'b0,2'b11,1'b1);

apply_test(8'h01,8'h01,4'd0 ,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h11,8'h11,4'd0 ,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h00,8'h00,4'd0 ,1'b0,1'b0,2'b11,1'b1);

apply_test(8'h40,8'h02,4'd1 ,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h11,8'h11,4'd1 ,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h00,8'h00,4'd1 ,1'b0,1'b0,2'b11,1'b1);

apply_test(8'h01,8'h10,4'd2 ,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h11,8'h11,4'd2 ,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h00,8'h00,4'd2 ,1'b0,1'b0,2'b11,1'b1);

apply_test(8'h0F,8'hF0,4'd3 ,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h11,8'h11,4'd3 ,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h00,8'h00,4'd3 ,1'b0,1'b0,2'b11,1'b1);

apply_test(8'h01,8'h10,4'd4 ,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h11,8'h11,4'd4 ,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h00,8'h00,4'd4 ,1'b0,1'b0,2'b11,1'b1);

apply_test(8'h01,8'h10,4'd5 ,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h11,8'h11,4'd5 ,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h00,8'h00,4'd5 ,1'b0,1'b0,2'b11,1'b1);

apply_test(8'hFF,8'h00,4'd6 ,1'b0,1'b0,2'b01,1'b1);
apply_test(8'h00,8'hF0,4'd7 ,1'b0,1'b0,2'b10,1'b1);

apply_test(8'h40,8'h00,4'd8 ,1'b0,1'b0,2'b01,1'b1);
apply_test(8'h01,8'h00,4'd8 ,1'b0,1'b0,2'b01,1'b1);

apply_test(8'h40,8'h00,4'd9 ,1'b0,1'b0,2'b01,1'b1);
apply_test(8'h10,8'h00,4'd9 ,1'b0,1'b0,2'b01,1'b1);

apply_test(8'h00,8'h40,4'd10,1'b0,1'b0,2'b10,1'b1);
apply_test(8'h00,8'h01,4'd10,1'b0,1'b0,2'b10,1'b1);
apply_test(8'h00,8'h40,4'd11,1'b0,1'b0,2'b10,1'b1);
apply_test(8'h00,8'h10,4'd11,1'b0,1'b0,2'b10,1'b1);

apply_test(8'h01,8'h00,4'd12,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h01,8'h01,4'd12,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h01,8'h02,4'd12,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h01,8'h03,4'd12,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h01,8'h04,4'd12,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h01,8'h05,4'd12,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h01,8'h06,4'd12,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h01,8'h07,4'd12,1'b0,1'b0,2'b11,1'b1);

apply_test(8'h01,8'h10,4'd12,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h01,8'h20,4'd12,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h01,8'h40,4'd12,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h01,8'h80,4'd12,1'b0,1'b0,2'b11,1'b1);

apply_test(8'h80,8'h00,4'd13,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h80,8'h01,4'd13,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h80,8'h02,4'd13,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h80,8'h03,4'd13,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h80,8'h04,4'd13,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h80,8'h05,4'd13,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h80,8'h06,4'd13,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h80,8'h07,4'd13,1'b0,1'b0,2'b11,1'b1);

apply_test(8'h80,8'h10,4'd13,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h80,8'h10,4'd13,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h80,8'h20,4'd13,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h80,8'h40,4'd13,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h80,8'h80,4'd13,1'b0,1'b0,2'b11,1'b1);

apply_test(8'h00,8'h01,4'd14,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h00,8'h01,4'd15,1'b0,1'b0,2'b11,1'b1);

apply_test(8'h05,8'h05,4'd9,1'b1,1'b0,2'b11,1'b1);

apply_test(8'd3, 8'd4, 4'd0,1'b1,1'b0,2'b00,1'b1);
apply_test(8'd3, 8'd4, 4'd9, 1'b1, 1'b0, 2'b11, 1'b1);
apply_test(8'd0, 8'd0, 4'd9, 1'b1, 1'b0, 2'b00, 1'b1);

apply_test(8'd3, 8'd4, 4'd9, 1'b1, 1'b0, 2'b11, 1'b1);

 @(negedge CLK);
 INP_VALID = 2'b00;
 CE = 1'b1;
repeat(4) @(posedge CLK);

apply_test(8'h01,8'h01,4'd14,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h01,8'h01,4'd14,1'b0,1'b0,2'b11,1'b1);


apply_test(8'h1,8'h01,4'd0,1'b1,1'b0,2'b01,1'b1);
apply_test(8'h1,8'h01,4'b0001,1'b1,1'b0,2'b10,1'b1);
apply_test(8'h1,8'h01,4'b0010,1'b1,1'b0,2'b00,1'b1);
apply_test(8'h1,8'h01,4'b0011,1'b1,1'b0,2'b01,1'b1);
apply_test(8'h1,8'h01,4'b0100,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h1,8'h01,4'b0101,1'b1,1'b0,2'b10,1'b1);
apply_test(8'h1,8'h01,4'b0110,1'b1,1'b0,2'b01,1'b1);
apply_test(8'h1,8'h01,4'b0111,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h1,8'h01,4'b1000,1'b1,1'b0,2'b00,1'b1);
apply_test(8'h1,8'h01,4'b1010,1'b1,1'b0,2'b01,1'b1);
apply_test(8'h1,8'h01,4'b1011,1'b1,1'b0,2'b10,1'b1);
apply_test(8'h1,8'h01,4'b1100,1'b1,1'b0,2'b00,1'b1);

apply_test(8'h1,8'h1,4'b0000,1'b0,1'b0,2'b01,1'b1);
apply_test(8'h1,8'h01,4'b0001,1'b0,1'b0,2'b10,1'b1);
apply_test(8'h1,8'h01,4'b0010,1'b0,1'b0,2'b00,1'b1);
apply_test(8'h1,8'h01,4'b0011,1'b0,1'b0,2'b01,1'b1);
apply_test(8'h1,8'h01,4'b0100,1'b0,1'b0,2'b10,1'b1);
apply_test(8'h1,8'h01,4'b0101,1'b0,1'b0,2'b00,1'b1);
apply_test(8'h1,8'h01,4'b0110,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h1,8'h01,4'b0111,1'b0,1'b0,2'b01,1'b1);
apply_test(8'h1,8'h01,4'b1000,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h1,8'h01,4'b1001,1'b0,1'b0,2'b10,1'b1);
apply_test(8'h1,8'h01,4'b1010,1'b0,1'b0,2'b11,1'b1);
apply_test(8'h1,8'h01,4'b1011,1'b0,1'b0,2'b01,1'b1);
apply_test(8'h1,8'h01,4'b1100,1'b0,1'b0,2'b00,1'b1);
apply_test(8'h1,8'h01,4'b1101,1'b0,1'b0,2'b01,1'b1);

apply_test(8'h7F, 8'h00,4'b1011,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h7F, 8'h80,4'b1011,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h40,8'h40,4'b1011,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h7F,8'h01,4'b1011,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h80,8'h80,4'b1011,1'b1,1'b0,2'b11,1'b1);

apply_test(8'h7F,8'h01,4'b1100,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h01,8'h7F,4'b1100,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h80,8'h01,4'b1100,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h01,8'h80,4'b1100,1'b1,1'b0,2'b11,1'b1);

apply_test(8'hFF,8'h01,4'b1011,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h01,8'hFF,4'b1011,1'b1,1'b0,2'b11,1'b1);


apply_test(8'hF0,8'hF0,4'b1001,1'b1,1'b0,2'b11,1'b1);
repeat(3) @(posedge CLK);
apply_test(8'hFF,8'hFF,4'b1001,1'b1,1'b0,2'b11,1'b1);
repeat(3) @(posedge CLK);
apply_test(8'h80,8'h80,4'b1001,1'b1,1'b0,2'b11,1'b1);
repeat(3) @(posedge CLK);

apply_test(8'h00,8'h00,4'b1001,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h08,8'h08,4'b1001,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h0F,8'h01,4'b1001,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h07,8'h08,4'b1001,1'b1,1'b0,2'b11,1'b1);
apply_test(8'h10,8'h10,4'b1001,1'b1,1'b0,2'b11,1'b1);

apply_test(8'h07, 8'h01, 4'd9, 1'b1, 1'b0, 2'b11, 1'b1);
apply_test(8'h0F, 8'h01, 4'd9, 1'b1, 1'b0, 2'b11, 1'b1);
apply_test(8'h08, 8'h03, 4'd10, 1'b1, 1'b0, 2'b11, 1'b1);
apply_test(8'h01, 8'h08, 4'd10, 1'b1, 1'b0, 2'b11, 1'b1);
apply_test(8'h07, 8'h07, 4'd9, 1,0,2'b11,1);
apply_test(8'h0F, 8'h0F, 4'd9, 1,0,2'b11,1);
apply_test(8'hF0, 8'h0F, 4'd9, 1,0,2'b11,1);
apply_test(8'hAA, 8'h55, 4'd9, 1,0,2'b11,1);
@(posedge CLK);
apply_test(8'h08, 8'h01, 4'd9, 1,0,2'b11,1); 
apply_test(8'h09, 8'h01, 4'd9, 1,0,2'b11,1);  
apply_test(8'h0F, 8'h01, 4'd9, 1,0,2'b11,1);  
apply_test(8'h07, 8'h01, 4'd9, 1,0,2'b11,1);
apply_test(8'h08, 8'h00, 4'd10, 1,0,2'b11,1);
apply_test(8'h0F, 8'h00, 4'd10, 1,0,2'b11,1);
apply_test(8'hF0, 8'h00, 4'd10, 1,0,2'b11,1);
apply_test(8'h80, 8'h00, 4'd10, 1,0,2'b11,1);
#50000;
$finish;
end
endmodule


