CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_werbewoche_werbemonat_zu_1 (mandant_id, kjwo, akt_mo, kjmo) AS
SELECT w.mandant_id,
 w.kjwo,
 M.akt_mo,
 w.kjmo
FROM (SELECT mandant_id,
   kjwo,
   MAX(kjmo) AS kjmo
  FROM kfl_production_dbp_view.v_werbe_typ_woche_zu_1
  GROUP BY mandant_id,
   kjwo) AS w
 INNER JOIN kfl_production_dbp_view.v_monat_1 AS M ON w.kjmo = M.kjmo;