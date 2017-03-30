library verilog;
use verilog.vl_types.all;
entity ClockDivider is
    port(
        CLOCK_50        : in     vl_logic;
        c0              : out    vl_logic;
        locked          : out    vl_logic
    );
end ClockDivider;
