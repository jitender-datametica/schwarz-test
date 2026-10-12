CREATE OR REPLACE VIEW kfl_production_dbp_view.v_saison_spr_zu_2 (mandant_id, saison_id, spr_id, saison_bez, td_update,
td_insert) AS SELECT mandant_id,
 saison_id,
 spr_id,
 saison_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.saison_spr_zu_2;