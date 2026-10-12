CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_art_wup_autodispo_tag_exp_1 (mandt, country_1, loc,
loc_cluster, prod, prod_cluster, dif_type, tstfr, tstto, dif_value, function, dif_desc) AS SELECT ABS(M.mandant_sap_id)
 AS mandt,
  CASE
  WHEN M.mandant_kbez = 'D'
  THEN 'DE'
  ELSE M.mandant_kbez
  END AS country_1,
 DIF.kunde_id AS loc,
 ' ' AS loc_cluster,
 A.kl_art_id AS prod,
 ' ' AS prod_cluster,
  CASE
  WHEN DT.dif_typ_id = 1 AND DIF.dif_mult_exp <> 1
  THEN 'Multiplicative'
  WHEN DT.dif_typ_id = 2 AND COALESCE(DIF.dif_add_exp, 0) <> 0
  THEN 'Additive'
  WHEN DT.dif_typ_id = 3 AND COALESCE(DIF.dif_abs_exp, 0) <> 0
  THEN 'Absolute'
  ELSE NULL
  END AS dif_type,
 DIF.dat AS tstfr,
 DIF.dat AS tstto,
 ROUND(CAST(CASE
    WHEN DT.dif_typ_id = 1
    THEN DIF.dif_mult_exp * 100 - 100
    WHEN DT.dif_typ_id = 2
    THEN CAST(DIF.dif_add_exp AS FLOAT64)
    WHEN DT.dif_typ_id = 3
    THEN DIF.dif_abs_exp
    ELSE NULL
    END AS NUMERIC), 5) AS dif_value,
 'I' AS function,
 CAST(CASE
   WHEN DT.dif_typ_id = 1 AND DIF.anz_dif_mult_exp = 1
   THEN DIF.dif_komm_mult
   WHEN DT.dif_typ_id = 2 AND DIF.anz_dif_add_exp = 1
   THEN DIF.dif_komm_add
   WHEN DT.dif_typ_id = 3 AND DIF.anz_dif_abs_exp = 1
   THEN DIF.dif_komm_abs
   ELSE 'Mehrere DIFs -DWH-'
   END AS STRING) AS dif_desc
FROM kfl_production_dbp_msi_view_scm_materialized.mv_art_wup_autodispo_tag_dif_bme_1 AS DIF
 INNER JOIN kfl_production_dbp_view.v_l_dif_typ_1 AS DT ON CASE
   WHEN DT.dif_typ_id = 1 AND DIF.dif_mult_exp <> 1
   THEN 'Multiplicative'
   WHEN DT.dif_typ_id = 2 AND COALESCE(DIF.dif_add_exp, 0) <> 0
   THEN 'Additive'
   WHEN DT.dif_typ_id = 3 AND COALESCE(DIF.dif_abs_exp, 0) <> 0
   THEN 'Absolute'
   ELSE NULL
   END IS NOT NULL AND DIF.dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 180 DAY) AND (DATE_ADD(CURRENT_DATE, INTERVAL 101
     DAY))
 INNER JOIN kfl_production_dbp_view.v_art_1 AS A ON DIF.art_id = A.art_id AND DIF.mandant_id = A.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS M ON DIF.mandant_id = M.mandant_id;