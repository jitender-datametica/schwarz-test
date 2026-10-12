CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_l_lagerort_1 AS SELECT lagerort_id,
 mandant_id,
 nb_id,
 wup_id,
 COALESCE(lagernummer_id, '-99') AS lagernummer_id
FROM kfl_production_dbp_view.v_l_lagerort_1
WHERE lagerort_id NOT IN ('-1', '-2', '-3');