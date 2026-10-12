CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_hwg_wg_spr_zu_2 (hwg_id, hwg_bez, owg_id, owg_bez, wg_id, wg_bez
, mandant_id, arthiertyp_id, spr_id) AS SELECT v01.hwg_id,
 v02.hwg_bez,
 v03.owg_id,
 v04.owg_bez,
 v05.wg_id,
 v06.wg_bez,
 v01.mandant_id,
 v01.arthiertyp_id,
 v02.spr_id
FROM kfl_production_dbp_view.v_hwg_per_2 AS v01
 INNER JOIN kfl_production_dbp_view.v_hwg_spr_zu_2 AS v02 ON v01.mandant_id = v02.mandant_id AND v01.hwg_id = v02.hwg_id
  AND v02.spr_id = 22
 INNER JOIN kfl_production_dbp_view.v_owg_per_2 AS v03 ON v01.mandant_id = v03.mandant_id AND v01.hwg_id = v03.hwg_id AND
   CURRENT_DATE BETWEEN v03.dat_von AND v03.dat_bis
 INNER JOIN kfl_production_dbp_view.v_owg_spr_zu_2 AS v04 ON v03.mandant_id = v04.mandant_id AND v03.owg_id = v04.owg_id
  AND v04.spr_id = 22
 INNER JOIN kfl_production_dbp_view.v_wg_per_2 AS v05 ON v03.mandant_id = v05.mandant_id AND v03.owg_id = v05.owg_id AND
   CURRENT_DATE BETWEEN v05.dat_von AND v05.dat_bis
 INNER JOIN kfl_production_dbp_view.v_wg_spr_zu_2 AS v06 ON v05.mandant_id = v06.mandant_id AND v05.wg_id = v06.wg_id AND
   v06.spr_id = 22
WHERE v01.mandant_id = 1
 AND CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis;