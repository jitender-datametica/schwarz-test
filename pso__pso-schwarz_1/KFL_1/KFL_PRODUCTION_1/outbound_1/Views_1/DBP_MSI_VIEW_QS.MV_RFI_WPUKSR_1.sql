CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_qs.mv_rfi_wpuksr_1 (mandant_id, wup_id, nb_id, dat, rfi_datum,
rfi_fehlergrund, anz_bon_rfi) AS SELECT T01.mandant_id,
 ROUND(CAST(T01.filiale AS BIGNUMERIC), 0) AS wup_id,
 V01.nb_id,
 PARSE_DATE('%Y%m%d', T01.belegdatum) AS dat,
 T01.rfi_datum,
 T01.rfi_fehlergrund,
 SUM(ROUND(CAST(T01.azbon AS BIGNUMERIC), 0)) AS anz_bon_rfi
FROM kfl_production_dbp_rfi.wpuksr_1 AS T01
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V01 ON CAST(T01.filiale AS FLOAT64) = V01.wup_id AND T01.mandant_id = V01.mandant_id
   
GROUP BY T01.mandant_id,
 wup_id,
 V01.nb_id,
 dat,
 T01.rfi_datum,
 T01.rfi_fehlergrund;