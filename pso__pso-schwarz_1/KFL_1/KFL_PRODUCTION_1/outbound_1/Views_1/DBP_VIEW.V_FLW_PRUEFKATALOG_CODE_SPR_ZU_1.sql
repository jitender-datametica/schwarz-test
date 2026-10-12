CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_pruefkatalog_code_spr_zu_1 AS SELECT mandant_id,
 katalogart_id,
 codegruppe_id,
 pruefcode_id,
 version_id,
 spr_id,
 pruefkatalog_code_bez,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_pruefkatalog_code_spr_zu_1;