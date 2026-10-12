CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_lgort_spr_zu (lagerort_bez, lagerort_id, mandant_id, nb_id,
spr_id) AS SELECT lagerort_bez,
 lagerort_id,
 mandant_id,
 nb_id,
 spr_id
FROM kfl_production_dbp_view.v_lagerort_spr_zu
WHERE wup_id IN (6902, 6903, 6905, 6906, 6907, 6908)
 AND nb_id = - 111
 AND spr_id = 22
 AND lagerort_id NOT IN ('-1', '-2', '-3')
GROUP BY lagerort_bez,
 lagerort_id,
 mandant_id,
 nb_id,
 spr_id;