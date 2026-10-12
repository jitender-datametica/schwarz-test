CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_ref_woche (kjwo, kjwo_ref, kjwo_abstand) AS SELECT V01.kjwo
 ,
 V02.kjwo AS kjwo_ref,
  V01.akt_kjwo_kalendarisch - V02.akt_kjwo_kalendarisch AS kjwo_abstand
FROM kfl_production_dbp_msi_view_ais_kmo.mv_woche AS V01
 INNER JOIN kfl_production_dbp_msi_view_ais_kmo.mv_woche AS V02 ON TRUE;