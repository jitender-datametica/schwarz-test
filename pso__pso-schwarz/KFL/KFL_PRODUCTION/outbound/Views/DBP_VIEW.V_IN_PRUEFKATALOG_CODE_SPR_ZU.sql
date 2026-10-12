CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_pruefkatalog_code_spr_zu AS SELECT mandant_id,
 katalogart_id,
 codegruppe_id,
 pruefcode_id,
 version_id,
 spr_id,
 qtxt_code,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_pruefkatalog_code_spr_zu;