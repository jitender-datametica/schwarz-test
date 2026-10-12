CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_qs.mv_rfi_d_tankkunden_2 (mandant_id, wup_id, nb_id, dat, rfi_datum,
rfi_fehlergrund, de_kundenzahl) AS SELECT 1 AS mandant_id,
 ROUND(CAST(T01.marktnummer AS BIGNUMERIC), 0) AS wup_id,
 V01.nb_id,
 PARSE_DATE('%F', T01.datum) AS dat,
 T01.rfi_datum,
 T01.rfi_fehlergrund,
 SUM(ROUND(CAST(T01.wert AS BIGNUMERIC), 0)) AS de_kundenzahl
FROM kfl_production_dbp_rfi.d_tankkunden_2 AS T01
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS V01 ON CAST(T01.marktnummer AS FLOAT64) = V01.wup_id AND V01.mandant_id = 1
   
WHERE T01.schluessel2 = 'KUNDEN_GESAMT'
GROUP BY mandant_id,
 wup_id,
 V01.nb_id,
 dat,
 T01.rfi_datum,
 T01.rfi_fehlergrund;