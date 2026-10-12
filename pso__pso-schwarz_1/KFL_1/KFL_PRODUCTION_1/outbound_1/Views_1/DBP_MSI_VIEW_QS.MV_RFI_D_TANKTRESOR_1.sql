CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_qs.mv_rfi_d_tanktresor_1 (mandant_id, wup_id, nb_id, dat, rfi_datum,
rfi_fehlergrund, de_umsatz_netto_tank, de_umsatz_brutto_tank) AS SELECT 1 AS mandant_id,
 ROUND(CAST(T01.marktnummer AS BIGNUMERIC), 0) AS wup_id,
 V01.nb_id,
 PARSE_DATE('%F', T01.datum) AS dat,
 T01.rfi_datum,
 T01.rfi_fehlergrund,
  CASE
  WHEN T01.schluessel2 = 'UMSNET'
  THEN SUM(ROUND(CAST(T01.wert AS NUMERIC), 2))
  ELSE 0
  END AS de_umsatz_netto_tank,
  CASE
  WHEN T01.schluessel2 IN ('UMSNET', 'UMSMWST')
  THEN SUM(ROUND(CAST(T01.wert AS NUMERIC), 2))
  ELSE 0
  END AS de_umsatz_brutto_tank
FROM kfl_production_dbp_rfi.d_tanktresor_1 AS T01
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V01 ON CAST(T01.marktnummer AS FLOAT64) = V01.wup_id AND V01.mandant_id = 1
   
GROUP BY V01.mandant_id,
 T01.marktnummer,
 V01.nb_id,
 T01.datum,
 T01.rfi_datum,
 T01.rfi_fehlergrund,
 T01.schluessel2;