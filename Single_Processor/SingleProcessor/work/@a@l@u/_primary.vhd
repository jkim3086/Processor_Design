library verilog;
use verilog.vl_types.all;
entity ALU is
    generic(
        data_bit_width  : integer := 32;
        op_bit_width    : integer := 5
    );
    port(
        src1            : in     vl_logic_vector;
        src2            : in     vl_logic_vector;
        opcode          : in     vl_logic_vector;
        data_out        : out    vl_logic_vector;
        cond_flag       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of data_bit_width : constant is 1;
    attribute mti_svvh_generic_type of op_bit_width : constant is 1;
end ALU;
