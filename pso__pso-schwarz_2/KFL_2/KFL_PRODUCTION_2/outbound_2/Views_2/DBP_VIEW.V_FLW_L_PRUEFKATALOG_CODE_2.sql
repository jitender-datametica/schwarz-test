CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_l_pruefkatalog_code_2 AS SELECT mandant_id,
 katalogart_id,
 codegruppe_id,
 werk_id,
 pruefcode_id,
 auswahlmenge,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_l_pruefkatalog_code_2;