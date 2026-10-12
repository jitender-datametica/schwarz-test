CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_lagerort_1 (lagerort_id, mandant_id, nb_id, wup_id,
lagernummer_id) AS SELECT lagerort_id,
 mandant_id,
 nb_id,
 wup_id,
 lagernummer_id
FROM kfl_production_dbp_view.v_l_lagerort_1
WHERE mandant_id = 1
 AND lagerort_id NOT IN ('-1', '-2', '-3');