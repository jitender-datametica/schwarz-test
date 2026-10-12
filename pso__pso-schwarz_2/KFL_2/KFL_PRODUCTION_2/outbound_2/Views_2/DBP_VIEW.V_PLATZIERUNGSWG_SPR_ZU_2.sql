CREATE OR REPLACE VIEW kfl_production_dbp_view.v_platzierungswg_spr_zu_2 AS SELECT mandant_id,
 platzierungswg_id,
 spr_id,
 platzierungswg_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.platzierungswg_spr_zu_2;