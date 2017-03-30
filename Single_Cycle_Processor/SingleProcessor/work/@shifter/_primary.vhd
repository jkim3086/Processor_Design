library verilog;
use verilog.vl_types.all;
entity Shifter is
    generic(
        BIT_WIDTH       : integer := 32;
        SHIFT_BITS      : integer := 2
    );
    port(
        \in\            : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BIT_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of SHIFT_BITS : constant is 1;
end Shifter;
