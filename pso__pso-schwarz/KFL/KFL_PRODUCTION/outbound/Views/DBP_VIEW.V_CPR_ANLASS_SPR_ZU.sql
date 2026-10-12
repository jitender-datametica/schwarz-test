CREATE OR REPLACE VIEW kfl_production_dbp_view.v_cpr_anlass_spr_zu AS SELECT projekt_anlass_id,
 spr_id,
 projekt_anlass_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.cpr_anlass_spr_zu;