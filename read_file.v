module dosyadan_okuma #(
	parameter LENGTH = 14400,
	parameter DATA_WIDTH = 32
)(
	input clock,

	output reg dataFinishedFlag,	
	output reg signed [DATA_WIDTH - 1:0] outputRe
);


reg signed [DATA_WIDTH-1:0] MIFBuffer [0:LENGTH - 1];
reg signed [DATA_WIDTH-1:0] realCoeffBuffer [0:LENGTH - 1];

reg [19:0] coeffBufferCounter; 


// Set the initial values.
initial begin: initValues

	coeffBufferCounter = 20'd0;
	dataFinishedFlag = 1'd0;
	outputRe = {(DATA_WIDTH){1'd0}};
	$readmemb("MFInputData.mif", MIFBuffer);
	
end	

always@(posedge (clock)) begin

if (coeffBufferCounter<=LENGTH-1) begin
	realCoeffBuffer[coeffBufferCounter] = MIFBuffer[coeffBufferCounter];
	outputRe = MIFBuffer[coeffBufferCounter];
	coeffBufferCounter = coeffBufferCounter + 20'd1;
end
else begin
    coeffBufferCounter = 20'd0;
	dataFinishedFlag = 1'd1;
	$stop;
end
end
endmodule