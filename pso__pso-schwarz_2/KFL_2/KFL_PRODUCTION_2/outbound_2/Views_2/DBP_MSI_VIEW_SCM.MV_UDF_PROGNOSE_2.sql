CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_udf_prognose_2 AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 dat,
 dat_prognoselauf,
 menge_prognose_sa AS menge_prognose_udf_sa,
 menge_prognose_af AS menge_prognose_udf_aa,
  CASE
  WHEN menge_prognose_sa IS NULL AND menge_prognose_af IS NULL
  THEN NULL
  ELSE COALESCE(menge_prognose_sa, 0) + COALESCE(menge_prognose_af, 0)
  END AS menge_prognose_udf,
 menge_prognose_gesteuert AS menge_prognose_udf_gesteuert
FROM kfl_production_dbp_view.v_udf_prognose_2 AS P
WHERE diagnose_id = '';