CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_tage_pro_monat_1 (kjmo, tage) AS SELECT kjmo,
 COUNT(dat) AS tage
FROM kfl_production_dbp_view.v_tag_1
GROUP BY kjmo;