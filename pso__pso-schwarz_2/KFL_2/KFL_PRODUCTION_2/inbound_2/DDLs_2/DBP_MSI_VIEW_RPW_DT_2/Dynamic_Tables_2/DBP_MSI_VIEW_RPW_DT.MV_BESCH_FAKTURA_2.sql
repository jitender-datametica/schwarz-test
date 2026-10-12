create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_BESCH_FAKTURA_2(
	MANDANT_ID,
	FAKTURA_BELEG_ID,
	WRG_ID,
	DAT_FAKTURA,
	FAKTURAART_ID,
	FAKTURA_STATUS_ID,
	VERKAUFSORGANISATION_ID,
	KALK_SCHEMA_ID,
	AUFTRAGGEBER_ID,
	STORNO_FG,
	DAT_ERSTELLUNG,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
          SELECT
          mandant_id,
          faktura_beleg_id,
          wrg_id,
          dat_faktura,
          fakturaart_id,
          faktura_status_id,
          verkaufsorganisation_id,
          kalk_schema_id,
          CAST(TRY_TO_NUMERIC(auftraggeber_id) AS VARCHAR (10)) AS auftraggeber_id -- wegen IWT gecastet
          ,
          storno_fg,
          dat_erstellung,
          7
          FROM dbp_view.v_besch_faktura_2
          WHERE mandant_id = 1
          AND fakturaart_id NOT IN ('ZIWU', 'ZIWV');
