CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_lagerort_spr_zu_cz_2 (mandant_id, spr_id, werks, nb_id, lgort,
lagerort_bez) AS SELECT mandant_id,
 spr_id,
 wup_id AS werks,
 nb_id,
 lagerort_id AS lgort,
 lagerort_bez
FROM kfl_production_dbp_view.v_lagerort_spr_zu_2 AS V01
WHERE spr_id = 124;