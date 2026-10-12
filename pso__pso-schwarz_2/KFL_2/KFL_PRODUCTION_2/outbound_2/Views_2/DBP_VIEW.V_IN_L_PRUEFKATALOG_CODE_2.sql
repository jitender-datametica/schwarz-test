CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_l_pruefkatalog_code_2 AS SELECT mandant_id,
 katalogart_id,
 codegruppe_id,
 pruefcode_id,
 version_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_l_pruefkatalog_code_2;