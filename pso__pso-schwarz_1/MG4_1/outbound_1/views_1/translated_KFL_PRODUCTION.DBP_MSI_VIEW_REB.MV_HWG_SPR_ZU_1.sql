CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_hwg_spr_zu_1 (hwg_id, hwg_bez, mandant_id, arthiertyp_id, spr_id
) AS SELECT v01.hwg_id,
 v02.hwg_bez,
 v01.mandant_id,
 v01.arthiertyp_id,
 v02.spr_id
FROM kfl_production_dbp_view.v_hwg_per_1 AS v01
 INNER JOIN kfl_production_dbp_view.v_hwg_spr_zu_1 AS v02 ON v01.mandant_id = v02.mandant_id AND v01.hwg_id = v02.hwg_id
  AND v02.spr_id = 22
WHERE v01.mandant_id = 1
 AND CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis;