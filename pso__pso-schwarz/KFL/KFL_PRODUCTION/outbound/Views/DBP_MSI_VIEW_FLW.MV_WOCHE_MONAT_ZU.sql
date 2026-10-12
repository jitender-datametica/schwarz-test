CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_woche_monat_zu (pjmo, akt_mo, pjwo) AS SELECT kjmo AS pjmo,
 akt_mo,
 pjwo
FROM kfl_production_dbp_view.v_tag AS V01
GROUP BY pjmo,
 akt_mo,
 pjwo
HAVING COUNT(dat) > 3;