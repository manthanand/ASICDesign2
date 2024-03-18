`timescale 1ns/1ps

module top1 (
    input   CLK,reset1,start1, input2,
    output   Krdy1, Drdy1,RSTn1, EN1,SU1, SI1,SE1,
    SO,reset2,start2,led1,led2,SCLK,BSY
     );


//logic enable2=0;
//logic enable21=0;

reg  enable2=0;
reg enable21=0;
reg inputtestsignal=0;


always@(posedge CLK ) 
begin
    if(reset1==0)
     begin
      if(start1==0)
      begin
        enable2<=1'b0;
        enable21<=1'b0; 
      end 
      else  if(start1==1)
        begin
        enable2<=1'b1;
        enable21<=1'b1;  
        end 
     end 
     else if(reset1==1)
        enable2<=1'b0;
        enable21<=1'b0; 
end

always@(posedge CLK ) 
begin
    if(led1==1)
    begin 
       if (input2==1)
       begin 
            inputtestsignal<=1'b1;
       end
    end 

    if(led1==0)
    begin 
       if (input2==0)
       begin 
            inputtestsignal<=1'b0;
       end
    end 
end

assign led1=enable2;
assign led2=inputtestsignal; 

endmodule


