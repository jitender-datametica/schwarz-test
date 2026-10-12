CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_ref_woche (kjwo, kjwo_ref, abstand) AS SELECT W1.kjwo,
 W2.kjwo AS kjwo_ref,
  W1.akt_wo_kalendarisch - W2.akt_wo_kalendarisch AS abstand
FROM kfl_production_dbp_msi_view2.mv_woche AS W1
 INNER JOIN kfl_production_dbp_msi_view2.mv_woche AS W2 ON TRUE;