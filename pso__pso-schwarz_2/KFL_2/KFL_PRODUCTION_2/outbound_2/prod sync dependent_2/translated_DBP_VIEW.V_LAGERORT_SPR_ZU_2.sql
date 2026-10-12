CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lagerort_spr_zu_2 (mandant_id, lagerort_id, wup_id, nb_id, spr_id,
lagerort_bez) AS SELECT mandant_id,
 lagerort_id,
 wup_id,
 nb_id,
 spr_id,
 lagerort_bez
FROM kfl_production_dbp_data.lagerort_spr_zu_2;