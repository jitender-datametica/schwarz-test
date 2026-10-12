CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_lagerort_1 (mandant_id, lagerort_id, wup_id, nb_id, system_id
) AS SELECT mandant_id,
 lagerort_id,
 wup_id,
 nb_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_lagerort_1
WHERE mandant_id = 1;