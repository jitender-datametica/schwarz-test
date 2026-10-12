CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_konzept_fisch_spr_zu_1 AS SELECT T01.rpm_feld_auspr_id AS
 bed_fisch_id,
  CASE
  WHEN T01.rpm_feld_auspr_id = 1
  THEN ''
  ELSE T01.rpm_feld_auspr_bez
  END AS bed_fisch_bez
FROM kfl_production_dbp_view.v_rpm_feld_auspr_spr_zu_1 AS T01
 INNER JOIN kfl_production_dbp_view.v_l_rpm_feld_1 AS T02 ON T01.rpm_feld_id = T02.rpm_feld_id
WHERE T02.rpm_feld_bez = 'ZPPM_FISCH'
 AND T01.rpm_tab_id = 1
 AND T01.spr_id = 22;