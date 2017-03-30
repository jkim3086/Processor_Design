library verilog;
use verilog.vl_types.all;
entity RegFile is
    generic(
        ADDR_LEN        : integer := 4;
        DATA_LEN        : integer := 32
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        rd              : in     vl_logic_vector;
        rs1             : in     vl_logic_vector;
        rs2             : in     vl_logic_vector;
        wrt_en          : in     vl_logic;
        wrt_data        : in     vl_logic_vector;
        out1            : out    vl_logic_vector;
        out2            : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ADDR_LEN : constant is 1;
    attribute mti_svvh_generic_type of DATA_LEN : constant is 1;
end RegFile;
