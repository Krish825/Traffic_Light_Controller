module traffic_light_controller(
    input logic clk,
    input logic reset_n,

    output logic ns_red,
    output logic ns_yellow,
    output logic ns_green,

    output logic ew_red,
    output logic ew_yellow,
    output logic ew_green

);

//FSM state encoding 
localparam logic [2:0] S0_NS_GREEN = 3'b000;
localparam logic [2:0] S1_NS_YELLOW = 3'b001;
localparam logic [2:0] S2_ALL_RED_1 = 3'b010;
localparam logic [2:0] S3_EW_GREEN = 3'b011;
localparam logic [2:0] S4_EW_YELLOW = 3'b100;
localparam logic [2:0] S5_ALL_RED_2 =3'b101;

//State storage variables
logic [2:0] current_state;

//Timer counter
logic [2:0] timer_count;

//Sequiental Logic: state register and timer
always_ff @(posedge clk or negedge reset_n) begin
if (!reset_n) begin
current_state<= S0_NS_GREEN;
timer_count <=3'd0;
end

else begin

case (current_state)

S0_NS_GREEN:begin
    if (timer_count == 3'd4) begin
        timer_count <= 3'd0;
        current_state <= S1_NS_YELLOW;
    end
else begin
timer_count <= timer_count + 1'b1;

end

end

S1_NS_YELLOW: begin 
    if (timer_count == 3'd1) begin
        timer_count <= 3'd0;
        current_state <=S2_ALL_RED_1;
    end

    else begin

        timer_count <= timer_count +1'b1;

    end

end

S2_ALL_RED_1: begin
    if (timer_count == 3'd0)begin
        timer_count <=3'd0;
        current_state <= S3_EW_GREEN;
    end

    else begin

        timer_count <= timer_count + 1'b1;

    end

end

S3_EW_GREEN: begin
if (timer_count == 3'd4) begin
    timer_count <= 3'd0;
    current_state <= S4_EW_YELLOW;
end

else begin

    timer_count <= timer_count + 1'b1;

end

end

S4_EW_YELLOW: begin
    if (timer_count == 3'd1) begin
        timer_count <= 3'd0;
        current_state <= S5_ALL_RED_2;
    end

    else begin

        timer_count <= timer_count + 1'b1;

    end

end

S5_ALL_RED_2: begin
    if (timer_count == 3'd0) begin
        timer_count <= 3'd0;
        current_state <=S0_NS_GREEN;
    end

    else begin
        
        timer_count <= timer_count + 1'b1;

    end

end

default:begin 
    current_state <= S0_NS_GREEN;
    timer_count <= 3'd0;
end

endcase

end

end

// combinational logic: traffic light outputs
always_comb begin 
    //Default: all lights OFF
    ns_red = 1'b0;
    ns_yellow = 1'b0;
    ns_green = 1'b0;

    ew_red = 1'b0;
    ew_yellow = 1'b0;
    ew_green = 1'b0;

    case(current_state)

    S0_NS_GREEN: begin
        ns_green = 1'b1;
        ew_red = 1'b1;
    end

    S1_NS_YELLOW: begin
        ns_yellow = 1'b1;
        ew_red = 1'b1;
    end

    S2_ALL_RED_1: begin 
        ns_red = 1'b1;
        ew_red = 1'b1;
    end

    S3_EW_GREEN: begin
        ns_red = 1'b1;
        ew_green = 1'b1;
    end

    S4_EW_YELLOW: begin
        ns_red = 1'b1;
        ew_yellow = 1'b1;
    end 

    S5_ALL_RED_2: begin
        ns_red = 1'b1;
        ew_red = 1'b1;
    end 

    default: begin
        ns_red = 1'b1;
        ew_red = 1'b1;
    end 
    endcase

end

endmodule