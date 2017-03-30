library verilog;
use verilog.vl_types.all;
entity ClockDivider is
    generic(
        count_reset     : integer := 0;
        count_limit     : integer := 249999
    );
    port(
        inclk0          : in     vl_logic;
        reset           : in     vl_logic;
        c0              : out    vl_logic;
        count_check     : out    vl_logic_vector(31 downto 0);
        count_count     : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of count_reset : constant is 1;
    attribute mti_svvh_generic_type of count_limit : constant is 1;
end ClockDivider;
