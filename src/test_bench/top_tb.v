module top_tb;
parameter WIDTH=8;
parameter RES_WIDTH=16;
wire [WIDTH-1:0]OPA;
wire [WIDTH-1:0]OPB;
reg CLK, RST;
wire  CE, MODE, CIN;
wire [3:0]CMD;
wire [1:0] INP_VALID;

wire [RES_WIDTH-1:0]RES;
wire COUT,OFLOW,G,E,L,ERR;
alu_design #(WIDTH,RES_WIDTH) dut(.OPA(OPA),.OPB(OPB),.CIN(CIN),.CLK(CLK),.RST(RST),.CMD(CMD),.CE(CE),.MODE(MODE),.INP_VALID(INP_VALID),.COUT(COUT),.OFLOW(OFLOW),.RES(RES),.G(G),.L(L),.E(E),.ERR(ERR));
driver drv(.CLK(CLK),.RST(RST),.OPA(OPA),.OPB(OPB),.CMD(CMD),.MODE(MODE),.CIN(CIN),.CE(CE),.INP_VALID(INP_VALID));
scoreboard sb(.CLK(CLK),.OPA(OPA),.OPB(OPB),.CMD(CMD),.MODE(MODE),.RES(RES),.CIN(CIN),.RST(RST),.CE(CE),.INP_VALID(INP_VALID),.COUT(COUT),.OFLOW(OFLOW),.G(G),.E(E),.L(L),.ERR(ERR));

initial begin
CLK=0;
forever #5 CLK=~CLK;
end
initial begin
#5000;
$finish;
end
initial begin
RST=1;
#12;
RST=0;
end
endmodule
