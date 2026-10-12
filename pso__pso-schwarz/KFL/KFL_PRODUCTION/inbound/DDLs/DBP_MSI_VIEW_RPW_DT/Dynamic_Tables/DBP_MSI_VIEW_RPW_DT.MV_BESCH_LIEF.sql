create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_BESCH_LIEF(
	MANDANT_ID,
	LIEF_BELEG_ID,
	WUP_ID,
	NB_ID,
	VERSANDSTELLE_ID,
	VERKAUFSORGANISATION_ID,
	LIEF_TYP_ID,
	DAT_LIEF_SOLL,
	VERTR_BELEG_TYP_ID,
	LIEF_PAL_TYP_ID,
	LAGERHIERARCHIE_ID,
	KUNDE_ID,
	AUFTRAGGEBER_ID,
	ANZAHL_PACKSTUECK,
	WERBEWARE_ID,
	DAT_LAGERBEW_IST,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
             SELECT
             mandant_id,
             lief_beleg_id,
             wup_id,
             nb_id,
             versandstelle_id,
             verkaufsorganisation_id,
             lief_typ_id,
             dat_lief_soll,
             vertr_beleg_typ_id,
             lief_pal_typ_id,
             lagernummer_id,
             kunde_id,
             auftraggeber_id,
             anzahl_packstueck,
             werbeware_id,
             dat_lagerbew_ist,
             7
             FROM dbp_view.v_besch_lief
             WHERE mandant_id = 1;
