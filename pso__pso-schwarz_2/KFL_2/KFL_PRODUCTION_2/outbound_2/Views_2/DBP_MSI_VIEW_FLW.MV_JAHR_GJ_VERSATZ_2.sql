CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_jahr_gj_versatz_2 (gj, akt_gj, akt_gj_komplett, akt_gj_versatz)
AS SELECT v_jahr_gj.gj,
 v_jahr_gj.akt_gj,
 v_jahr_gj.akt_gj_komplett,
  v_jahr_gj.akt_gj + m.maerz_fg AS akt_gj_versatz
FROM kfl_production_dbp_view.v_jahr_gj_2
 INNER JOIN (SELECT CASE
    WHEN mo_gj = 1
    THEN 1
    ELSE 0
    END AS maerz_fg
  FROM kfl_production_dbp_view.v_monat_2
  WHERE akt_mo = 0) AS m ON TRUE;