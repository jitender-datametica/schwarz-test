create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BESCH_FAKTURA(
	AUFTRAGGEBER_ID,
	DAT_FAKTURA,
	FAKTURA_BELEG_ID,
	FAKTURA_STATUS_ID,
	FAKTURAART_ID,
	KALK_SCHEMA_ID,
	MANDANT_ID,
	STORNO_FG,
	VERKAUFSORGANISATION_ID,
	WRG_ID,
	DAT_ERSTELLUNG
) as
   SELECT
  CAST(TRY_TO_NUMBER(auftraggeber_id,38,0) AS VARCHAR (10)) AS auftraggeber_id, dat_faktura, faktura_beleg_id, faktura_status_id, fakturaart_id, kalk_schema_id, mandant_id, storno_fg, verkaufsorganisation_id, wrg_id, dat_erstellung
   FROM dbp_view.v_besch_faktura;