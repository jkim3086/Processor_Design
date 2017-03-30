library verilog;
use verilog.vl_types.all;
entity SCProcController is
    generic(
        INST_BIT_WIDTH  : integer := 32;
        REG_INDEX_BIT_WIDTH: integer := 4;
        ALU_OP_WIDTH    : integer := 5
    );
    port(
        inst            : in     vl_logic_vector;
        cond_flag       : in     vl_logic;
        rd              : out    vl_logic_vector;
        rs1             : out    vl_logic_vector;
        rs2             : out    vl_logic_vector;
        imm             : out    vl_logic_vector(15 downto 0);
        alu_op          : out    vl_logic_vector;
        pc_sel          : out    vl_logic_vector(1 downto 0);
        rf_wrt_data_sel : out    vl_logic_vector(1 downto 0);
        alu_in2_sel     : out    vl_logic_vector(1 downto 0);
        rf_wrt_en       : out    vl_logic;
        mem_wrt_en      : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of INST_BIT_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of REG_INDEX_BIT_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of ALU_OP_WIDTH : constant is 1;
end SCProcController;
