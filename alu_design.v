module alu #(parameter W=8, parameter W_cmd=4, localparam R=$clog2(W))(OPA,OPB,cin,rst,clk,ce,mode,inp_valid,cmd,res,oflow,cout,G,L,E,err);
input wire [W-1:0]OPA,OPB;
input wire clk,rst,ce,mode,cin;
input wire [1:0]inp_valid;
input wire [W_cmd-1:0]cmd;
output reg [2*W-1:0]res;
output reg oflow,cout,G,L,E,err;
reg zero,neg;
reg [1:0]count;
reg [W-1:0]opa_r,opb_r;
reg [W-1:0]OPA_1, OPB_1;
reg [W_cmd-1:0]cmd_r;
reg mode_r;
reg [2*W-1:0]temp;
reg valid_inp;
reg cin_r;
reg multi;

always @(*) begin
if(mode) begin
case(cmd)
4'd4, 4'd5: valid_inp=(inp_valid==2'b01 || inp_valid==2'b11);
4'd6, 4'd7: valid_inp=(inp_valid==2'b10 || inp_valid==2'b11);
default: valid_inp=(inp_valid==2'b11);
endcase
end
else begin
case(cmd)
4'd6, 4'd8, 4'd9:valid_inp=(inp_valid==2'b01 || inp_valid==2'b11);
4'd7, 4'd10, 4'd11: valid_inp=(inp_valid==2'b10 || inp_valid==2'b11);
default: valid_inp=(inp_valid==2'b11);
endcase
end
end
always @(posedge clk or posedge rst) begin 
if(rst) begin
count<=0;
res<=0;
cout<=0;
oflow<=0;
G<=1'b0;
L<=1'b0;
E<=1'b0;
err<=1'b0;
end
else if(ce) begin

err<=1'b0;
cout<=1'b0;
oflow<=0;
G<=0;L<=0;E<=0;
zero<=0;
neg<=0;

case(count)
2'd0: begin

if(valid_inp) begin
opa_r<=OPA;
opb_r<=OPB;
cmd_r<=cmd;
mode_r<=mode;
cin_r<=cin;
count<=1;
end
else
err<=1;
end

2'd1: begin
multi<=0;
temp<=0;
if(mode_r) begin

case(cmd_r) 
4'b0000: begin
temp=opa_r+opb_r;
res<=temp;
cout<=temp[W];
end

4'b0001: begin
temp=opa_r-opb_r;
res<=temp;
oflow<=(opa_r<opb_r)? 1:0;

end

4'b0010: begin
temp=opa_r+opb_r+cin_r;
res<=temp;
cout<=temp[W];
oflow<=temp[W];

end

4'b0011: begin
temp=opa_r-opb_r-cin_r;
res<=temp;
oflow<=(opa_r<opb_r)? 1:0;
cout<=~(opa_r<opb_r)?1:0;

end

4'b0100: begin
res<={{W{1'b0}},(opa_r+1)};

end

4'b0101: begin
temp=opa_r-1;
res<=temp;

end

4'b0110: begin
temp=opb_r+1;
res<={{W{1'b0}},temp[W-1:0]};
cout<=temp[W];

end

4'b0111: begin
temp=opb_r-1;
res<=temp;

end

4'b1000: begin
if(opa_r>opb_r) begin
G<=1'b1;
L<=1'b0;
E<=1'b0;

end
else if(opa_r<opb_r) begin
G<=1'b0;
L<=1'b1;
E<=1'b0;

end
else begin
G<=1'b0;
L<=1'b0;
E<=1'b1;

end

end

4'b1001: begin
opa_r<=opa_r+1;
opb_r<=opb_r+1;
count<=2;
multi<=1;
end

4'b1010: begin
opa_r<=opa_r<<1;
count<=2;
multi<=1;
end

4'b1011: begin
temp=$signed(opa_r)+$signed(opb_r);
res<=temp;
oflow<=(opa_r[W-1] & opb_r[W-1] & ~temp[W-1]) | (~opa_r[W-1] & ~opb_r[W-1] & temp[W-1]);
zero<=(temp[W-1:0]==0);
neg<=temp[W-1];

if($signed(opa_r)>$signed(opb_r)) begin
G<=1'b1;
L<=1'b0;
E<=1'b0;
end
else if($signed(opa_r)<$signed(opb_r)) begin
G<=1'b0;
L<=1'b1;
E<=1'b0;
end
else begin
G<=1'b0;
L<=1'b0;
E<=1'b1;
end

end

4'b1100: begin

temp=$signed(opa_r)-$signed(opb_r);
res<=temp;
oflow<=(opa_r[W-1] & ~opb_r[W-1] & ~temp[W-1]) | (~opa_r[W-1] & opb_r[W-1] & temp[W-1]);
zero<=(temp[W-1:0]==0);
neg<=temp[W-1];

if($signed(opa_r)>$signed(opb_r)) begin
G<=1'b1;
L<=1'b0;
E<=1'b0;
end
else if($signed(opa_r)<$signed(opb_r)) begin
G<=1'b0;
L<=1'b1;
E<=1'b0;
end
else begin
G<=1'b0;
L<=1'b0;
E<=1'b1;
end

end

default: begin
err<=1'b1;
count<=0;
end
endcase
if(valid_inp && !multi) begin
opa_r<=OPA;
opb_r<=OPB;
cmd_r<=cmd;
mode_r<=mode;
cin_r<=cin;
count<=1;
end
else if(!multi)begin
count<=0;
end
end

else  begin
case(cmd_r)
4'b0000: begin
temp=opa_r&opb_r;
res<={{W{1'b0}},temp[W-1:0]};

end

4'b0001: begin
temp=~(opa_r & opb_r);
res<={{W{1'b0}},temp[W-1:0]};
end

4'b0010: begin
temp=opa_r | opb_r;
res<={{W{1'b0}},temp[W-1:0]};
end

4'b0011: begin
temp=~(opa_r | opb_r);
res<={{W{1'b0}},temp[W-1:0]};
end

4'b0100: begin
temp=opa_r^ opb_r;
res<={{W{1'b0}},temp[W-1:0]};
end

4'b0101: begin
temp=~(opa_r^ opb_r);
res<={{W{1'b0}},temp[W-1:0]};
end

4'b0110: begin
temp=~opa_r;
res<={{W{1'b0}},temp[W-1:0]};
end

4'b0111: begin
temp=~opb_r;
res<={{W{1'b0}},temp[W-1:0]};
end

4'b1000: begin
temp=opa_r>>1;
res<={{W{1'b0}},temp[W-1:0]};
end

4'b1001: begin
temp=opa_r<<1;
res<={{W{1'b0}},temp[W-1:0]};
end

4'b1010: begin
temp=opb_r>>1;
res<={{W{1'b0}},temp[W-1:0]};
end

4'b1011: begin
temp=opb_r<<1;
res<={{W{1'b0}},temp[W-1:0]};
end

4'b1100: begin
if(|opb_r[W-1:R+1]) begin
err<=1'b1;
res<=res;
end
else begin
err<=1'b0;
temp=opb_r[R-1:0];
if(temp==0)
res<={{W{1'b0}},opa_r};
else
res<={{(W){1'b0}},((opa_r<<temp) | (opa_r>>(W-temp)))};
end
end

4'b1101: begin
if(|opb_r[W-1:R+1]) begin
err<=1'b1;
res<=res;
end
else begin
err<=1'b0;
temp=opb_r[R-1:0];
if(temp==0)
res<={{W{1'b0}},opa_r};
else
res<={{(W){1'b0}},((opa_r>>temp) | (opa_r<<(W-temp)))};
end
end

default: begin
err<=1'b1;
count<=0;
end
endcase
if(valid_inp) begin
opa_r<=OPA;
opb_r<=OPB;
cmd_r<=cmd;
mode_r<=mode;
cin_r<=cin;
count<=1;
end
else begin
count<=0;
end
end
end
2'd2: begin
temp=opa_r * opb_r;
res<=temp;

if(valid_inp) begin
opa_r<=OPA;
opb_r<=OPB;
cmd_r<=cmd;
mode_r<=mode;
cin_r<=cin;
count<=1;
end
else begin
count<=0;
end
end
endcase
end
end
endmodule

