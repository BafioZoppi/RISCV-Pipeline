library IEEE;
use IEEE.STD_LOGIC_1164.all;

library work;
use work.constants.all;
use work.records.all;
--use work.proc_lib.all;
use work.comp_lib.all;

entity comp_2_testbench is
end entity;

architecture behav of comp_2_testbench is
    signal clock : std_logic := '0';
    constant delay : time := 5 ns;

    signal reg_data : reg_record := zero_reg;
    signal jump_data : jump_record := zero_jump;
    signal wb_data : wb_record := zero_wb;
    begin
        clock <= not clock after delay;

        comp_2_tb : component_2
        port map(clock => clock, reg_data => reg_data,
                jump_data => jump_data, wb_data => wb_data);

                process begin
                    wait for delay;
                        reg_data.prog_count <= (register_size - 1 downto 4 => '0') & "1111";
                        reg_data.rd <= "00110";
                        reg_data.rs1_val <= (register_size - 1 downto 4 => '0') & "1001";
                        reg_data.rs2_val <= (register_size - 1 downto 4 => '0') & "1011";
                        reg_data.immediate <= (register_size - 1 downto 4 => '0') & "0011";
                    wait for delay*2;
                        reg_data.instruction_type <= INST_ADD;
                    wait for delay*2;
                        reg_data.instruction_type <= INST_ADDI;
                    wait for delay*2;
                        reg_data.instruction_type <= INST_BLT;
                    wait for delay*2;
                        reg_data.instruction_type <= INST_BEQ;
                    wait for delay*2;
                        reg_data.instruction_type <= INST_LD;
                    wait for delay*2;
                        reg_data.instruction_type <= INST_SD;
                    wait;
                end process;
end architecture;