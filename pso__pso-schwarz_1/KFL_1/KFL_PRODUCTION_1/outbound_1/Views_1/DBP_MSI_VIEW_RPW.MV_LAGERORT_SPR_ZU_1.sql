CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_lagerort_spr_zu_1 (wup_id, mandant_id, lagerort_id, nb_id,
spr_id, lagerort_bez, system_id) AS SELECT wup_id,
 mandant_id,
 lagerort_id,
 nb_id,
 spr_id,
 lagerort_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_lagerort_spr_zu_1
WHERE mandant_id = 1
 AND spr_id = 22;