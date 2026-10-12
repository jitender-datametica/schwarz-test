CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_lagerort_spr_zu_2 (lagerort_bez, lagerort_id, mandant_id, nb_id,
spr_id, wup_id) AS SELECT CAST(wup_id AS STRING) || ' ' || lagerort_bez AS lagerort_bez,
 lagerort_id,
 mandant_id,
 nb_id,
 spr_id,
 wup_id
FROM kfl_production_dbp_view.v_lagerort_spr_zu_2 AS V01
WHERE mandant_id = 1
 AND lagerort_id NOT IN ('-1', '-2', '-3');