// Class: CSE 401
// Term: Fall 2018
// Name(s): Cyrus A. Melchor and Raymund G. Palafox
// Lab 1: IF stage
// HDL: Verilog
// Filename: pipeline.v     
module pipeline ();
    wire [31:0] IF_ID_instrout;
    wire [31:0] IF_ID_npcout;
    wire        EX_MEM_PCSrc;
    wire [31:0] EX_MEM_NPC,
                WB_mux5_writedata;
    wire [4:0]  regwrite;
    wire [1:0]  wb_ctlout, wb_ctlout2;
    wire [2:0]  m_ctlout;
    wire        regdst,
                alusrc;
    wire [1:0]  aluop;
    wire [31:0] npcout,
                rdata1out,
                rdata2out,
                rdata2out2,
                s_extendout,
                mem_alu_result,
                read_data,
                alu_result;
    wire [4:0]  instrout_2016,
                instrout_1511,
                five_bit_muxout;
    wire        memwrite,
                zero,
                memtoreg,
                MEM_WB_regwrite;
    wire        branch,
                memread;

    I_FETCH I_FETCH1 (.EX_MEM_PCSrc(EX_MEM_PCSrc),
                      .EX_MEM_NPC(EX_MEM_NPC),
                      .IF_ID_instr(IF_ID_instrout),
                      .IF_ID_npc(IF_ID_npcout));

    IDECODE IDECODE1 (.IF_ID_instrout(IF_ID_instrout),
                        .IF_ID_npcout(IF_ID_npcout),
                        .MEM_WB_rd(regwrite),
                        .MEM_WB_regwrite(MEM_WB_regwrite),
                        .WB_mux5_writedata(WB_mux5_writedata),
                        .wb_ctlout(wb_ctlout),
                        .m_ctlout(m_ctlout),
                        .regdst(regdst),
                        .alusrc(alusrc),
                        .aluop(aluop),
                        .npcout(npcout),
                        .rdata1out(rdata1out),
                        .rdata2out(rdata2out),
                        .s_extendout(s_extendout),
                        .instrout_2016(instrout_2016),
                        .instrout_1511(instrout_1511));

    EXECUTE EXECUTE1(.wb_ctl(wb_ctlout),
                         .m_ctl(m_ctlout),
                         .regdst(regdst),
                         .alusrc(alusrc),
                         .aluop(aluop),
                         .npcout(npcout),
                         .rdata1(rdata1out),
                         .rdata2(rdata2out),
                         .s_extendout(s_extendout),
                         .instrout_2016(instrout_2016),
                         .instrout_1511(instrout_1511),
                         .wb_ctlout(wb_ctlout2),
                         .branch(branch),
                         .memread(memread),
                         .memwrite(memwrite),
                         .EX_MEM_NPC(EX_MEM_NPC),
                         .zero(zero),
                         .alu_result(alu_result),
                         .rdata2out(rdata2out2),
                         .five_bit_muxout(five_bit_muxout));

    MEMORY MEMORY1(.wb_ctlout(wb_ctlout2),
                       .branch(branch),
                       .memread(memread),
                       .memwrite(memwrite),
                       .zero(zero),
                       .alu_result(alu_result),
                       .rdata2out(rdata2out2),
                       .five_bit_muxout(five_bit_muxout),
                       .MEM_PCSrc(EX_MEM_PCSrc),
                       .MEM_WB_regwrite(MEM_WB_regwrite),
                       .MEM_WB_memtoreg(memtoreg),
                       .read_data(read_data),
                       .mem_alu_result(mem_alu_result),
                       .mem_write_reg(regwrite));

    writeback writeback1(.memtoreg(memtoreg),
                             .read_data(read_data),
                             .mem_alu_result(mem_alu_result),
                             .wb_data(WB_mux5_writedata));

endmodule
