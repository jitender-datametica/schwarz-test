CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_quartal_gj_kum_zu AS SELECT V01.gjqu AS gjqu_kum,
 V02.gjqu
FROM kfl_production_dbp_view.v_monat AS V01
 INNER JOIN kfl_production_dbp_view.v_monat AS V02 ON V01.akt_gjqu BETWEEN V02.akt_gjqu AND (V02.akt_gjqu + 3)
GROUP BY gjqu_kum,
 V02.gjqu;