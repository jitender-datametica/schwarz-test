CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_abt_hwg_zu_per_1 (abt_id, hwg_id, mandant_id, dat_von, dat_bis,
arthiertyp_id) AS SELECT v01.abt_id,
 v02.hwg_id,
 v01.mandant_id,
 v02.dat_von,
 v02.dat_bis,
 v01.arthiertyp_id -- abt_id

FROM kfl_production_dbp_view.v_abt_1 AS v01
 INNER JOIN kfl_production_dbp_view.v_hwg_per_1 AS v02 ON v01.mandant_id = v02.mandant_id AND v01.abt_id = v02.abt_id AND
   CURRENT_DATE BETWEEN v02.dat_von AND v02.dat_bis
WHERE v01.mandant_id = 1;