CREATE OR REPLACE VIEW kfl_production_dbp_view.v_pc_pc_grp_zu AS SELECT pc_id,
 system_id,
 mandant_id,
 krk_id,
 pc_grp_id,
 pc_hiertyp_id
FROM kfl_production_dbp_data.pc_pc_grp_zu;