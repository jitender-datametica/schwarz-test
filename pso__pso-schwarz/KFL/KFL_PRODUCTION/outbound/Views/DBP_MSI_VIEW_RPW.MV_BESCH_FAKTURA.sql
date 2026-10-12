CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_besch_faktura (mandant_id, faktura_beleg_id, wrg_id,
dat_faktura, fakturaart_id, faktura_status_id, verkaufsorganisation_id, kalk_schema_id, auftraggeber_id, storno_fg,
dat_erstellung, system_id) AS SELECT mandant_id,
 faktura_beleg_id,
 wrg_id,
 dat_faktura,
 fakturaart_id,
 faktura_status_id,
 verkaufsorganisation_id,
 kalk_schema_id,
 CAST(ROUND(SAFE_CAST(auftraggeber_id AS BIGNUMERIC), 0) AS STRING) AS auftraggeber_id,
 storno_fg,
 dat_erstellung,
 7 AS system_id
FROM kfl_production_dbp_view.v_besch_faktura
WHERE mandant_id = 1
 AND fakturaart_id NOT IN ('ZIWU', 'ZIWV');