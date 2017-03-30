library verilog;
use verilog.vl_types.all;
entity SignExtension is
    generic(
        IN_BIT_WIDTH    : integer := 16;
        OUT_BIT_WIDTH   : integer := 32
    );
    port(
        dIn             : in     vl_logic_vector;
        dOut            : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IN_BIT_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of OUT_BIT_WIDTH : constant is 1;
end SignExtension;
