CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_gp_zusatz_per_1 (mandant_id, gp_id, einkaufsorganisation_id,
dat_von, entgelt_mind_kz, ret_sperrprofil_id, system_id, dat_bis) AS SELECT mandant_id,
 gp_id,
 einkaufsorganisation_id,
 dat_von,
 entgelt_mind_kz,
 ret_sperrprofil_id,
 7 AS system_id,
 dat_bis
FROM kfl_production_dbp_view.v_gp_zusatz_per_1
WHERE (gp_id, mandant_id, dat_bis) IN (SELECT (gp_id, mandant_id, MAX(dat_bis))
   FROM kfl_production_dbp_view.v_gp_zusatz_per_1
   WHERE mandant_id = 1
   GROUP BY gp_id,
    mandant_id);