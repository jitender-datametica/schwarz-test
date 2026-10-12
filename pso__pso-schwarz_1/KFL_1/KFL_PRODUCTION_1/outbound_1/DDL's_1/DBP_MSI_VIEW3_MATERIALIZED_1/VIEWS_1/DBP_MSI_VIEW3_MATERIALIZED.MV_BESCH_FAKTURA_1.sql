CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_besch_faktura_1 (auftraggeber_id, dat_faktura,
faktura_beleg_id, faktura_status_id, fakturaart_id, kalk_schema_id, mandant_id, storno_fg, verkaufsorganisation_id,
wrg_id, dat_erstellung) AS SELECT CAST(ROUND(SAFE_CAST(auftraggeber_id AS BIGNUMERIC), 0) AS STRING) AS auftraggeber_id
 ,
 dat_faktura,
 faktura_beleg_id,
 faktura_status_id,
 fakturaart_id,
 kalk_schema_id,
 mandant_id,
 storno_fg,
 verkaufsorganisation_id,
 wrg_id,
 dat_erstellung
FROM kfl_production_dbp_view.v_besch_faktura_1;