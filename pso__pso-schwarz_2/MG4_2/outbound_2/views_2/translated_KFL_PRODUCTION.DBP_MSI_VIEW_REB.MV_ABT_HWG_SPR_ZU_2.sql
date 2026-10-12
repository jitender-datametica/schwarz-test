CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_abt_hwg_spr_zu_2 (abt_id, abt_bez, hwg_id, hwg_bez, mandant_id,
arthiertyp_id, spr_id) AS SELECT v01.abt_id,
 v02.abt_bez,
 v03.hwg_id,
 v04.hwg_bez,
 v01.mandant_id,
 v01.arthiertyp_id,
 v02.spr_id
FROM kfl_production_dbp_view.v_abt_2 AS v01
 INNER JOIN kfl_production_dbp_view.v_abt_spr_zu_2 AS v02 ON v01.mandant_id = v02.mandant_id AND v01.abt_id = v02.abt_id
  AND v02.spr_id = 22
 INNER JOIN kfl_production_dbp_view.v_hwg_per_2 AS v03 ON v01.mandant_id = v03.mandant_id AND v01.abt_id = v03.abt_id AND
   CURRENT_DATE BETWEEN v03.dat_von AND v03.dat_bis
 INNER JOIN kfl_production_dbp_view.v_hwg_spr_zu_2 AS v04 ON v03.mandant_id = v04.mandant_id AND v03.hwg_id = v04.hwg_id
  AND v04.spr_id = 22
WHERE v01.mandant_id = 1;