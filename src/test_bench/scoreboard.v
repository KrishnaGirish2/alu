module scoreboard(OPA,OPB,CIN,CLK,RST,CMD,CE,MODE,INP_VALID,COUT,OFLOW,RES,G,E,L,ERR);

input CLK;
input RST;
input [7:0] OPA;
input [7:0] OPB;
input [3:0] CMD;
input [1:0] INP_VALID;
input MODE;
input CE;
input CIN;

input COUT;
input OFLOW;
input G;
input E;
input L;
input ERR;

input [15:0] RES;

reg valid_inp;
reg [1:0] count;

reg [7:0] opa_r,opb_r;
reg [15:0] exp_res;
reg exp_cout,exp_oflow;
reg exp_g,exp_e,exp_l,exp_err;
reg [15:0]temp;
reg [3:0]cmd_r;
reg mode_r;
reg multi;
reg cin_r;

always @(*) begin
	valid_inp=0;
	if(!CE) begin
		valid_inp=0;
	end

	else if(MODE) begin
		case(CMD)

		4'd4,4'd5: valid_inp=(INP_VALID==2'b01 || INP_VALID==2'b11);

		4'd6,4'd7: valid_inp=(INP_VALID==2'b10 || INP_VALID==2'b11);

		default: valid_inp=(INP_VALID==2'b11);
		endcase
	end

	else begin
		case(CMD)

		4'd6,4'd8,4'd9: valid_inp=(INP_VALID==2'b01 || INP_VALID==2'b11);

		4'd7,4'd10,4'd11: valid_inp=(INP_VALID==2'b10 || INP_VALID==2'b11);

		default: valid_inp=(INP_VALID==2'b11);
		endcase
	end
end

always @(posedge CLK) begin

	if(RST) begin

		exp_res<=0;
		exp_cout<=0;
		exp_oflow<=0;
		exp_g<=0;
		exp_l<=0;
		exp_e<=0;
		exp_err<=0;
		cmd_r<=0;
		mode_r<=0;

		opa_r<=0;
		opb_r<=0;
		cin_r<=0;
		count<=0;

	end

	else if(CE) begin
		exp_err<=1'b0;
		exp_cout<=1'b0;
		exp_oflow<=0;
		exp_g<=0;exp_l<=0;exp_e<=0;
		case(count)

		2'd0: begin
		exp_err   <= 1'b0;
		exp_cout  <= 1'b0;
		exp_oflow <= 1'b0;
		exp_g     <= 1'b0;
		exp_e     <= 1'b0;
		exp_l     <= 1'b0;
		if(valid_inp) begin

			opa_r<=OPA;
			opb_r<=OPB;
			cin_r<=CIN;
			cmd_r<=CMD;
			mode_r<=MODE;
			count<=2'd1;

		end

		else begin
			exp_err<=1'b1;
			count<=2'd0;
			exp_cout  <= 1'b0;
			exp_oflow <= 1'b0;
			exp_g     <= 1'b0;
			exp_e     <= 1'b0;
			exp_l     <= 1'b0;
		end
		end

		2'd1: begin
			exp_err   <= 1'b0;
			exp_cout  <= 1'b0;
			exp_oflow <= 1'b0;
			exp_g     <= 1'b0;
			exp_e     <= 1'b0;
			exp_l     <= 1'b0;
			temp<=0;
			multi<=0;
			if(mode_r) begin
				case(cmd_r)
				4'b0000: begin

				temp=opa_r+opb_r;
				exp_res<=temp;
				exp_cout<=temp[8];
				end
				4'b0001: begin
				temp=opa_r-opb_r;
				exp_res<=temp;

				exp_oflow<=(opa_r<opb_r) ? 1:0;
				end

				4'b0010: begin
				temp=opa_r+opb_r+cin_r;
				exp_res<=temp;

				exp_cout<=temp[8];
				end

				4'b0011: begin
				temp=opa_r-opb_r-cin_r;
				exp_res<=temp;

				exp_oflow<=(opa_r<opb_r) ? 1:0;
				end
				4'b0100: begin
				exp_res<={{8{1'b0}},(opa_r+1)};

				end

				4'b0101: begin
				temp=opa_r-1;
				exp_res<={{8{1'b0}},temp[7:0]};

				end

				4'b0110: begin
				temp=opb_r+1;
				exp_res<={{8{1'b0}},temp[7:0]};
				end

				4'b0111: begin
				temp=opb_r-1;
				exp_res<={{8{1'b0}},temp[7:0]};
				end

				4'b1000: begin
				if(opa_r>opb_r) begin
					exp_g<=1'b1;
					exp_l<=1'b0;
					exp_e<=1'b0;

				end
				else if(opa_r<opb_r) begin
					exp_g<=1'b0;
					exp_l<=1'b1;
					exp_e<=1'b0;

				end
				else begin
					exp_g<=1'b0;
					exp_l<=1'b0;
					exp_e<=1'b1;
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
				exp_res<=temp;
				exp_oflow<=(opa_r[7] & opb_r[7] & ~temp[7]) | (~opa_r[7] & ~opb_r[7] & temp[7]);

				if($signed(opa_r)>$signed(opb_r)) begin
					exp_g<=1'b1;
					exp_l<=1'b0;
					exp_e<=1'b0;
				end
				else if($signed(opa_r)<$signed(opb_r)) begin
					exp_g<=1'b0;
					exp_l<=1'b1;
					exp_e<=1'b0;
				end
				else if($signed(opa_r)<$signed(opb_r)) begin
					exp_g<=1'b0;
					exp_l<=1'b1;
					exp_e<=1'b0;
				end
				else begin
					exp_g<=1'b0;
					exp_l<=1'b0;
					exp_e<=1'b1;
				end

				end

				4'b1100: begin

				temp=$signed(opa_r)-$signed(opb_r);
				exp_res<=temp;
				exp_oflow<=(opa_r[7] & ~opb_r[7] & ~temp[7]) | (~opa_r[7] & opb_r[7] & temp[7]);

				if($signed(opa_r)>$signed(opb_r)) begin
					exp_g<=1'b1;
					exp_l<=1'b0;
					exp_e<=1'b0;
				end
				else if($signed(opa_r)<$signed(opb_r)) begin
					exp_g<=1'b0;
					exp_l<=1'b1;
					exp_e<=1'b0;
				end
				else begin
					exp_g<=1'b0;
					exp_l<=1'b0;
					exp_e<=1'b1;
				end

				end

				default: begin
					exp_err<=1'b1;
					count<= 0;
					exp_cout  <= 1'b0;
					exp_oflow <= 1'b0;
					exp_g     <= 1'b0;
					exp_e     <= 1'b0;
					exp_l     <= 1'b0;
					exp_res   <= 0;
				end
				endcase

				if(valid_inp && !multi) begin
					opa_r<=OPA;
					opb_r<=OPB;
					cmd_r<=CMD;
					mode_r<=MODE;
					cin_r<=CIN;
					count<=1;
				end
				else if(!multi) begin
					count<=0;
					exp_err   <= 1'b1;
    					exp_res   <= 0;
    					exp_cout  <= 0;
    					exp_oflow <= 0;
    					exp_g     <= 0;
    					exp_e     <= 0;
    					exp_l     <= 0;
				end
			end


			else  begin
				case(cmd_r)
					4'b0000: begin
					temp=opa_r&opb_r;
					exp_res<={{8{1'b0}},temp[7:0]};
					end

					4'b0001: begin
					temp=~(opa_r & opb_r);
					exp_res<={{8{1'b0}},temp[7:0]};
					end

					4'b0010: begin
					temp=opa_r | opb_r;
					exp_res<={{8{1'b0}},temp[7:0]};
					end

					4'b0011: begin
					temp=~(opa_r | opb_r);
					exp_res<={{8{1'b0}},temp[7:0]};
					end

					4'b0100: begin
					temp=opa_r^ opb_r;
					exp_res<={{8{1'b0}},temp[7:0]};
					end

					4'b0101: begin
					temp=~(opa_r^ opb_r);
					exp_res<={{8{1'b0}},temp[7:0]};
					end

					4'b0110: begin
					temp=~opa_r;
					exp_res<={{8{1'b0}},temp[7:0]};
					end

					4'b0111: begin
					temp=~opb_r;
					exp_res<={{8{1'b0}},temp[7:0]};
					end

					4'b1000: begin
					temp=opa_r>>1;
					exp_res<={{8{1'b0}},temp[7:0]};
					end

					4'b1001: begin
					temp=opa_r<<1;
					exp_res<={{8{1'b0}},temp[7:0]};
					end
					4'b1010: begin
					temp=opb_r>>1;
					exp_res<={{8{1'b0}},temp[7:0]};
					end

					4'b1011: begin
					temp=opb_r<<1;
					exp_res<={{8{1'b0}},temp[7:0]};
					end
	
					4'b1100: begin
					if(|opb_r[7:4]) begin
						exp_err<=1'b1;
						exp_res<=exp_res;
					end
					else begin
						exp_err<=1'b0;
						temp=opb_r[2:0];
						if(temp==0)
							exp_res<={{8{1'b0}},opa_r};
						else
							exp_res<={{(8){1'b0}},((opa_r<<temp) | (opa_r>>(8-temp)))};
					end
					end

					4'b1101: begin
					if(|opb_r[7:4]) begin
						exp_err<=1'b1;
						exp_res<=exp_res;
					end
					else begin
						exp_err<=1'b0;
						temp=opb_r[2:0];
						if(temp==0)
							exp_res<={{8{1'b0}},opa_r};
						else
							exp_res<={{(8){1'b0}},((opa_r>>temp) | (opa_r<<(8-temp)))};
					end
					end

					default: begin
						exp_err<=1'b1;
						count<=0;
						exp_cout  <= 1'b0;
						exp_oflow <= 1'b0;
						exp_g     <= 1'b0;
						exp_e     <= 1'b0;
						exp_l     <= 1'b0;

					end
				endcase
				if(valid_inp) begin
					opa_r<=OPA;
					opb_r<=OPB;
					cmd_r<=CMD;
					mode_r<=MODE;
					cin_r<=CIN;
					count<=1;
				end
				else begin
					count<=0;
					exp_err   <= 1'b1;
					exp_cout  <= 1'b0;
					exp_oflow <= 1'b0;
					exp_g     <= 1'b0;
					exp_e     <= 1'b0;
					exp_l     <= 1'b0;
					exp_res   <= 0;
				end
			end
		end
		2'd2: begin
		temp=opa_r * opb_r;
		exp_res<=temp;

		if(valid_inp) begin
			opa_r<=OPA;
			opb_r<=OPB;
			cmd_r<=CMD;
			mode_r<=MODE;
			cin_r<=CIN;
			count<=1;
		end
		else begin
			count<=0;
			exp_err   <= 1'b1;
    			exp_res   <= 0;
    			exp_cout  <= 0;
			exp_oflow <= 0;
    			exp_g     <= 0;
    			exp_e     <= 0;
    			exp_l     <= 0;
		end
		end
		endcase
	end
end


always @(negedge CLK) begin
#2;
	if(!RST && (count==2'd1 || count==2'd2)) begin

	#1;

		case(mode_r)

		1'b1: begin

    		case(cmd_r)
    		4'b0000: begin

        	if((RES===exp_res) )
            		$display("[PASS ADD] opa=%0d opb=%0d res=%0d",opa_r,opb_r,RES);

        	else
            		$display("[FAIL ADD] opa=%0d opb=%0d exp=%0d act=%0d exp_cout=%0d cout=%0d",opa_r,opb_r,exp_res,RES,exp_cout,COUT);

    		end



    		4'b0001: begin

        	if((RES===exp_res) && (OFLOW===exp_oflow))
            		$display("[PASS SUB] opa=%0d opb=%0d res=%0d",opa_r,opb_r,RES);

		else
            		$display("[FAIL SUB] opa=%0d opb=%0d exp=%0d act=%0d",opa_r,opb_r,exp_res,RES);

    		end


    		4'b0010: begin

        	if((RES===exp_res) && (COUT===exp_cout))
            		$display("[PASS ADC] opa=%0d opb=%0d res=%0d",opa_r,opb_r,RES);

        	else
            		$display("[FAIL ADC] opa=%0d opb=%0d exp=%0d act=%0d",opa_r,opb_r,exp_res,RES);

    		end
 		4'b1000: begin

        	if((G===exp_g)&&(L===exp_l)&&(E===exp_e))
            		$display("[PASS CMP] opa=%0d opb=%0d",opa_r,opb_r);

        	else
            		$display("[FAIL CMP] G=%0d/%0d L=%0d/%0d E=%0d/%0d",exp_g,G,exp_l,L,exp_e,E);

    		end

    		4'b1001: begin

        	if(RES===exp_res)
            		$display("[PASS MUL] opa=%0d opb=%0d res=%0d",opa_r,opb_r,RES);

        	else
            		$display("[FAIL MUL] exp=%0d act=%0d",exp_res,RES);

    		end

    		default: begin

        	if(RES===exp_res)
            		$display("[PASS] cmd=%b res=%0d",cmd_r,RES);

        	else
            		$display("[FAIL] cmd=%b exp=%0d act=%0d",cmd_r,exp_res,RES);

    		end

    		endcase

	end
	1'b0: begin

    		case(cmd_r)

    		4'b1100,4'b1101: begin
			if((RES===exp_res)&&(ERR===exp_err))
            			$display("[PASS ROTATE] res=%0d",RES);
			else
            			$display("[FAIL ROTATE] exp=%0d act=%0d err=%0d/%0d",exp_res,RES,exp_err,ERR);
		end

    		default: begin

        	if(RES===exp_res)
            		$display("[PASS LOGIC] cmd=%b res=%0d",cmd_r,RES);

        	else
            		$display("[FAIL LOGIC] cmd=%b exp=%0d act=%0d",cmd_r,exp_res,RES);
		end

    		endcase

	end
	endcase
	if(ERR !== exp_err) begin
    		$display("[FAIL ERR] exp_err=%0d act_err=%0d",exp_err,ERR);
	end

	end

end
endmodule





