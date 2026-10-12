CREATE OR REPLACE VIEW kfl_production_dbp_view.v_platzierungsstufe_spr_zu_2 AS SELECT mandant_id,
 platzierungsstufe_id,
 spr_id,
 platzierungsstufe_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.platzierungsstufe_spr_zu_2;