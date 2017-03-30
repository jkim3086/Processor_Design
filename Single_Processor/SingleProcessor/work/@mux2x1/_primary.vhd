library verilog;
use verilog.vl_types.all;
entity Mux2x1 is
    generic(
        BIT_WIDTH       : integer := 32
    );
    port(
        sel             : in     vl_logic;
        in0             : in     vl_logic_vector;
        in1             : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BIT_WIDTH : constant is 1;
end Mux2x1;
