CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_konzept_fisch_spr_zu_pl_1 AS SELECT DE1.rpm_feld_auspr_id AS
 bed_fisch_id,
  CASE
  WHEN DE1.rpm_feld_auspr_id = 1
  THEN ''
  ELSE COALESCE(ls.rpm_feld_auspr_bez, DE1.rpm_feld_auspr_bez)
  END AS bed_fisch_bez
FROM kfl_production_dbp_view.v_rpm_feld_auspr_spr_zu_1 AS DE1
 INNER JOIN kfl_production_dbp_view.v_l_rpm_feld_1 AS DE2 ON DE1.rpm_feld_id = DE2.rpm_feld_id
 LEFT JOIN (SELECT LS1.rpm_feld_auspr_id,
   LS1.rpm_feld_auspr_bez
  FROM kfl_production_dbp_view.v_rpm_feld_auspr_spr_zu_1 AS LS1
   INNER JOIN kfl_production_dbp_view.v_l_rpm_feld_1 AS LS2 ON LS1.rpm_feld_id = LS2.rpm_feld_id
  WHERE LS1.spr_id = 90
   AND LS2.rpm_feld_bez = 'ZPPM_FISCH'
   AND LS1.rpm_tab_id = 1) AS ls ON DE1.rpm_feld_auspr_id = ls.rpm_feld_auspr_id
WHERE DE1.spr_id = 22
 AND DE2.rpm_feld_bez = 'ZPPM_FISCH'
 AND DE1.rpm_tab_id = 1;