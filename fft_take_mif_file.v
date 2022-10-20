module fft_dosya(
input clock                              ,
input  [31 : 0]  fft_input               ,
output reg [31 : 0] o_fft        
    );
    
    
localparam length       = 14400          ;
localparam data_width   = 32             ;


reg fft_data_valid_in                    ;
reg fft_data_last_in                     ;
wire [31:0] fft_data_out                 ;
wire [15:0] fft_user_out                 ;
wire fft_data_valid_out                  ;
wire fft_data_last_out                   ; 
wire data_finish_flag                    ;


xfft_0 your_instance_name (
  .aclk                         (clock)                     ,    // input wire aclk
  .s_axis_config_tdata          (0)                         ,    // input wire [23 : 0] s_axis_config_tdata
  .s_axis_config_tvalid         (0)                         ,    // input wire s_axis_config_tvalid
  .s_axis_config_tready         ()                          ,    // output wire s_axis_config_tready
  .s_axis_data_tdata            (fft_input)                 ,    // input wire [31 : 0] s_axis_data_tdata
  .s_axis_data_tvalid           (fft_data_valid_in)         ,    // input wire s_axis_data_tvalid
  .s_axis_data_tready           ()                          ,    // output wire s_axis_data_tready
  .s_axis_data_tlast            (fft_data_last_in)          ,    // input wire s_axis_data_tlast
  .m_axis_data_tdata            (fft_data_out)              ,    // output wire [31 : 0] m_axis_data_tdata
  .m_axis_data_tuser            (fft_user_out)              ,    // output wire [15 : 0] m_axis_data_tuser
  .m_axis_data_tvalid           (fft_data_valid_out)        ,    // output wire m_axis_data_tvalid
  .m_axis_data_tready           (1)                         ,    // input wire m_axis_data_tready
  .m_axis_data_tlast            (fft_data_last_out)         ,    // output wire m_axis_data_tlast
  .event_frame_started          ()                          ,    // output wire event_frame_started
  .event_tlast_unexpected       ()                          ,    // output wire event_tlast_unexpected
  .event_tlast_missing          ()                          ,    // output wire event_tlast_missing
  .event_status_channel_halt    ()                          ,    // output wire event_status_channel_halt
  .event_data_in_channel_halt   ()                          ,    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt  ()                               // output wire event_data_out_channel_halt
);


dosyadan_okuma #(
.LENGTH                  (length)                        ,
.DATA_WIDTH              (data_width)
)DUT_dosya_okuma(
.clock                   (clock)                         ,
.dataFinishedFlag        (data_finish_flag)              ,
.outputRe                (fft_input)
);


always @ (posedge (clock)) begin

	fft_data_valid_in <= 1'd1;
	o_fft = fft_data_out;


end


endmodule
