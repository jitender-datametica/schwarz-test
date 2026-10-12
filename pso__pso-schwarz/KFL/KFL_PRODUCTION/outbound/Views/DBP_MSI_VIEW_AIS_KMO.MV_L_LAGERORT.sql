CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_lagerort (lagerort_id, mandant_id, nb_id, wup_id,
lagernummer_id) AS SELECT lagerort_id,
 mandant_id,
 nb_id,
 wup_id,
 lagernummer_id
FROM kfl_production_dbp_view.v_l_lagerort
WHERE mandant_id <> 1
 AND lagerort_id NOT IN ('-1', '-2', '-3');