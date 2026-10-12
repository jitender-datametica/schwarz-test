CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_hwg_wg_zu_per (hwg_id, owg_id, wg_id, mandant_id, dat_von,
dat_bis, arthiertyp_id) AS SELECT v01.hwg_id,
 v02.owg_id,
 v03.wg_id,
 v01.mandant_id,
 v01.dat_von,
 v01.dat_bis,
 v01.arthiertyp_id
FROM kfl_production_dbp_view.v_hwg_per AS v01
 INNER JOIN kfl_production_dbp_view.v_owg_per AS v02 ON v01.mandant_id = v02.mandant_id AND v01.hwg_id = v02.hwg_id AND
   CURRENT_DATE BETWEEN v02.dat_von AND v02.dat_bis
 INNER JOIN kfl_production_dbp_view.v_wg_per AS v03 ON v02.mandant_id = v03.mandant_id AND v02.owg_id = v03.owg_id AND
   CURRENT_DATE BETWEEN v03.dat_von AND v03.dat_bis
WHERE v01.mandant_id = 1
 AND CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis;