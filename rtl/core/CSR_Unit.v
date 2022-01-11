`default_nettype none

module CSR_Unit
(
    // Global signals
    input   wire    clk_i,
    input   wire    rst_i,

    // Signals for Reading from / Writing to CSRs
    input   wire [11:0]     addr_i,
    input   wire [31:0]     data_i,
    input   wire [1:0]      op_i,
    /* verilator lint_off UNUSED */
    input   wire            we_i,
    /* verilator lint_on UNUSED */

    output  reg  [31:0]     data_o

    // input signals from pipeline

    // ouput signals to pipeline
);


/* Generate Data to be written */
/* verilator lint_off UNUSED */
reg  [31:0] write_value;    // Value to be written onto a CSR register
/* verilator lint_on UNUSED */
reg  [31:0] read_value;     // Value of selected CSR register

always @(*) /* COMBINATIONAL */ begin
    case(op_i[1:0])
        2'b00: write_value = data_i;                   // CSRRW
        2'b01: write_value = data_i & read_value;      // CSRRS
        2'b10: write_value = ~(data_i & read_value);   // CSRRC

        default:
        write_value = read_value;
    endcase
end

////////////////////////////////////////////////////////////
// CSR Registers

// CYCLE (Read-Only)
reg [63:0]  csr_cycle = 64'd0;

always @(posedge clk_i) begin
    if(rst_i)
        csr_cycle <= 64'd0;
    else
        csr_cycle <= csr_cycle + 1'b1;
end


////////////////////////////////////////////////////////////
// CSR Selection

// assigns the read value function to various CSRs and sets we 
// pins of CSRs (if not Readonly)

always @(*) /* COMBINATIONAL */ begin
    // Defaults
    data_o = 0;
    
    case(addr_i)
        12'hc00: begin
            read_value = csr_cycle[31:0];
        end

        12'hc80: begin
            read_value = csr_cycle[63:32];
        end
            
        default: begin
            read_value = 0;
        end
            
    endcase
end

assign data_o = read_value;

endmodule